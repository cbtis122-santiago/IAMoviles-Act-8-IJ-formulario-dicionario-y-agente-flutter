import 'dart:io';

void main() async {
  print('================================================');
  print('🚀 Agente Interactivo para Subir a GitHub 🚀');
  print('================================================\n');
  
  // 1. Preguntar por el enlace del nuevo repositorio
  stdout.write('1. Introduce el enlace (URL) del nuevo repositorio:\n> ');
  final repoUrl = stdin.readLineSync()?.trim();
  
  if (repoUrl == null || repoUrl.isEmpty) {
    print('❌ Error: El enlace del repositorio no puede estar vacío.');
    return;
  }

  // 2. Preguntar por el mensaje de commit
  stdout.write('\n2. Introduce el mensaje del commit:\n> ');
  final commitMessage = stdin.readLineSync()?.trim();
  
  if (commitMessage == null || commitMessage.isEmpty) {
    print('❌ Error: El mensaje del commit no puede estar vacío.');
    return;
  }

  // 3. Preguntar por la rama (por defecto 'main')
  stdout.write('\n3. Introduce el nombre de la rama (Presiona Enter para usar "main" por defecto):\n> ');
  String? branch = stdin.readLineSync()?.trim();
  
  if (branch == null || branch.isEmpty) {
    branch = 'main';
  }

  print('\n⏳ Ejecutando comandos de Git...\n');

  // Método auxiliar para ejecutar comandos de línea de comandos de manera asíncrona
  Future<bool> runGitCommand(List<String> arguments, {bool showOutput = false}) async {
    print('> git ${arguments.join(" ")}');
    final result = await Process.run('git', arguments, runInShell: true);
    
    if (result.exitCode != 0) {
      if (arguments.contains('remote') && result.stderr.toString().contains('already exists')) {
        print('⚠️ El remoto origin ya existe. Actualizando la URL con el nuevo repositorio...');
        final updateResult = await Process.run('git', ['remote', 'set-url', 'origin', repoUrl], runInShell: true);
        if (updateResult.exitCode == 0) return true;
        print('❌ Error actualizando el remoto:\n${updateResult.stderr}');
        return false;
      }
      print('❌ Error ejecutando "git ${arguments.join(" ")}":\n${result.stderr}');
      return false;
    } else if (showOutput && result.stdout.toString().isNotEmpty) {
      print(result.stdout.toString().trim());
    }
    return true;
  }

  // Inicializar git
  if (!await runGitCommand(['init'])) return;
  
  // Agregar archivos
  if (!await runGitCommand(['add', '.'])) return;
  
  // Hacer commit (si falla, puede ser porque ya no hay cambios para hacer commit. Ignoramos el error)
  await runGitCommand(['commit', '-m', commitMessage]);
  
  // Establecer la rama
  if (!await runGitCommand(['branch', '-M', branch])) return;
  
  // Añadir la URL del remoto
  await runGitCommand(['remote', 'add', 'origin', repoUrl]);

  // Hacer push interactivo (mostrando el progreso al usuario)
  print('\n> git push -u origin $branch');
  print('Subiendo archivos... esto puede tardar un momento ⏳');
  
  final pushProcess = await Process.start('git', ['push', '-u', 'origin', branch], runInShell: true);
  
  // Mostramos el flujo de salida y de errores directamente en el terminal
  stdout.addStream(pushProcess.stdout);
  stderr.addStream(pushProcess.stderr);

  final exitCode = await pushProcess.exitCode;
  
  if (exitCode == 0) {
    print('\n✅ ¡El proyecto se ha subido a GitHub con éxito en la rama "$branch"! 🎉');
    print('🔗 Enlace: $repoUrl');
  } else {
    print('\n❌ Ocurrió un problema al subir a GitHub. Revisa la salida de la consola arriba para arreglarlo.');
  }
}
