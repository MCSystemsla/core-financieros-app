# SPEC 01 — Servicio para convertir imágenes de cámara en un PDF

> **Status:** Implemented
> **Depends on:** —
> **Date:** 2026-10-06
> **Objective:** Crear un servicio compartido que recibe una lista de rutas de imágenes tomadas con la cámara y genera un único archivo `.pdf` persistente, listo para enviarse al expediente digital.

## Por qué existe esta spec

El expediente digital va a exigir los documentos en formato `.pdf`. Hoy la app solo sube imágenes `.jpg` sueltas (por ejemplo `subir-fotos-cedula` en `solicitudes_credito_hn_repository.dart`). El endpoint que recibirá el PDF todavía no existe en backend. Por eso esta spec cubre solo la pieza reutilizable que concatena imágenes en un PDF. El envío y la UI se definen después, cuando el endpoint exista.

## Scope

**In:**

- Agregar la dependencia `pdf` (paquete puro Dart de DavBfr) a `pubspec.yaml`.
- Crear `lib/src/config/services/pdf/images_to_pdf_service.dart` con la clase estática `ImagesToPdfService`.
- Método `ImagesToPdfService.generate(...)`: recibe `List<String>` de rutas locales y un `fileName`, y devuelve el `File` del PDF generado.
- Método `ImagesToPdfService.deletePdf(...)`: borra un PDF generado previamente.
- Una imagen por página, página A4, imagen escalada para caber dentro del margen, centrada y sin recorte.
- El orden de las páginas es el orden de la lista recibida.
- Cada imagen se redimensiona a un lado máximo de 1600 px y se recodifica como JPG calidad 75 antes de entrar al PDF.
- El procesamiento pesado (decodificar, redimensionar, construir el PDF) corre fuera del hilo de UI con `Isolate.run`.
- El PDF se guarda en `getApplicationDocumentsDirectory()/expediente_pdfs/<fileName>.pdf`. Si ya existe un archivo con ese nombre, se sobrescribe.
- Crear `ImagesToPdfException` en `lib/src/domain/exceptions/images_to_pdf_exception.dart`.
- Si la lista está vacía, o una imagen no existe o no se puede decodificar, se lanza `ImagesToPdfException` y no se escribe ningún PDF.
- Primer test unitario del repo: `test/config/services/pdf/images_to_pdf_service_test.dart`.
- Funciona igual para Honduras, Nicaragua y Costa Rica (sin split `hn`/`ni`, sin `FlavorCubit`).

**Out of scope (para futuras specs):**

- Endpoint, repository y cubit para subir el PDF al expediente (el endpoint aún no existe en backend).
- Pantalla o widget para capturar varias fotos, reordenarlas, previsualizarlas o eliminarlas.
- Previsualizar, imprimir o compartir el PDF (paquete `printing`).
- Persistir en ObjectBox/Isar la referencia al PDF para reintentos offline.
- Limpieza automática de PDFs viejos o huérfanos en `expediente_pdfs/`.
- Varias imágenes por página, encabezados, pie de página, metadatos o texto en el PDF.
- Cambiar `CameraService` o el flujo actual de fotos de cédula.

## Data model

```dart
// lib/src/config/services/pdf/images_to_pdf_service.dart
class ImagesToPdfService {
  static const int maxImageDimension = 1600;
  static const int jpgQuality = 75;
  static const String pdfDirectoryName = 'expediente_pdfs';

  /// Genera `<outputDirectory ?? Documents/expediente_pdfs>/<fileName>.pdf`.
  static Future<File> generate({
    required List<String> imagePaths,
    required String fileName,      // sin extensión, ej. 'expediente_12345'
    Directory? outputDirectory,    // solo para tests; en la app se omite
  });

  /// Borra el PDF si existe. No falla si ya no existe.
  static Future<void> deletePdf(File pdf);
}
```

```dart
// lib/src/domain/exceptions/images_to_pdf_exception.dart
class ImagesToPdfException implements Exception {
  final String message;
  final String? imagePath; // ruta de la imagen culpable, si aplica
  const ImagesToPdfException(this.message, {this.imagePath});
}
```

Convenciones:

