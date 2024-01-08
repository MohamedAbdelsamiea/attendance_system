import 'package:checkmate/designs/textstyles.dart';
import 'package:checkmate/services/export_services/export_data.dart';
import 'package:checkmate/models/student_model.dart';
import 'package:checkmate/designs/bottom_nav.dart';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';

class StudentInfoPage extends StatefulWidget {
  final List<Student> students;

  const StudentInfoPage({super.key, required this.students});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
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
      body: ListView.builder(
        itemCount: widget.students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.students[index].name,
                style: MyTextStyle.bodyTextStyle),
            subtitle: Text('ID: ${widget.students[index].id}',
                style: MyTextStyle.subbodyTextStyle),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        shape: const CircleBorder(eccentricity: 1.0),
        onPressed: () => ExportData,
        child: const Icon(Icons.file_download, color: Constants.secondaryColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavBar(
        bottomNavIndex: 1,
      ),
    );
  }
}
