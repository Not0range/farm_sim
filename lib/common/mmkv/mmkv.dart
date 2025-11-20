export 'mmkv_unsupported.dart'
    if (dart.library.ffi) 'package:mmkv/mmkv.dart'
    if (dart.library.js) 'mmkv_web.dart';
