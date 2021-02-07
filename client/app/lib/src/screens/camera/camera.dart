import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class Camera extends StatelessWidget {
  String from;
  Camera(String from) {
    this.from = from;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CameraState(this.from),
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

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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

    String endpoint = "http://23.233.161.96/api/v1/" + this.from;

    Dio dio = new Dio();
    dio.post(endpoint, data: data).then((response) {
      if (response.statusCode == 200) {
        print("GOOD");
        List<dynamic> items = response.data;
        String data = jsonEncode(items);
        Navigator.pushNamed(context, '/multiadd', arguments: data);
      } else {
        print("BAD");
      }
    });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add_a_photo, color: Colors.white),
          backgroundColor: Color(0xff00BFA6),
          onTap: getImage,
          label: 'Take a picture',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green[50],
        ),
        SpeedDialChild(
          child: Icon(Icons.file_upload, color: Colors.white),
          backgroundColor: Color(0xff00BFA6),
          onTap: selectImage,
          label: 'Add a picture',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green[50],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: _image == null ? getImage : sendImage,
      //     tooltip: 'Pick Image',
      //     child: _image == null ? Icon(Icons.add_a_photo) : Icon(Icons.send)),
      floatingActionButton: _image == null
          ? buildSpeedDial()
          : FloatingActionButton(
              onPressed: sendImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.send)),
    );
  }
}
