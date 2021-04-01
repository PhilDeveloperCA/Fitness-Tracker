//states lifts and stuff...abstract

import 'package:flutter/material.dart';
import 'package:stopwatch_app/models/lift_group.dart';
import 'package:stopwatch_app/models/time_group.dart';
import 'package:stopwatch_app/util/route_names.dart';

class Home extends StatefulWidget {
  int index = 0;
  Home({this.index = 0});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Groups Home')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: BodyWidget(widget.index),
      ),
    );
  }

  Widget BodyWidget(int i) {
    if (i == 0)
      return TimerGroups();
    else
      return LiftGroups();
  }

  Widget TimerGroups() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: Text(
                  'Timed Groups',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                margin: EdgeInsets.symmetric(vertical: 5.0)),
            FutureBuilder(
              builder: (context, TimerGroupsSnapshot) {
                if (!TimerGroupsSnapshot.hasData) return Container();
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      List<TimeGroup> groups = TimerGroupsSnapshot.data;
                      return Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                color: Colors.white10),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${groups[index].name}',
                                  style: TextStyle(
                                    color: Colors.blue[200],
                                    fontSize: 20.0,
                                  ),
                                ),
                                FloatingActionButton.extended(
                                  heroTag: index,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.group_Times,
                                        arguments: groups[index]);
                                  },
                                  label: Text('Details'),
                                  icon: Icon(
                                    Icons.info,
                                    semanticLabel: 'See Details',
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: TimerGroupsSnapshot.data.length,
                  ),
                );
              },
              future: TimeGroup.getGroups(),
            )
          ],
        ),
        Column(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.add_Time_Group);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            bottomNavigator(),
          ],
        ),
      ],
    );
  }

  Widget LiftGroups() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            child: Text(
              'Lift Groups',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            margin: EdgeInsets.symmetric(vertical: 5.0),
          ),
          FutureBuilder(
            builder: (context, LiftGroupsSnapshot) {
              if (!LiftGroupsSnapshot.hasData) return Container();
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<LiftGroup> groups = LiftGroupsSnapshot.data;
                    return Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              color: Colors.white10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${groups[index].name}',
                                style: TextStyle(
                                  color: Colors.blue[200],
                                  fontSize: 20.0,
                                ),
                              ),
                              FloatingActionButton.extended(
                                heroTag: index,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.group_Lifts,
                                      arguments: groups[index]);
                                },
                                label: Text('Details'),
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'See Details',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: LiftGroupsSnapshot.data.length,
                ),
              );
            },
            future: LiftGroup.getGroups(),
          )
        ]),
        Column(
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.add_Lift_Group);
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            bottomNavigator(),
          ],
        )
      ],
    );
  }

  Widget bottomNavigator() {
    return BottomNavigationBar(
      currentIndex: widget.index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined),
          label: 'Timing Groups',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined),
          label: 'Lift Groups',
        ),
      ],
      onTap: (value) {
        setState(() {
          widget.index = value;
        });
      },
    );
  }
}
