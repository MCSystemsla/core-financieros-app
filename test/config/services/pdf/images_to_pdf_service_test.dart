import 'dart:convert';
import 'dart:io';

import 'package:core_financiero_app/src/config/services/pdf/images_to_pdf_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/images_to_pdf_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  late Directory tempDir;
  late Directory outputDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('images_to_pdf_test_');
    outputDir = Directory('${tempDir.path}/out');
  });

  tearDown(() async {
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  /// Escribe un JPG de prueba de [width]x[height] y devuelve su ruta.
  String writeJpg(String name, {required int width, int height = 50}) {
    final image = img.Image(width: width, height: height);
    img.fill(image, color: img.ColorRgb8(200, 30, 30));
    final path = '${tempDir.path}/$name.jpg';
    File(path).writeAsBytesSync(img.encodeJpg(image));
    return path;
  }

  String pdfText(File pdf) => latin1.decode(pdf.readAsBytesSync());

  int pageCount(File pdf) =>
      RegExp(r'/Type\s*/Page(?!s)').allMatches(pdfText(pdf)).length;

  List<int> imageWidths(File pdf) => RegExp(r'/Width\s+(\d+)')
      .allMatches(pdfText(pdf))
      .map((m) => int.parse(m.group(1)!))
      .toList();

  List<FileSystemEntity> pdfsIn(Directory dir) => dir.existsSync()
      ? dir.listSync().where((f) => f.path.endsWith('.pdf')).toList()
      : [];

  test('genera un PDF con una página por imagen, en orden', () async {
    final paths = [
      writeJpg('a', width: 100),
      writeJpg('b', width: 200),
      writeJpg('c', width: 300),
    ];

    final pdf = await ImagesToPdfService.generate(
      imagePaths: paths,
      fileName: 'expediente_1',
      outputDirectory: outputDir,
    );

    expect(pdf.existsSync(), isTrue);
    expect(pdf.path.endsWith('expediente_1.pdf'), isTrue);
    expect(ascii.decode(pdf.readAsBytesSync().sublist(0, 4)), '%PDF');
    expect(pageCount(pdf), 3);
    expect(imageWidths(pdf), [100, 200, 300]);
  });

  test('reduce las imágenes grandes a 2400 px de lado máximo', () async {
    final pdf = await ImagesToPdfService.generate(
      imagePaths: [writeJpg('grande', width: 3200, height: 100)],
      fileName: 'expediente_grande',
      outputDirectory: outputDir,
    );

    expect(imageWidths(pdf), [ImagesToPdfService.maxImageDimension]);
  });

  test('el mismo fileName sobrescribe el PDF anterior', () async {
    final paths = [
      writeJpg('a', width: 100),
      writeJpg('b', width: 200),
      writeJpg('c', width: 300),
    ];

    await ImagesToPdfService.generate(
      imagePaths: paths,
      fileName: 'expediente_1',
      outputDirectory: outputDir,
    );
    final pdf = await ImagesToPdfService.generate(
      imagePaths: [paths.first],
      fileName: 'expediente_1',
      outputDirectory: outputDir,
    );

    expect(pdfsIn(outputDir), hasLength(1));
    expect(pageCount(pdf), 1);
  });

  test('lista vacía lanza excepción y no crea archivo', () async {
    await expectLater(
      ImagesToPdfService.generate(
        imagePaths: [],
        fileName: 'expediente_1',
        outputDirectory: outputDir,
      ),
      throwsA(isA<ImagesToPdfException>()),
    );
    expect(pdfsIn(outputDir), isEmpty);
  });

  test('fileName inválido lanza excepción', () async {
    final path = writeJpg('a', width: 100);
    for (final name in ['', 'a/b', r'a\b']) {
      await expectLater(
        ImagesToPdfService.generate(
          imagePaths: [path],
          fileName: name,
          outputDirectory: outputDir,
        ),
        throwsA(isA<ImagesToPdfException>()),
      );
    }
    expect(pdfsIn(outputDir), isEmpty);
  });

  test('ruta inexistente lanza excepción con esa imagePath', () async {
    final missing = '${tempDir.path}/no_existe.jpg';

    await expectLater(
      ImagesToPdfService.generate(
        imagePaths: [writeJpg('a', width: 100), missing],
        fileName: 'expediente_1',
        outputDirectory: outputDir,
      ),
      throwsA(
        isA<ImagesToPdfException>()
            .having((e) => e.imagePath, 'imagePath', missing),
      ),
    );
    expect(pdfsIn(outputDir), isEmpty);
  });

  test('archivo que no es imagen lanza excepción', () async {
    final notImage = '${tempDir.path}/texto.jpg';
    File(notImage).writeAsStringSync('esto no es una imagen');

    await expectLater(
      ImagesToPdfService.generate(
        imagePaths: [notImage],
        fileName: 'expediente_1',
        outputDirectory: outputDir,
      ),
      throwsA(
        isA<ImagesToPdfException>()
            .having((e) => e.imagePath, 'imagePath', notImage),
      ),
    );
    expect(pdfsIn(outputDir), isEmpty);
  });

  test('deletePdf borra el archivo y no falla si se llama otra vez', () async {
    final pdf = await ImagesToPdfService.generate(
      imagePaths: [writeJpg('a', width: 100)],
      fileName: 'expediente_1',
      outputDirectory: outputDir,
    );

    await ImagesToPdfService.deletePdf(pdf);
    expect(pdf.existsSync(), isFalse);

    await ImagesToPdfService.deletePdf(pdf);
    expect(pdf.existsSync(), isFalse);
  });
}
