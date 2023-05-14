import '../../modules.dart';

abstract class CustomIsolate<T extends IsolateModel> {
  /// create isolate port than return isolate data,
  /// to handle data from isolated port
  /// just use [HandleIsolateMessage] function
  ///
  /// `How To Use this :`
  /// ```
  /// Isolate isolate = createIsolate() async {
  ///   ReceivePort receivePort = ReceivePort();
  ///   stopwatchIsolateModel.sendPort = receivePort.sendPort;
  ///   Isolate isolate = await Isolate.spawn<StopwatchIsolateModel>(
  ///   stopwatchCallback, stopwatchIsolateModel);
  ///   receivePort.listen(handleIsolateMessage);
  ///   return isolate;
  /// }
  /// ```
  Future<Isolate> createIsolate(
    T isolateModel,
    HandleIsolateMessage handleIsolateMessage,
  );

  /// every isolated port must close if not used
  /// to avoid memory leaks
  Future<void> close(Isolate isolate);
}
