import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class Camera extends StatelessWidget {
  String from;
  Camera(String from) {
    this.from = from;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraState(this.from),
    );
  }
}

class CameraState extends StatefulWidget {
  String from;
  CameraState(String from) {
    this.from = from;
  }

  @override
  _MyCameraState createState() => _MyCameraState(from);
}

class _MyCameraState extends State<CameraState> {
  File _image;
  final picker = ImagePicker();
  String from;
  _MyCameraState(String from) {
    this.from = from;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future sendImage() async {
    // http.post('http://127.0.0.1:5000/api/v1/image_upload',
    //     body: {"image": _image});
    String fileName = _image.path.split('/').last;

    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(_image.path, filename: fileName)
    });

    Dio dio = new Dio();
    dio
        .post('http://23.233.161.96/api/v1/image_upload', data: data)
        .then((response) {
      if (response.statusCode == 200) {
        print("GOOD");
        print(response.data);
      } else {
        print("BAD");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.from);
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
        //child: Column(children: )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _image == null ? getImage : sendImage,
          tooltip: 'Pick Image',
          child: _image == null ? Icon(Icons.add_a_photo) : Icon(Icons.send)),
    );
  }
}
