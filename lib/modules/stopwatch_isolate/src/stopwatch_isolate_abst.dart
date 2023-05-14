
import '../../modules.dart';

abstract class StopwatchIsolate extends CustomIsolate<StopwatchIsolateModel> {
  void start(SendPort? isolatedSendPort);
  void pause(SendPort? isolatedSendPort);
  void resume(SendPort? isolatedSendPort);
  void stop(SendPort? isolatedSendPort);
}