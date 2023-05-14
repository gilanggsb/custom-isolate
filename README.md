# Custom Isolate
A new Flutter plugin to implement custom isolate or stopwatch isolate.

# Description
This README provides an overview and guide on using custom isolates in Flutter. Custom isolates are a powerful feature in Flutter that allow you to run computationally intensive or long-running tasks in a separate isolate (a lightweight thread-like unit of concurrency) instead of the main UI isolate. This helps in keeping the UI responsive and prevents it from freezing or becoming unresponsive during heavy operations.

Custom isolates in Flutter are based on Dart's Isolate class, which provides an interface for creating and managing isolates. By utilizing custom isolates, you can offload CPU-intensive tasks, such as image processing, network requests, or data computations, to a separate isolate, leaving the main UI isolate free to handle user interactions and keep the app responsive.

# Requirements
 1.  flutter sdk : >=3.3.0

# How To Use
You can see this example in "/example/main.dart"


