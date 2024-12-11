import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_application/Db%20services/db_firestore.dart';

class AddNotes extends StatefulWidget {
  //hello
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  double devHeight = 0.0, devWidth = 0.0;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Color defaultColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    devHeight = MediaQuery.of(context).size.height;
    devWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: defaultColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              String dateStr = date.toString().split(' ')[0],
                  timeStr = time.toString().split("(")[1].substring(0, 5);
              if (title.text != "" && description.text != "") {
                print(title.text);
                DbFirestore.writeNotes(defaultColor.toString(),
                    title: title.text,
                    desc: description.text,
                    date: dateStr,
                    time: timeStr);
              } else {
                final snack = SnackBar(
                    content: Text('Title & Description Should not empty'));
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
              Navigator.pop(context);
            },
            child: Icon(Icons.done)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: devWidth * 0.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: defaultColor == Colors.white
                            ? Colors.black
                            : Colors.white,
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            final snack =
                                SnackBar(content: Text('Your notes is Pinned'));
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.mapPin,
                            size: 25,
                            color: defaultColor == Colors.white
                                ? Colors.black
                                : Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            reminderAlert(context);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.bell,
                            size: 25,
                            color: defaultColor == Colors.white
                                ? Colors.black
                                : Colors.white,
                          )),
                      IconButton(
                          onPressed: () async {
                            colorSheet(context);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.palette,
                            size: 25,
                            color: defaultColor == Colors.white
                                ? Colors.black
                                : Colors.white,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: devHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                        'Remind me at : ${date.toString().split(' ')[0]} | ${time.toString().split("(")[1].substring(0, 5)}'),
                  ),
                ],
              ),
              SizedBox(
                height: devHeight * 0.01,
              ),
              tField(
                  controller: title,
                  fontSize: 25,
                  hintText: 'Enter a title ...',
                  isBold: true),
              SizedBox(
                height: devHeight * 0.03,
              ),
              tField(
                  controller: description,
                  fontSize: 20,
                  hintText: 'Enter a description ...',
                  isBold: false),
            ],
          ),
        ),
      ),
    );
  }

// this alert lets user to pick a date and time for the reminder
  Future<dynamic> reminderAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('When to remind ?'),
            content: SizedBox(
              height: 110,
              child: Column(children: [
                TextFormField(
                  initialValue: date.toString().split(' ')[0],
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    isDense: true,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2026),
                              initialDate: DateTime.now());

                          if (pickedDate != null) {
                            setState(() {
                              date = pickedDate;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_month)),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue:
                      '${time.toString().split("(")[1].substring(0, 5)} AM',
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            setState(() {
                              time = pickedTime;
                            });
                          }
                        },
                        icon: Icon(Icons.alarm_add)),
                  ),
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: defaultColor == Colors.white
                          ? Colors.blue
                          : defaultColor,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  //It Displays the Color sheet at the bottom of the page
  Future<dynamic> colorSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: devHeight * 0.2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: devWidth * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  colorContainer(color: Colors.red.shade300),
                  colorContainer(color: Colors.blue),
                  colorContainer(
                    color: Color.fromARGB(255, 98, 198, 149),
                  ),
                  colorContainer(color: Colors.pinkAccent),
                  colorContainer(color: Colors.orangeAccent),
                ],
              ),
            ),
          );
        });
  }

//This Container acts as a Color palette
  Widget colorContainer({required Color color}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          defaultColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        height: devHeight * 0.08,
        width: devWidth * 0.15,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

// This is a Dynamic TextField (In My case for ... title & description)
  Widget tField(
      {required TextEditingController controller,
      required String hintText,
      required double fontSize,
      required bool isBold}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: devWidth * 0.03),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: fontSize,
          color: defaultColor == Colors.white ? Colors.black : Colors.white,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: fontSize,
                color:
                    defaultColor == Colors.white ? Colors.black : Colors.white,
                fontWeight:
                    isBold == true ? FontWeight.bold : FontWeight.normal),
            border: InputBorder.none),
      ),
    );
  }
}
