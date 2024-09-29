import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_application/screens/add_notes.dart';

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
                      onPressed: () async {},
                      icon: Icon(Icons.search, size: 35))
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
                child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: mapList.length,
                    itemBuilder: (context, index) {
                      Color color = mapList[index]['color'];
                      return Card(
                        color: color,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: devWidth * 0.03,
                              vertical: devHeight * 0.03),
                          child: Column(
                            children: [
                              Text(mapList[index]['title'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(height: 10),
                              Text(mapList[index]['description'].toString(),
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                          mapList[index]['dateTime'].toString(),
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
