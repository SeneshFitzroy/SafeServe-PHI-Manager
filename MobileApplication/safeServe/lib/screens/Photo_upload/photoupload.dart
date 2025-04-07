import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _handleSubmit() {
    // Add your upload logic here
    if (_image != null) {
      // Upload the image to server or process it
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading photo...')),
      );
      // Navigate to next screen or show confirmation
    } else {
      // Show error that no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
    }
  }

  void _handlePrevious() {
    // Navigate back or to the previous step
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [const Color(0xFFE6F5FE), const Color(0xFFF5ECF9)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 44,
                child: Text(
                  'SafeServe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F41BB),
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 299,
                top: 41,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFCDE6FE),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 349,
                top: 41,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCDE6FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 304,
                top: 46,
                child: Container(
                  width: 25,
                  height: 24,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 353,
                top: 42,
                child: Container(
                  width: 27,
                  height: 33,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 33,
                top: 35,
                child: Container(
                  width: 36,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/36x38"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 136,
                child: Text(
                  'Photo Upload',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Photo display area with functionality
              Positioned(
                left: 33,
                top: 209,
                child: Container(
                  width: 351,
                  height: 533,
                  decoration: BoxDecoration(
                    color: const Color(0xFF575656),
                  ),
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library,
                              size: 80,
                              color: Colors.white70,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No image selected',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _getImageFromCamera,
                                  icon: Icon(Icons.camera_alt),
                                  label: Text('Camera'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1F41BB),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton.icon(
                                  onPressed: _getImageFromGallery,
                                  icon: Icon(Icons.photo),
                                  label: Text('Gallery'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1F41BB),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 20,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              // Previous button with functionality
              Positioned(
                left: 166,
                top: 786,
                child: GestureDetector(
                  onTap: _handlePrevious,
                  child: Container(
                    width: 102,
                    height: 38,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          color: const Color(0xFF1F41BB),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Previous',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF1F41BB),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Submit button with functionality
              Positioned(
                left: 282,
                top: 786,
                child: GestureDetector(
                  onTap: _handleSubmit,
                  child: Container(
                    width: 102,
                    height: 38,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1F41BB),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          color: const Color(0xFF1F41BB),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
