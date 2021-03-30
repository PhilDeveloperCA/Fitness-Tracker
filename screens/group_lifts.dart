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
  int weight = 0;
  int reps = 0;
  final _weightController = TextEditingController();
  final _repController = TextEditingController();

  void weightControls() {
    if (_weightController.text != '') {
      setState(() {
        this.weight = int.parse(_weightController.text);
      });
    }
  }

  void repControls() {
    if (_repController.text != '') {
      setState(() {
        this.reps = int.parse(_repController.text);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _repController.addListener(repControls);
    _weightController.addListener(weightControls);
  }

  void SubmitGoal() async {
    await Lift.SaveGoal(new Lift(widget.group.id, this.weight, this.reps));

    _repController.clear();
    _weightController.clear();
    setState(() {
      this.weight = 0;
      this.reps = 0;
    });
  }

  @override
  void dispose() {
    _repController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 400,
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
      return SingleChildScrollView(
        child: Column(
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
                  padding: EdgeInsets.only(top: 20.0, left: 20.0),
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
            Text('Goals : '),
            Container(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container();
                  else
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${snapshot.data[index].weight} x ${snapshot.data[index].quantity}'),
                                  TextButton(
                                      onPressed: () {
                                        Lift.DeleteGoal(
                                            snapshot.data[index].id);
                                        setState(() {});
                                      },
                                      child: Text('Delete on Reload'))
                                ],
                              ),
                            )
                          ],
                        ),
                        itemCount: snapshot.data.length,
                      ),
                    );
                },
                future: Lift.getLiftGoals(widget.group.id),
              ),
            ),
            Form(
              child: Column(
                children: [
                  Text('Add New Goal : '),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _repController,
                    decoration: InputDecoration(
                      labelText: 'Reps',
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      SubmitGoal();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            bottom(),
          ],
        ),
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
      ],
    );
  }
}
