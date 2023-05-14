import 'dart:async';

import 'package:flutter/material.dart';

import '../../custom_isolate.dart';

void main(List<String> args) async {
  StopwatchIsolate stopwatchIsolate = StopwatchIsolateImpl();
  StopwatchIsolateModel stopwatchIsolateModel =
      StopwatchIsolateModel(isolateName: "Stopwatch 1");
  StopwatchIsolateModel stopwatchIsolateModel2 =
      StopwatchIsolateModel(isolateName: "Stopwatch 2");
  stopwatchIsolateModel.isolate =
      await initStopwatchIsolate(stopwatchIsolateModel, stopwatchIsolate);
  stopwatchIsolateModel2.isolate =
      await initStopwatchIsolate(stopwatchIsolateModel2, stopwatchIsolate);
}

void stop(
  StopwatchIsolate stopwatchIsolate,
  StopwatchIsolateModel stopwatchIsolateModel,
) {
  stopwatchIsolate.stop(stopwatchIsolateModel.isolatedSendPort);
}

void start(
  StopwatchIsolate stopwatchIsolate,
  StopwatchIsolateModel stopwatchIsolateModel,
) {
  stopwatchIsolate.start(stopwatchIsolateModel.isolatedSendPort);
}

void close(
  StopwatchIsolate stopwatchIsolate,
  StopwatchIsolateModel stopwatchIsolateModel,
) {
  stopwatchIsolate.close(stopwatchIsolateModel.isolate);
}

void extractData(Duration message) {
  debugPrint("duration data from isolated port: ${message.inSeconds}");
}

Future<Isolate> initStopwatchIsolate(
  StopwatchIsolateModel stopwatchIsolateModel,
  StopwatchIsolate stopwatchIsolate,
) async {
  return await stopwatchIsolate.createIsolate(stopwatchIsolateModel, (message) {
    debugPrint('mainPort message $message');
    if (message is SendPort) {
      stopwatchIsolateModel.isolatedSendPort = message;
      return;
    }
    if (message is! Duration) return;
    extractData(message);
  });
}
