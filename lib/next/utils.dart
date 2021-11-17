import 'dart:convert';

import 'package:isolator/next/types.dart';

const String EVENT_CODE_SPLITTER = '::::::::::::::';
const String SYNC_CHUNK_EVENT_PROP = 'SYNC_CHUNK_EVENT_PROP';

String prettyJson(Json json) {
  const JsonEncoder jsonEncoder = JsonEncoder.withIndent(' ');
  return jsonEncoder.convert(json);
}

T? tryToCall<T>(dynamic object, Caller<T> caller) {
  try {
    return caller(object);
  } catch (error) {
    return null;
  }
}

Object tryPrintAsJson(dynamic object) {
  final Json? json = tryToCall<Json>(object, (dynamic object) => object.toJson() as Json);
  if (json != null) {
    return json;
  }
  return Error.safeToString(object);
}

String generateMessageCode(dynamic event, {bool syncChunkEvent = false}) {
  final List<String> letters = '0123456789abcdefghijklmnopqrstuvwxyz'.split('');
  letters.shuffle();
  final String code = letters.take(12).join();
  String chunkEventProp = '';
  if (syncChunkEvent) {
    chunkEventProp = '$EVENT_CODE_SPLITTER$SYNC_CHUNK_EVENT_PROP';
  }
  return '$event$EVENT_CODE_SPLITTER$code$chunkEventProp';
}

bool isSyncChunkEventCode(String messageCode) => messageCode.contains(SYNC_CHUNK_EVENT_PROP);

String convertSyncChunkEventCodeToMessageCode(String messageCode) {
  final List<String> codeTokens = messageCode.split(EVENT_CODE_SPLITTER);
  if (codeTokens.length != 3) {
    throw Exception('Invalid sync chunk event message code $messageCode');
  }
  return codeTokens.take(2).join(EVENT_CODE_SPLITTER);
}

String convertMessageCodeToSyncChunkEventCode(String messageCode) {
  return [...messageCode.split(EVENT_CODE_SPLITTER), SYNC_CHUNK_EVENT_PROP].join(EVENT_CODE_SPLITTER);
}
