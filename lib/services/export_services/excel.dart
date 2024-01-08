// ignore_for_file: avoid_print

import 'dart:io';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:checkmate/models/student_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:excel/excel.dart';

class ExcelExportService {
  static void exportAsExcel(
      BuildContext context, List<Student> students) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        print('Permission denied.');
        return;
      }
    }

    try {
      var directory = await getExternalStorageDirectory();
      var excel = Excel.createExcel();
      String sheetName = 'Students'; // Define the sheet name
      var sheet = excel[sheetName];
      // Headers
      sheet.appendRow([const TextCellValue('Name'), const TextCellValue('ID')]);

      // Data
      for (var student in students) {
        sheet.appendRow(
            [TextCellValue(student.name), TextCellValue(student.id)]);
      }

      var fileBytes = excel.encode();

      if (directory != null) {
        String filePath = '${directory.path}/students_attendance.xlsx';
        File file = File(filePath);
        await file.writeAsBytes(fileBytes!);

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
      print('Error while exporting Excel: $e');
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
