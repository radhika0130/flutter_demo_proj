import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  final String title = "Image Picker";

  @override
  State<StatefulWidget> createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePickers> {
  File _image;
  Future<File> imageFile;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      print(image);
      _image = image ;
    });
  }


  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile  = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              showImage(),
              RaisedButton(
                child: Text("Select Image from Gallery"),
                onPressed: () {
                  pickImageFromGallery(ImageSource.gallery);
                },
              ),
              Expanded(
                child: _image == null ? Text('No image selected.') : Image.file(_image),
              ),

            ],

          ),




      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*child: */
/*hild :_image == null ? Text('No image selected.') : Image.file(_image)*/
