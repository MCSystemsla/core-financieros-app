# CORE FINANCIERO APP

_El presente repositorio almacena el código frontend del proyecto **MICRÉDITO**, la cual, es una aplicación móvil multiplataforma con la cual se usa para el core fianciero  dado por la empresa **MCSYSTEM** la cual la aplicacion consta para usos financieros._

## Comenzando 🚀

Primeramente, para poder correr el proyecto de manera local será necesarío clonarlo de este repositorio

En **Deployment** se pueden obtener mas detalles de como desplegar el proyecto de manera local para propósitos de desarrollo y pruebas.

### Pre-requisitos 📋

_Que cosas necesitas para instalar el software y como instalarlas_

- Instalar Flutter _(3.32.6)_ en la máquina: https://docs.flutter.dev/get-started/install, importante seguir todos los pasos dependiendo de la maquina a utilizar, preferible un Mac para que la aplicación se pueda pobrar en IOS y Android

- Configurar un editor: https://docs.flutter.dev/get-started/editor, se recomienda VSCode

### Instalación 🔧

_Paso a paso que te dice lo que debes ejecutar para tener un entorno de desarrollo ejecutandose_

0. Tener descargado el proyecto e instalado flutter

1. Correr el siguiente comando para instalar las librerias y inicializar las BD Locales

```
dart run tool/build_script.dart
```

2. Correr los siguientes comandos para instalar las librerias de ios (solo en MAC)

```
cd ios
pod cache clean --all
pod repo update
pod install
pod update
```

3. Tener un emulador corriendo ya sea de android o ios y seguir los pasos de abajo dependiendo del editor utilizado

#### Si se usa VSCODE y se ejecuta el run and debug:

_En la carpeta .vscode se encuentra los diferentes tipos de lanzamiento de la app._

#### Para otro editor, referise a estos documentos:

- Documentación de flutter sobre android studio: https://docs.flutter.dev/tools/android-studio#running-and-debugging
- Documentación android sobre configuraciones de diferentes builds: https://developer.android.com/studio/run/rundebugconfig

## Builds 📦

Instrucciones para generar las versiones de prueba o de producción de la app.

- Crear archivos `api-key-local.json, api-key.json y api-key-prod.json`, usando como referencia el archivo `api-key.json.tpl`, que necesita los siguientes atributos en el archivo.

#### Android

2. Ejecutar:

CORE FINANCIERO

```
flutter build apk --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../
```
BUILD POR ABI
```
flutter build apk --split-per-abi --flavor micreditoHonduras --dart-define-from-file=api-key-hn.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../ 
```

ó

si se quiere generar un archivo `.apk` para compartir o para subir a tiendas como la de AppGallery

3. Ejecutar:

CORE FINANCIERO

```
flutter build appbundle --flavor micreditoHonduras --dart-define-from-file=api-key-hn-prod.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../
```
si se quiere generar un archivo .aab para subir a la tienda de google

4. Ir a la pagina de google: https://play.google.com/console/u/0/developers del proyecto, y seleccionar la aplicación, y en la parte de Production/Producción, se le da al boton de 'Create New Release'/'Crear una nueva version', en esta parte se subira el archivo .aab generado y se podra colocar el mensaje de actualización que les aparecera a los usuarios cuando quieran actualizar la aplicación, se le da siguiente hasta terminar y se espera a que los cambios sean aceptados por la tienda.


#### IOS (Solo funciona con un MAC)

2. Ejecutar:

CORE FINANCIERO

```
flutter build ipa --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart --release --obfuscate --split-debug-info=../
```

## Debug
Instrucciones para compilar la app.

- Crear archivos `api-key-local.json, api-key.json y api-key-prod.json`, usando como referencia el archivo `api-key.json.tpl`, que necesita los siguientes atributos en el archivo.

Ejecutar:
```
flutter run --flavor micreditoHonduras --dart-define-from-file=api-key.json --target=lib/main_hn.dart
```

### Notas importantes 🔑

El versionado de la app se maneja como X.Y.Z, siendo X para cambios muy grandes en la plataforma haciendo que la versión anterior quede deprecada, Y para nuevas features que se hagan a la app, nuevos modulos o cambios grandes en algún modulo y la Z se usa para bugs, ajustes pequeños

## Autores ✒️

_Menciona a todos aquellos que ayudaron a levantar el proyecto desde sus inicios_

- **Jesús Reyes** - _Codigo_
