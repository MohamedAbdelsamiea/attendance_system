import 'package:checkmate/designs/buttons.dart';
import 'package:checkmate/models/student_model.dart';
import 'package:checkmate/services/export_services/excel.dart';
import 'package:checkmate/services/export_services/pdf.dart';
import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';

class ExportData {
  void _exportData(BuildContext context, List<Student> students) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Export Data',
            style: TextStyle(
                fontFamily: 'Britanica', color: Constants.tertiaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ButtonStyles.smallraisedButtonStyle,
                onPressed: () =>
                    PDFExportService.exportAsPDF(context, students),
                child: const Text('Export as PDF'),
              ),
              ElevatedButton(
                style: ButtonStyles.smallraisedButtonStyle,
                onPressed: () => ExcelExportService(),
                child: const Text('Export as Excel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
