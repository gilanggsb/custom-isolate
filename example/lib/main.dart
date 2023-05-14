import 'package:custom_isolate/custom_isolate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StopwatchIsolate stopwatchIsolate;
  late StopwatchIsolateModel stopwatchIsolateModel;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    closeStopwatchIsolate();
    super.dispose();
  }

  void initStopwatchIsolate() async {
    // create stopwatch isolate model
    stopwatchIsolateModel = StopwatchIsolateModel();
    // create stopwatch isolate class
    stopwatchIsolate = StopwatchIsolateImpl();
    // create isolate
    stopwatchIsolateModel.isolate = await stopwatchIsolate.createIsolate(
        stopwatchIsolateModel, _handleMessage);
  }

  //handle message from isolated port
  void _handleMessage(message) {
    // must implement this to trigger stopwatch from main port to isolated port
    if (message is SendPort) {
      stopwatchIsolateModel.isolatedSendPort = message;
      return;
    }
    if (message is! int) return;
    extractData(message);
  }

  void extractData(dynamic data) {
    setState(() {
      seconds = data;
    });
  }

  void stopStopwatch() {
    stopwatchIsolate.stop(stopwatchIsolateModel.isolatedSendPort);
  }

  void startStopwatch() {
    stopwatchIsolate.start(stopwatchIsolateModel.isolatedSendPort);
  }

  void pauseStopwatch() {
    stopwatchIsolate.pause(stopwatchIsolateModel.isolatedSendPort);
  }

  void resumeStopwatch() {
    stopwatchIsolate.resume(stopwatchIsolateModel.isolatedSendPort);
  }

  void closeStopwatchIsolate() {
    stopwatchIsolate.close(stopwatchIsolateModel.isolate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Stopwatch Isolate'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: initStopwatchIsolate,
                child: const Text('Init Stopwatch Isolate'),
              ),
              ElevatedButton(
                onPressed: closeStopwatchIsolate,
                child: const Text('Destroy Isolated Stopwatch'),
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Stopwatch In $seconds seconds'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: startStopwatch,
                child: const Text('Start stopwatch'),
              ),
              ElevatedButton(
                onPressed: pauseStopwatch,
                child: const Text('pause stopwatch'),
              ),
              ElevatedButton(
                onPressed: resumeStopwatch,
                child: const Text('resume stopwatch'),
              ),
              ElevatedButton(
                onPressed: stopStopwatch,
                child: const Text('stop stopwatch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
