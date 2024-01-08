// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:checkmate/designs/bottom_nav.dart';
import 'package:checkmate/designs/buttons.dart';
import 'package:checkmate/designs/circular_prog_indicator.dart';
import 'package:checkmate/designs/textstyles.dart';
import 'package:checkmate/models/student_model.dart';
import 'package:checkmate/pages/attendance_list.dart';
import 'package:checkmate/services/services_api.dart';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image;
  bool _showOptions = false;
  bool _isLoading = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  void _takeAttendance() async {
    if (_image != null) {
      try {
        setState(() {
          _isLoading = true; // Set loading state before API call
        });

        // Use _image directly, assuming it's a File object representing the image
        List<Student> students =
            await APIService.takeAttendance(XFile(_image!.path));

        setState(() {
          _isLoading = false; // Set loading state to false after API call
        });

        Get.to(StudentInfoPage(students: students));
      } catch (e) {
        setState(() {
          _isLoading = false; // Set loading state to false on error
        });
        print('API Error: $e');
      }
    } else {
      print('Image not selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          leading: null,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/logo.png', height: 35, width: 35),
            )
          ],
          backgroundColor: Constants.secondaryColor,
          title: const Center(
            child: Row(
              children: [
                Text('Check', style: MyTextStyle.headingStyle1),
                Text('mate', style: MyTextStyle.headingStyle2),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _toggleOptions(); // Show/hide options when image is tapped
                  });
                },
                child: _image != null
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: Image.file(
                          File(_image!.path),
                          height: 300,
                          width: 500,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Center(
                          child: Image.asset(
                            'images/img.png',
                            height: 100,
                            width: 300,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              _showOptions
                  ? Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyles.smallraisedButtonStyle,
                          onPressed: () async {
                            setState(() {
                              _toggleOptions(); // Hide options after selection
                            });
                            await _getImage(ImageSource.gallery);
                          },
                          child: const Text('Choose from Gallery'),
                        ),
                        ElevatedButton(
                          style: ButtonStyles.smallraisedButtonStyle,
                          onPressed: () async {
                            setState(() {
                              _toggleOptions(); // Hide options after selection
                            });
                            await _getImage(ImageSource.camera);
                          },
                          child: const Text('Take Photo'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      style: ButtonStyles.smallraisedButtonStyle,
                      onPressed: () {
                        setState(() {
                          _showOptions = true; // Show options on button press
                        });
                      },
                      child: const Text('Insert Image'),
                    ),
              ElevatedButton(
                style: ButtonStyles.smallraisedButtonStyle,
                onPressed: _takeAttendance,
                child: const Text('Take Attendance'),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CustomCircularProgressIndicator(), // Show indicator if loading
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            backgroundColor: Constants.secondaryColor,
            shape: const CircleBorder(eccentricity: 1.0),
            child: Image.asset('images/applogo.png',
                height: 55, width: 55, alignment: Alignment.center)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavBar(bottomNavIndex: 0));
  }
}
