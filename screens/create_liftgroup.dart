import 'package:flutter/material.dart';
import 'package:stopwatch_app/models/lift_group.dart';
import 'package:stopwatch_app/util/route_names.dart';

class CreateLiftGroup extends StatefulWidget {
  @override
  _CreateLiftGroupState createState() => _CreateLiftGroupState();
}

class _CreateLiftGroupState extends State<CreateLiftGroup> {
  String name;
  String description;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();

  void _saveForm() async {
    if (_form.currentState.validate()) {
      LiftGroup.saveLift(new LiftGroup.fromForm(this.name, this.description));
      Navigator.pushNamed(context, RouteNames.home);
    } else
      return;
  }

  setname() {
    setState(() {
      this.name = nameController.text;
    });
  }

  setdesription() {
    setState(() {
      this.description = descriptionController.text;
    });
  }

  void initState() {
    super.initState();

    nameController.addListener(setname);
    descriptionController.addListener(setdesription);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Group'),
      ),
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0),
                    child: Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 2.0,
                        color: Colors.blue[500],
                      ),
                    )),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  child: TextFormField(
                    validator: (value) => value.length < 3 || value.length > 20
                        ? 'enter valid description'
                        : null,
                    controller: nameController,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top: 10.0, bottom: 25.0, left: 5.0),
                  child: Text(
                    'Desription:',
                    style: TextStyle(
                        color: Colors.blue[500],
                        fontSize: 22.0,
                        letterSpacing: 2.0),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: TextFormField(
                    validator: (value) =>
                        value.length < 3 ? 'enter valid description' : null,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    textInputAction: TextInputAction.newline,
                    controller: descriptionController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Description for this workout : ',
                        border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _saveForm,
              child: Container(
                padding: EdgeInsets.all(3.0),
                margin: EdgeInsets.symmetric(vertical: 50.0),
                color: Colors.blue[600],
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
