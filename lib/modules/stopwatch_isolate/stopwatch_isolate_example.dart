import 'dart:async';

import '../modules.dart';


StopwatchIsolate stopwatchIsolate = StopwatchIsolateImpl();
StopwatchIsolateModel stopwatchIsolateModel = StopwatchIsolateModel();
StopwatchIsolateModel stopwatchIsolateModel2 = StopwatchIsolateModel();
StopwatchIsolateModel stopwatchIsolateModel3 = StopwatchIsolateModel();
StopwatchIsolateModel stopwatchIsolateModel4 = StopwatchIsolateModel();
void main(List<String> args) async {
  stopwatchIsolateModel.isolate = await initStopwatchIsolate(stopwatchIsolateModel);
  stopwatchIsolateModel2.isolate = await initStopwatchIsolate(stopwatchIsolateModel2);
}

void stop() {
  stopwatchIsolate.stop(stopwatchIsolateModel.isolatedSendPort);
}

void start() {
  stopwatchIsolate.start(stopwatchIsolateModel.isolatedSendPort);
}

void close() {
  stopwatchIsolate.close(stopwatchIsolateModel.isolate);
}

void stop2() {
  stopwatchIsolate.stop(stopwatchIsolateModel2.isolatedSendPort);
}

void start2() {
  stopwatchIsolate.start(stopwatchIsolateModel2.isolatedSendPort);
}

void close2() {
  stopwatchIsolate.close(stopwatchIsolateModel2.isolate);
}

void extractData(dynamic message) {
  if (message is! int) {
    return;
  }
  debugPrint("$message");
}

Future<Isolate> initStopwatchIsolate(
  StopwatchIsolateModel stopwatchIsolateModel,
) async {
  return await stopwatchIsolate.createIsolate(stopwatchIsolateModel, (message) {
    debugPrint('mainPort message $message');
    if (message is SendPort) {
      stopwatchIsolateModel.isolatedSendPort = message;
      return;
    }
    extractData(message);
  });
}
