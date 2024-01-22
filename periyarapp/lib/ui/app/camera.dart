// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> {
//   /// Variables

//   File? imageFile;

//   /// Widget
//   @override
//   Widget build(BuildContext context) {
//     print("inside");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image Picker"),
//       ),
//       body: Container(
//         child: imageFile == null
//             ? Container(
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     MaterialButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       onPressed: () {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (context) {
//                               return Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   ListTile(
//                                     leading: new Icon(Icons.camera_alt),
//                                     title: new Text('PICK FROM CAMERA'),
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                       _getFromCamera();
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: new Icon(Icons.photo),
//                                     title: new Text('PICK FROM GALLERY'),
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                       _getFromGallery();
//                                     },
//                                   ),
//                                 ],
//                               );
//                             });
//                       },
//                       padding: EdgeInsets.only(
//                           left: 30, right: 30, top: 15, bottom: 15),
//                       color: Colors.greenAccent,
//                       child: Text(
//                         'Click Me',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.6),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             : Container(
//                 child: Image.file(
//                   imageFile!,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//       ),
//     );
//   }

//   /// Get from gallery
//   _getFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   /// Get from Camera
//   _getFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }
// }
