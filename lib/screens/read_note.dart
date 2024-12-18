import 'package:flutter/material.dart';
import 'package:notes_application/Db%20services/db_firestore.dart';

class ReadNote extends StatefulWidget {
  final String title, description, date, time;
  final Color color;
  final String docId;
  const ReadNote(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.color,
      required this.docId});

  @override
  State<ReadNote> createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
  double devHeight = 0.0, devWidth = 0.0;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  Color color = Colors.white;
  String date = "", time = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      title.text = widget.title;
      description.text = widget.description;
      color = widget.color;
      date = widget.date;
      time = widget.time;
    });
    print('${widget.docId}');
  }

  @override
  Widget build(BuildContext context) {
    devHeight = MediaQuery.of(context).size.height;
    devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure ?'),
                        content: Text('Do you want to delete this Note?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No',
                                  style: TextStyle(color: Colors.red))),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                DbFirestore().deleteNote(docId: widget.docId);
                                final snack =
                                    SnackBar(content: Text('Note Deleted'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                                Navigator.pop(context);
                              },
                              child: Text('Yes',
                                  style: TextStyle(color: Colors.green))),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            DbFirestore().updateNote(
                docId: widget.docId,
                title: title.text,
                description: description.text);
            final snack = SnackBar(content: Text('Note Updated'));
            ScaffoldMessenger.of(context).showSnackBar(snack);
            Navigator.pop(context);
          },
          child: Text('Update'),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: devHeight * 0.01,
          ),
          Text('Date & Time : $date ( $time )',
              style: TextStyle(color: Colors.black)),
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
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: fontSize,
                fontWeight:
                    isBold == true ? FontWeight.bold : FontWeight.normal),
            border: InputBorder.none),
      ),
    );
  }
}
