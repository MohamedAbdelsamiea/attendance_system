// ignore_for_file: avoid_print

import 'dart:io';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:checkmate/models/student_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFExportService {
  static void exportAsPDF(BuildContext context, List<Student> students) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        print('Permission denied.');
        return;
      }
    }
  
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: students.map((student) {
                return pw.Text('${student.name} - ${student.id}');
              }).toList(),
            ),
          );
        },
      ),
    );

    try {
      var directory = await getExternalStorageDirectory();
      var fileBytes = await pdf.save();
      
      if (directory != null) {
        String filePath = '${directory.path}/students_attendance.pdf';
        File file = File(filePath);
        await file.writeAsBytes(fileBytes);
        
        Fluttertoast.showToast(
          msg: 'File saved successfully to: $filePath',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Constants.primaryColor,
          textColor: Constants.secondaryColor,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Error while exporting PDF: $e');
      Fluttertoast.showToast(
        msg: 'Export failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Constants.errorColor,
        textColor: Constants.secondaryColor,
        fontSize: 16.0,
      );
    }
  }
}
