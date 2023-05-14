import '../../modules.dart';

class IsolateModel {
  late Isolate isolate;
  late SendPort sendPort;
  late SendPort? isolatedSendPort;
  IsolateModel();
}