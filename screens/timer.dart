import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stopwatch_app/models/time.dart';
import 'package:stopwatch_app/models/time_group.dart';
import 'package:stopwatch_app/util/route_names.dart';

class Watch extends StatefulWidget {
  TimeGroup group;
  Watch(this.group);
  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  int seconds = 0;
  bool paused = true;
  static Stopwatch watch = new Stopwatch();
  static Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      setState(() {
        seconds = watch.elapsedMilliseconds ~/ 1000;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    watch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Time : ${widget.group.name}'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            timerWidget(this.seconds),
            bodyWiget(this.paused),
          ],
        ));
  }

  bodyWiget(bool paused) {
    if (paused)
      return pausedBody();
    else
      return playBody();
  }

  timerWidget(int time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 40.0, right: 25.0),
          child: Column(
            children: [
              Container(
                child: Text(
                  '${time ~/ 60}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              Container(
                child: Text(
                  'Min',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 35.0),
          child: Text(' : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 40.0, left: 25.0),
          child: Column(
            children: [
              Container(
                child: Text(
                  '${time % 60}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              Container(
                child: Text(
                  'Sec',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pausedBody() {
    return Container(
      padding: EdgeInsets.only(bottom: 200.0, right: 20.0, left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    watch.reset();
                  },
                  child: Icon(Icons.fast_rewind),
                ),
                FloatingActionButton(
                  onPressed: () {
                    watch.start();
                    setState(() {
                      paused = false;
                    });
                  },
                  child: Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: FloatingActionButton(
                onPressed: () async {
                  watch.start();
                  await Time.saveTime(new Time(widget.group.id, this.seconds));
                  //await Time.saveTime(new Time(widget.group.id, this.seconds));
                  Navigator.pushNamed(context, RouteNames.group_Times,
                      arguments: widget.group);
                },
                child: Text('Save')),
          )
        ],
      ),
    );
  }

  playBody() {
    return Container(
      padding: EdgeInsets.only(bottom: 350.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
              onPressed: () {
                watch.reset();
              },
              child: Icon(Icons.fast_rewind)),
          FloatingActionButton(
              onPressed: () {
                watch.stop();
                setState(() {
                  paused = true;
                });
              },
              child: Icon(Icons.pause)),
        ],
      ),
    );
  }
}
