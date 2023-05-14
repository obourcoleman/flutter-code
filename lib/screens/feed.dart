import 'package:intl/intl.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://us-central1-jonathan-cloud-func.cloudfunctions.net/kelvinfinal/feed'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final posts = (jsonData['posts'] as List).cast<Map<String, dynamic>>();

      posts.sort((a, b) {
        final aDate = DateFormat('EEE, d MMM yyyy HH:mm:ss z').parse(a['date']);
        final bDate = DateFormat('EEE, d MMM yyyy HH:mm:ss z').parse(b['date']);
        return bDate.compareTo(aDate); // sort in descending order
      });

      setState(() {
        _posts = posts;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text("Feed"),
      ),
      body: _posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/user.png"),
                      ),
                      title: Text(post['email']),
                      trailing: Icon(Icons.more_horiz),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        post['description'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}