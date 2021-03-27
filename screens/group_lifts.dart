import 'package:flutter/material.dart';
import 'package:stopwatch_app/models/lift.dart';
import 'package:stopwatch_app/models/lift_group.dart';
import 'package:stopwatch_app/util/route_names.dart';

class GroupLifts extends StatefulWidget {
  LiftGroup group;
  GroupLifts(this.group);
  @override
  _GroupLiftsState createState() => _GroupLiftsState();
}

class _GroupLiftsState extends State<GroupLifts> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.group.description);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.home);
            },
          ),
        ],
        title: Text('${widget.group.name}'),
      ),
      body: mainbody(),
    );
  }

  Widget mainbody() {
    if (this.index == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          FutureBuilder(
            builder: (context, TimeSnapshot) {
              if (TimeSnapshot.hasData == false)
                return Container();
              else
                return SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '${TimeSnapshot.data[index].month} - ${TimeSnapshot.data[index].day} - ${TimeSnapshot.data[index].year}'),
                              Text(
                                  '${TimeSnapshot.data[index].weight}  x  ${TimeSnapshot.data[index].quantity}')
                            ],
                          ),
                        ),
                      ],
                    ),
                    itemCount: TimeSnapshot.data.length,
                  ),
                );
            },
            future: Lift.getLifts(widget.group.id),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 0.0),
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.add_Lift,
                          arguments: widget.group);
                    },
                    child: Icon(
                      Icons.add,
                      size: 30.0,
                    )),
              ),
            ),
          ),
          bottom(),
        ],
      );
    } else
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Overview / Goals ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                  ),
                ),
                padding: EdgeInsets.only(top: 20.0),
              ),
              Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0),
                child: Text(
                  'Description : ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text('${widget.group.description} ',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16.0,
                    )),
              )
            ],
          ),
          bottom(),
        ],
      );
  }

  Widget bottom() {
    return BottomNavigationBar(
        currentIndex: this.index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Records',
          ),
        ]);
  }
}
