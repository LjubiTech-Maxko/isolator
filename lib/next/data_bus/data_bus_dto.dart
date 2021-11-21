import 'package:isolator/next/types.dart';

abstract class DataBusDto<Event> {
  Event get event;
  BackendId get to;
  BackendId get from;
  String get id;
}