- Tamaño de página: `PdfPageFormat.a4`, orientación vertical, margen de 20 pt en los cuatro lados.
- La imagen usa `BoxFit.contain` dentro del área útil de la página.
- Se aplica `img.bakeOrientation` antes de redimensionar, para respetar el EXIF.
- Una imagen cuyo lado mayor ya mide 1600 px o menos no se agranda; solo se recodifica.
- `fileName` vacío o con `/` o `\` lanza `ImagesToPdfException`.

## Implementation plan

1. Agregar `pdf` a `dependencies` en `pubspec.yaml` y correr `flutter pub get`. Verificar que `flutter analyze` sigue sin errores nuevos.
2. Crear `lib/src/domain/exceptions/images_to_pdf_exception.dart` con `ImagesToPdfException`.
3. Crear `lib/src/config/services/pdf/images_to_pdf_service.dart` con las constantes y un helper privado que, a partir de una ruta, valida que el archivo exista, lo decodifica con el paquete `image`, aplica `bakeOrientation`, redimensiona a 1600 px de lado máximo y devuelve los bytes JPG calidad 75. Si falla, lanza `ImagesToPdfException` con `imagePath`.
4. Agregar un helper privado que recibe la lista de bytes JPG y construye el documento con `pw.Document`: una `pw.Page` A4 por imagen, margen 20 pt, `pw.Image` centrada con `BoxFit.contain`. Devuelve `Uint8List` con `doc.save()`.
5. Implementar `generate`: valida la lista y el `fileName`, corre los pasos 3 y 4 dentro de `Isolate.run`, resuelve el directorio de salida (`outputDirectory` o `Documents/expediente_pdfs`, que se crea si no existe) y escribe `<fileName>.pdf` sobrescribiendo.
6. Implementar `deletePdf`: borra el archivo si existe.
7. Crear `test/config/services/pdf/images_to_pdf_service_test.dart`. Las imágenes de prueba se generan dentro del test con el paquete `image` y se escriben en un directorio temporal (`Directory.systemTemp.createTemp`), que también se pasa como `outputDirectory`. Casos: 3 imágenes generan un PDF; lista vacía lanza excepción; ruta inexistente lanza excepción con esa `imagePath`; archivo no imagen lanza excepción; `deletePdf` borra el archivo.
8. Actualizar `CLAUDE.md`: mencionar `ImagesToPdfService` en `config/` y cambiar la línea "No test suite exists in this repo currently." para indicar que existe `test/` y se corre con `flutter test`.

## Acceptance criteria

- [x] `pubspec.yaml` incluye el paquete `pdf` y no incluye `printing` ni `syncfusion_flutter_pdf`.
- [x] `flutter analyze` no reporta issues nuevos en los archivos creados.
- [x] `flutter test` pasa todos los casos de `images_to_pdf_service_test.dart`.
- [x] Con 3 imágenes, `generate` devuelve un `File` que existe y cuyos primeros bytes son `%PDF`.
- [x] El PDF generado con 3 imágenes tiene exactamente 3 páginas (el test cuenta las ocurrencias de `/Type /Page` sin contar `/Pages`).
- [x] El orden de las páginas coincide con el orden de `imagePaths`.
- [x] Con una lista vacía, `generate` lanza `ImagesToPdfException` y no crea ningún archivo.
- [x] Con una ruta que no existe, `generate` lanza `ImagesToPdfException` cuyo `imagePath` es esa ruta, y no crea ningún archivo.
- [x] Con un archivo que no es imagen, `generate` lanza `ImagesToPdfException` y no crea ningún archivo.
- [x] Llamar `generate` dos veces con el mismo `fileName` deja un solo archivo, con el contenido de la segunda llamada.
- [x] Sin `outputDirectory`, el PDF queda en `<Documents>/expediente_pdfs/<fileName>.pdf` (verificado manualmente en un dispositivo Android).
- [x] Generar un PDF con 5 fotos reales de la cámara no congela la UI (verificado manualmente en un dispositivo Android).
- [x] Después de `deletePdf`, el archivo ya no existe, y llamarlo otra vez no lanza error.
- [x] Ningún archivo nuevo vive bajo `hn/` o `ni/`, ni lee `FlavorCubit`.

## Decisions

- **Sí:** solo el servicio de generación en esta spec. El endpoint del expediente no existe aún; mezclar el envío obligaría a inventar el contrato.
- **No:** envío y UI en esta spec. Van en specs separadas cuando backend defina el endpoint.
- **Sí:** paquete `pdf` (DavBfr). Puro Dart, sin código nativo, ampliamente usado.
- **No:** `syncfusion_flutter_pdf`. Requiere licencia comercial.
- **No:** `printing`. No se necesita previsualizar ni compartir todavía.
- **Sí:** entrada `List<String>` de rutas. `CameraService.takeAndsavePhoto` ya devuelve la ruta local.
- **No:** `List<XFile>` o `List<File>`. Acoplan el servicio a un paquete o fuerzan conversiones innecesarias.
- **Sí:** una imagen por página A4 con `BoxFit.contain`. Formato estándar de expediente, sin recortar contenido del documento fotografiado.
- **No:** página del tamaño de la imagen, ni orientación automática. A4 fijo es más predecible para revisión e impresión.
- **Sí:** redimensionar a 1600 px y JPG calidad 75. Baja mucho el peso del PDF para subir con mala señal y sigue siendo legible.
- **Sí:** procesar en `Isolate.run`. Decodificar y redimensionar varias fotos en el hilo principal congela la UI.
- **Sí:** guardar en `Documents/expediente_pdfs/` (persistente). Permite reintentar el envío si falla o si no hay conexión.
- **No:** directorio temporal o solo bytes en memoria. El sistema puede borrar el temporal, y los bytes en memoria se pierden si la app se cierra.
- **Sí:** `fileName` lo pasa quien llama, y un mismo nombre sobrescribe. Quien llama conoce el contexto (por ejemplo, el número de solicitud), y así se evitan duplicados.
- **Sí:** `deletePdf` explícito. Quien envía borra el PDF después de una subida exitosa.
- **No:** limpieza automática de PDFs viejos. Queda para otra spec si se acumulan.
- **Sí:** fallar todo con `ImagesToPdfException` si una imagen falla. Un PDF incompleto en el expediente es peor que un error visible.
- **No:** omitir imágenes malas y seguir.
- **Sí:** clase estática en `config/services/pdf/`. Mismo estilo que `CameraService`.
- **No:** registrar en GetIt. No hay estado ni dependencias que justifiquen inyección.
- **Sí:** parámetro opcional `outputDirectory`. Permite testear sin el platform channel de `path_provider`.
- **Sí:** primer test unitario del repo. La generación es lógica pura y se verifica bien de forma automática.
- **Sí:** las imágenes de prueba se generan dentro del test. No se versionan binarios en el repo.
- **Sí:** compartido para los tres países. Convertir imágenes a PDF no depende del país.

## Risks

| Riesgo | Mitigación |
| --- | --- |
| Memoria alta al decodificar muchas fotos grandes a la vez | Procesar una imagen a la vez dentro del isolate y redimensionar antes de agregarla al documento. |
| El endpoint futuro exige otro tamaño, peso máximo o formato de página | Las constantes `maxImageDimension`, `jpgQuality` y el formato A4 están centralizados en el servicio y se ajustan en la spec de envío. |
| PDFs huérfanos se acumulan en `Documents/expediente_pdfs/` si el envío nunca ocurre | Mismo `fileName` sobrescribe. La limpieza automática queda fuera de scope y documentada. |
| Versión del paquete `pdf` incompatible con el SDK (`>=3.4.4`) | Fijar en el paso 1 una versión compatible y confirmar con `flutter pub get` y `flutter analyze`. |
| Fotos con EXIF rotado salen giradas en el PDF | Aplicar `img.bakeOrientation` antes de redimensionar, igual que `CameraService`. |

## What is **not** in this spec

- Endpoint, repository y cubit para subir el PDF al expediente.
- Pantalla de captura múltiple, reordenamiento o previsualización.
- Paquete `printing` (previsualizar, imprimir o compartir).
- Persistencia en ObjectBox/Isar para reintentos offline.
- Limpieza automática de PDFs viejos.
- Varias imágenes por página, encabezados o metadatos.
- Cambios a `CameraService` o al flujo de cédulas.

Cada uno, si llega, va en su propia spec.
