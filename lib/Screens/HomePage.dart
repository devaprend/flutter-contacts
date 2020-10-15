import 'package:contact/Screens/SearchDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'view_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  navigateToViewScreen(id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ViewContact(id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0e0e0),
      appBar: AppBar(
        backgroundColor: Color(0xFF212121),
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showDialog(context: context, builder: (_) => SearchDialog());
            },
          )
        ],
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference.orderByChild('firstName'),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return GestureDetector(
              onTap: () {
                navigateToViewScreen(snapshot.key);
              },
              child: Card(
                color: Color(0xFFfafafa),
                elevation: 3.0,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: snapshot.value['photoUrl'] == "empty"
                                    ? AssetImage("assets/logo.png")
                                    : NetworkImage(
                                        snapshot.value['photoUrl']))),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 1.0,
                                ),
                                Text(
                                  '${snapshot.value['firstName']} ${snapshot.value['lastName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 1.0,
                                ),
                                Text(
                                  'Cel: ',
                                ),
                                Text(
                                  '${snapshot.value['phone']}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
