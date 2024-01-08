// ignore_for_file: unused_import, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:checkmate/models/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class APIService {
  static Future<List<Student>> takeAttendance(XFile imageFile) async {
    String apiUrl = 'http://10.112.101.175:5000/predict';
    Uint8List? compress = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 70);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      List<int> compressedData = compress ?? <int>[];
      request.files.add(http.MultipartFile.fromBytes(
          'file', filename: "Compressed_image.jpg", compressedData));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Student> students = data.map((student) {
          return Student.fromJson(student);
        }).toList();
        print(data);
        return students;
      } else {
        throw Exception('Failed to take attendance');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
