
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, camel_case_types, sized_box_for_whitespace

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class createPost extends StatefulWidget {
  @override
  _createPostState createState() => _createPostState();
}

class _createPostState extends State<createPost> {

  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  Future<void> postData() async {
    final url = Uri.parse(
        'https://us-central1-jonathan-cloud-func.cloudfunctions.net/kelvinfinal/create-post');
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "email": emailController.text,
      "description": descriptionController.text,
    };
    final body = json.encode(data);
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text("Post created successfully"),
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
    } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text("Post created successfully"),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 73, 68),
        title: const Text('Create a new post '),
        centerTitle: true,
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

       
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Post description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      onPressed: postData,
                      child: Text(
                        'Create new post',
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