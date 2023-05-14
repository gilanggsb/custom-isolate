import '../../custom_isolate/custom_isolate.dart';

class StopwatchIsolateModel extends IsolateModel {
  final Stopwatch stopwatch = Stopwatch();
  StopwatchIsolateModel({required super.isolateName});
}
