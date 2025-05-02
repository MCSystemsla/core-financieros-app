import 'dart:io';
import 'dart:convert';

void main() async {
  await run('flutter pub get');
  await run('flutter pub run build_runner build');
}

Future<void> run(String command) async {
  final shell = Platform.isWindows ? 'cmd' : 'bash';
  final args = Platform.isWindows ? ['/c', command] : ['-c', command];

  stdout.writeln('\n🔧 Ejecutando: $command\n');

  final process = await Process.start(shell, args);

  process.stdout.transform(utf8.decoder).listen((data) {
    stdout.write(data);
  });

  process.stderr.transform(utf8.decoder).listen((data) {
    stderr.write(data);
  });

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    stdout.writeln(
        '❌ El comando "$command" falló con código de salida $exitCode');
    exit(exitCode);
  } else {
    stdout.writeln('✅ Comando completado: $command\n');
  }
}
