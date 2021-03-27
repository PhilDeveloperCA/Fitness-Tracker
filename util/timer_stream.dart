import 'dart:async';

class TimerStream {
  static Stopwatch stopwatch = new Stopwatch();
  static Timer _timer =
      new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
    _timeStream.add(milloseconds);
  });

  static get milloseconds => stopwatch.elapsedMilliseconds;
  static StreamController<int> _timeStream = new StreamController<int>();

  dispose() {
    _timeStream.close();
  }

  void start() {
    stopwatch.start();
  }

  void pause() {
    stopwatch.stop();
  }

  void restart() {
    stopwatch.reset();
  }
}
