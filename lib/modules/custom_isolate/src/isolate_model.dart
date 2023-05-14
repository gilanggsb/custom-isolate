import '../../modules.dart';

class IsolateModel {
  final String isolateName;
  late Isolate isolate;
  late SendPort sendPort;
  late SendPort? isolatedSendPort;
  IsolateModel({required this.isolateName});
}