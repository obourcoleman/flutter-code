// ignore_for_file: camel_case_types, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? studentId;
  bool isLoading = false;

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _residencyController = TextEditingController();
  final TextEditingController _bestFoodController = TextEditingController();
  final TextEditingController _bestMovieController = TextEditingController();

  Future<void> editProfile() async {
    setState(() {
      isLoading = true;
    });
    String url =
        'https://us-central1-jonathan-cloud-func.cloudfunctions.net/kelvinfinal/edit-profile/$studentId';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> data = {
      'dob': _dobController.text,
      'year_group': _yearGroupController.text,
      'major': _majorController.text,
      'residency': _residencyController.text,
      'best_food': _bestFoodController.text,
      'best_movie': _bestMovieController.text,
    };

    var response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      

      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Profile edited successfully", webPosition: "left");
    } else {
      // Error
      Fluttertoast.showToast(msg: "An error occured", webPosition: "left");
    }
  }

  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? jsonString = prefs.getString('data');
      if (jsonString != null) {
        Map<String, dynamic> jsonData = json.decode(jsonString);
        studentId = jsonData['student_id'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
        brightness: Brightness.dark,
        centerTitle: true,
        title: const Text('Edit Profile '),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _yearGroupController,
                    decoration: InputDecoration(
                      labelText: 'Year Group',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _majorController,
                    decoration: InputDecoration(
                      labelText: 'Major',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _residencyController,
                    decoration: InputDecoration(
                      labelText: 'Residency',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _bestFoodController,
                    decoration: InputDecoration(
                      labelText: 'Best Food',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _bestMovieController,
                    decoration: InputDecoration(
                      labelText: 'Best Movie',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: 740,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: editProfile,
                            child: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 138, 73, 68),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}