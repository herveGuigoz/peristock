import 'dart:developer' as devtools show log;

extension Log on Object? {
  void log() {
    devtools.log(this?.toString() ?? '\x1b[101m\x1b[30mNULL\x1b[0m');
  }
}
