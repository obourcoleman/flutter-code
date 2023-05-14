
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  final studentIdController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final majorController = TextEditingController();
  final residencyController = TextEditingController();
  final bestFoodController = TextEditingController();
  final bestMovieController = TextEditingController();
  final yearGroupController = TextEditingController();
  final dobController = TextEditingController();
  bool isLoading = false;

    Future<void> postData() async {
      
      setState(() {
        isLoading = true;
      });

      final url = Uri.parse('https://us-central1-jonathan-cloud-func.cloudfunctions.net/kelvinfinal/register');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'student_id': studentIdController.text,
        'name': nameController.text,
        'dob': dobController.text,
        'email': emailController.text,
        'major': majorController.text,
        'residency': residencyController.text,
        'best_food': bestFoodController.text,
        'best_movie': bestMovieController.text,
        'year_group': yearGroupController.text,
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
          // ignore: use_build_context_synchronously
          
          setState(() {
            isLoading = false;
          });

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text("Profile created successfully"),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
         final data = jsonDecode(response.body)['data'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('data', jsonEncode(data));


      } else {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Error'),
                content: Text("Profile failed "),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            );
        
          }
    }

  @override
  void initState(){
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
        title: const Text('Create Profile '),
        centerTitle: true,
      ),
      body: Center(
        child:SingleChildScrollView(
          child:  Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: studentIdController,
                    decoration: InputDecoration(
                      labelText: 'ID number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your student ID ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dobController,
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
                    controller: yearGroupController,
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
                    controller: majorController,
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
                    controller: residencyController,
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
                    controller: bestFoodController,
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
                    controller: bestMovieController,
                    decoration: InputDecoration(
                      labelText: 'Best Movie',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  isLoading ? Center(
                    child: CircularProgressIndicator(),
                  ) : 
                  SizedBox(
                    width: 630,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed:postData ,
                      child: Text(
                        'Create Profile',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        )
      ),
    );
  }
}