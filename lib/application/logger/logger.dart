import 'dart:developer' as devtools show log;

extension Logger on Object? {
  void log([String name = '']) {
    devtools.log(this?.toString() ?? '\x1b[101m\x1b[30mNULL\x1b[0m', name: name);
  }
}
