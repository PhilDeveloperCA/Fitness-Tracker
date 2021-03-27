import 'dart:async';

class TimerBloc {
  static StreamController<double> _time = new StreamController<double>();

  double seconds;
  bool counting;
  Duration interval;
  Timer timer;

  TimerBloc({int dur: 10}) {
    this.seconds = 0.0;
    this.counting = false;
    Duration interval = new Duration(milliseconds: dur);
    Timer timer = Timer.periodic(interval, (timer) {
      if (counting) {
        _incrimentSeconds();
      } else
        return;
    });
  }
  //
  get _value => _time.sink.add;
  //Timer timer;
  get time => _time.stream.transform(validator);

  var validator =
      StreamTransformer<double, double>.fromHandlers(handleData: (value, sink) {
    /*if(value < 86400.00){
        sink.add(value);
      }
      else{
        sink.addError('Too Large');
      }*/
    sink.add(value);
  });

  startTimer() {
    counting = true;
  }

  _incrimentSeconds() {
    this.seconds += .01;
    print(seconds);
    _value(seconds);
  }

  pauseTimer() {
    counting = true;
    print('whats up');
  }

  resetTimer() {
    counting = false;
    _value.add(0.00);
  }

  dispose() {
    _time.close();
  }

  saveTimer(String collection) {}
}

//Go Over Rx dart to do stuff..
