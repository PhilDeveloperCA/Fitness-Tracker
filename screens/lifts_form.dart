import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_app/models/lift.dart';
import 'package:stopwatch_app/models/lift_group.dart';
import 'package:stopwatch_app/util/route_names.dart';

class LiftForm extends StatefulWidget {
  final LiftGroup liftgroup;
  LiftForm(this.liftgroup);
  @override
  _LiftFormState createState() => _LiftFormState();
}

class _LiftFormState extends State<LiftForm> {
  int weight;
  int reps;

  void handleSubmit() async {
    if (_formkey.currentState.validate()) {
      await Lift.saveLift(new Lift(widget.liftgroup.id, weight, reps));
      Navigator.pushNamed(context, RouteNames.group_Lifts,
          arguments: widget.liftgroup);
    } else
      return;
  }

  void handleWeight() {
    if (_weightController.text == '') return;
    setState(() {
      this.weight = int.parse(_weightController.text);
    });
  }

  void handleReps() {
    if (_repsController.text == '') return;
    setState(() {
      reps = int.parse(_repsController.text);
    });
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    _weightController.addListener(handleWeight);
    _repsController.addListener(handleReps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.liftgroup.name),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0),
                child: Text(
                  'Weight:',
                  style: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 2.0,
                    color: Colors.blue[500],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _weightController,
                validator: (value) =>
                    value.length == 0 ? 'Enter a Weight Ammount' : null,
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0),
                child: Text(
                  'Reps:',
                  style: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 2.0,
                    color: Colors.blue[500],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _repsController,
                validator: (value) =>
                    value.length == 0 ? 'Enter a Repitition Ammount' : null,
              ),
            ),
            Align(
              child: FloatingActionButton(
                onPressed: handleSubmit,
                child: Text('Submit'),
              ),
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    );
  }
}
