import 'dart:async';

import 'package:isolator/next/in/in_abstract.dart';
import 'package:isolator/next/out/create_out.dart' if (dart.library.isolate) 'package:isolator/next/out/out_native.dart' if (dart.library.js) 'package:isolator/next/out/out_web.dart';
import 'package:isolator/next/types.dart';

abstract class Out<T> {
  In get createIn => throw UnimplementedError('Cant create In from abstract Out');

  StreamSubscription<T> listen(
    StreamDataListener<T> onData, {
    StreamErrorListener? onError,
    StreamOnDoneCallback? onDone,
    bool cancelOnError = false,
  });

  Future<void> close();

  static Out<T> create<T>() => createOut<T>();
}
