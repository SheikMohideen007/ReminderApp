import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_application/Db%20services/db_firestore.dart';
import 'package:notes_application/auth/authentication.dart';
import 'package:notes_application/screens/add_notes.dart';
import 'package:notes_application/screens/read_note.dart';

class DisplayNotes extends StatefulWidget {
  const DisplayNotes({super.key});

  @override
  State<DisplayNotes> createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  double devHeight = 0.0, devWidth = 0.0;
  List<Map<String, dynamic>> mapList = [
    {
      "title": "Title 1",
      "description": "Descriptiion 1 2 3 4 5  56",
      "dateTime": "29 Sep, 12.00 AM",
      "color": Colors.blue
    },
    {
      "title": "Title 2",
      "description":
          "Descriptiion 1 2 3 4 5  56 jhd jh d j sj jh shj shj Descriptiion 1 2 3 4 5  56 jhd jh d j sj jh shj shj ",
      "dateTime": "30 Sep, 12.55 AM",
      "color": Colors.red.shade300
    },
    {
      "title": "Title 3",
      "description": "Descriptiion 1 2 3 4 5  56 jbsjbs",
      "dateTime": "01 Oct, 12.00 AM",
      "color": Colors.orangeAccent
    },
    {
      "title": "Title 4",
      "description": "Descriptiion 1 2 3 4 5  56jhv  j sd jh s",
      "dateTime": "01 Oct, 1.00 PM",
      "color": Colors.purple
    }
  ];

  @override
  Widget build(BuildContext context) {
    devHeight = MediaQuery.of(context).size.height;
    devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNotes()));
          },
          child: Icon(Icons.add)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: devWidth * 0.01),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: devWidth * 0.009),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: devHeight * 0.14,
                      width: devWidth * 0.14,
                      child: Image.asset('images/profile.png')),
                  IconButton(
                      onPressed: () async {
                        AuthService().signOut();
                      },
                      icon: Icon(Icons.logout, size: 35))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Reminders ..',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
                ],
              ),
              SizedBox(
                height: devHeight * 0.01,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: DbFirestore().fetchNotes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      int notesLength = snapshot.data!.docs.length;
                      return MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemCount: notesLength,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            String docId = ds.id;
                            Map note = ds.data() as Map;
                            String colorStr = note['color'];
                            Color color = Colors.blue;
                            try {
                              colorStr = colorStr.split(":")[1];
                              colorStr = colorStr.substring(0, colorStr.length);
                              color = getColor(colorStr);
                            } catch (e) {
                              color = getColor(colorStr);
                            }

                            return GestureDetector(
                              onTap: () {
                                // Read screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReadNote(
                                              title: note['title'],
                                              description: note['description'],
                                              date: note['date'],
                                              time: note['time'],
                                              color: color,
                                              docId: docId,
                                            )));
                              },
                              child: Card(
                                color: color,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: devWidth * 0.03,
                                      vertical: devHeight * 0.03),
                                  child: Column(
                                    children: [
                                      Text(note['title'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      SizedBox(height: 10),
                                      Text(note['description'].toString(),
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                  note['date'].toString(),
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(note['time'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(String colorString) {
    //Extract the hex value
    String hex = colorString.replaceAll(RegExp(r'[^0-9a-fA-F]'), "");
    // print("0xffff4081");

    return Color(int.parse(hex, radix: 16));
  }
}
