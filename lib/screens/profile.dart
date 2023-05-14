// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, unused_field, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfilePage extends StatefulWidget {
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  String? studentIdFromJson;

  String? _email;
  String? _name;
  String? _major;
  String? _dob;
  String? _year_group;
  String? _residency;
  String? _best_food;
  String? _best_movie;

  late String url;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('data');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      var studentId = jsonData['student_id'];
      studentIdFromJson = jsonData['student_id'];
      url =
          'https://us-central1-jonathan-cloud-func.cloudfunctions.net/kelvinfinal/view-profile/$studentId';
      final response = await http.get(Uri.parse(url), headers: {
        'Access-Control-Allow-Origin': '*',
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        setState(() {
          _email = jsonData['email'];
          _name = jsonData['name'];
          _major = jsonData['major'];
          _dob = jsonData["dob"];
          _residency = jsonData['residency'];
          _best_food = jsonData['best_food'];
          _best_movie = jsonData['best_movie'];
          _year_group = jsonData["year_group"];
        });
      } else {
        Fluttertoast.showToast(msg: "Failed to load data");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
        centerTitle: true,
        title: Text("View Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
  
            SizedBox(height: 30),
            _buildProfileItem('Student ID', studentIdFromJson ?? ""),
            Divider(height: 30),
            _buildProfileItem('Name', _name ?? ""),
            Divider(height: 30),
            _buildProfileItem('Email', _email ?? ""),
            Divider(height: 30),
            _buildProfileItem('Major', _major ?? ""),
            Divider(height: 30),
            _buildProfileItem('Best Food', _best_food ?? ""),
            Divider(height: 30),
            _buildProfileItem('Best Movie', _best_movie ?? ""),
            Divider(height: 30),
            _buildProfileItem('Campus Residency', _residency ?? ""),
            SizedBox(height: 30),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}