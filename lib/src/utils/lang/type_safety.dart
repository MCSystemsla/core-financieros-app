//La función es útil cuando se necesita hacer una conversión segura de tipos, en lugar de simplemente hacer una conversión sin comprobar el tipo, lo que puede provocar errores en tiempo de ejecución.
T? cast<T>(x) => x is T ? x : null;
