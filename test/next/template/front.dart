import 'package:isolator/next/backend/backend_argument.dart';
import 'package:isolator/next/frontend/frontend.dart';

import 'back.dart';

class Front with Frontend {
  Future<void> init() async {
    await initBackend(initializer: createBack);
  }

  @override
  void initActions() {}
}

Back createBack(BackendArgument<void> argument) {
  return Back(argument: argument);
}
