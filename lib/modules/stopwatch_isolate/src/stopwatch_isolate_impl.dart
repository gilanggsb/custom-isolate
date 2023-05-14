import 'package:flutter/material.dart';

import '../../modules.dart';

class StopwatchIsolateImpl extends StopwatchIsolate {
  late StopwatchIsolateModel stopwatchIsolateModel;
  @override
  void pause(SendPort? isolatedSendPort) {
    printStopwatchIsolate('pause stopwatch sendPort :');
    isolatedSendPort?.send(StopwatchIsolateEnum.pause);
  }

  @override
  void resume(SendPort? isolatedSendPort) {
    printStopwatchIsolate('resume stopwatch sendPort :');
    isolatedSendPort?.send(StopwatchIsolateEnum.resume);
  }

  @override
  void start(SendPort? isolatedSendPort) {
    printStopwatchIsolate('start stopwatch sendPort');
    isolatedSendPort?.send(StopwatchIsolateEnum.start);
  }

  @override
  void stop(SendPort? isolatedSendPort) {
    printStopwatchIsolate('stop stopwatch sendPort');
    isolatedSendPort?.send(StopwatchIsolateEnum.stop);
  }

  @override
  Future<Isolate> createIsolate(
    StopwatchIsolateModel isolateModel,
    HandleIsolateMessage handleIsolateMessage,
  ) async {
    ReceivePort receivePort = ReceivePort();
    isolateModel.sendPort = receivePort.sendPort;
    stopwatchIsolateModel = isolateModel;
    printStopwatchIsolate('create isolate stopwatch');
    Isolate isolate = await Isolate.spawn<StopwatchIsolateModel>(
      stopwatchCallback,
      isolateModel,
    );
    receivePort.listen(handleIsolateMessage);
    printStopwatchIsolate('isolate stopwatch created');
    return isolate;
  }

  /// stopwatchcallback for current isolate / isolated port
  void stopwatchCallback(StopwatchIsolateModel message) {
    // assign data from StopwatchIsolateModel
    SendPort mainSendPort = message.sendPort;
    Stopwatch stopwatch = message.stopwatch;
    // create isolated port
    ReceivePort receivePort = ReceivePort();
    // send isolated sendPort to main Sendport
    message.sendPort.send(receivePort.sendPort);

    // listen every message from isolated sendPort that is sent from main isolate
    receivePort.listen((message) {
      if (message is! StopwatchIsolateEnum) {
        return;
      }
      // start stopwatch
      if (message == StopwatchIsolateEnum.start) {
        stopwatch.start();
      }

      // pause stopwatch
      if (message == StopwatchIsolateEnum.pause) {
        stopwatch.stop();
        sendDataToMainPort(mainSendPort, stopwatch.elapsed);
      }

      // resume stopwatch
      if (message == StopwatchIsolateEnum.resume) {
        stopwatch.start();
      }

      // stop stopwatch
      if (message == StopwatchIsolateEnum.stop) {
        stopwatch.stop();
        sendDataToMainPort(mainSendPort, stopwatch.elapsed);
        stopwatch.reset();
      }
    });
  }

  /// Sending data to main port
  void sendDataToMainPort(SendPort sendPort, dynamic data) {
    printStopwatchIsolate('sendDataToMainPort $data');
    sendPort.send(data);
  }

  /// Close port
  @override
  Future<void> close(Isolate isolate) async {
    isolate.kill(priority: Isolate.immediate);
    printStopwatchIsolate('destroyed $isolate');
  }

  void printStopwatchIsolate(String message) {
    debugPrint('Isolated ${stopwatchIsolateModel.isolateName}: $message');
  }
}
