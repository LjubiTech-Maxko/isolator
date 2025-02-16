import 'package:isolator/src/backend/backend.dart';
import 'package:isolator/src/backend/backend_argument.dart';

import 'event.dart';

class Back extends Backend {
  Back({
    required BackendArgument<void> argument,
  }) : super(argument: argument);

  void _sendValue({required Event event, void data}) {
    send(event: Event.getMessageWithValue, data: 42);
  }

  void _sendList({required Event event, void data}) {
    send(event: Event.getMessageWithList, data: [1, 2, 3, 4, 5], forceUpdate: true);
  }

  Future<void> _sendSeveralMessages({required Event event, void data}) async {
    await send(event: Event.getMessageWithValue, data: 42);
    await send(event: Event.getMessageWithList, data: [1, 2, 3, 4, 5], forceUpdate: true);
  }

  @override
  void initActions() {
    whenEventCome(Event.getMessageWithValue).run(_sendValue);
    whenEventCome(Event.getMessageWithList).run(_sendList);
    whenEventCome(Event.getSeveralMessages).run(_sendSeveralMessages);
  }
}
