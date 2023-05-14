 // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

 import 'package:flutter/material.dart';
import 'package:frontend/screens/create.dart';
import 'package:frontend/screens/feed.dart';
import 'package:frontend/screens/post.dart';
import 'package:frontend/screens/profile.dart';


import 'edit.dart';
import 'package:flutter/material.dart';



class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to AshVerse'),
          centerTitle: true,
        ),
        body: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 6.0,
          padding: EdgeInsets.all(80.0),
          children: [
             ElevatedButton.icon(
              icon: Icon(Icons.person_add),
              label: Text('Create Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateProfile()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Profile Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.rss_feed),
              label: Text('Feed Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Feed()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Create Post'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createPost()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}