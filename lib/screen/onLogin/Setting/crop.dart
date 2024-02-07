//  Future<void> _pickerImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       // imagepath = pickedFile.path;
//       // print(imagepath);
//       setState(() {
//         _pickedFile = pickedFile;
//       });
//       if (_pickedFile != null) {
//         // Crop Image
//         final croppedFile = await ImageCropper().cropImage(
//           cropStyle: CropStyle.circle,
//           sourcePath: _pickedFile!.path,
//           compressFormat: ImageCompressFormat.jpg,
//           compressQuality: 100,
//           uiSettings: [
//             AndroidUiSettings(showCropGrid: false,
//                 toolbarTitle: 'Crop',
//                 toolbarColor: dient,
//                 toolbarWidgetColor: Colors.white,
//                 hideBottomControls: true,
//                 initAspectRatio: CropAspectRatioPreset.ratio4x3,
//                 lockAspectRatio: false),
//             IOSUiSettings(
//               title: 'Cropper',
//             ),
//             WebUiSettings(
//               context: context,
//               presentStyle: CropperPresentStyle.dialog,
//               boundary: const CroppieBoundary(
//                 width: 520,
//                 height: 520,
//               ),
//               viewPort: const CroppieViewPort(
//                   width: 480, height: 480, type: 'circle'),
//               enableExif: true,
//               enableZoom: true,
//               showZoomer: true,
//             ),
//           ],
//         );
//         if (croppedFile != null) {
//           setState(() {
//             _croppedFile = croppedFile;
//             print("_croppedFile: $_croppedFile");
//           });
//         }
//       }

//       String fileExtension = p.extension(_croppedFile!.path);
//       extention = fileExtension.substring(1);
//       print(extention);
//       // now convert it into a file and then numbers or bytes
//       File imagefile = File(_croppedFile!.path);
//       // now converting into numbers

//       Uint8List imagebytes = await imagefile.readAsBytes();
//       // print(imagebytes); // 38439849384

//       // now convert it into string
//       base64String = base64.encode(imagebytes); // asdfjaklsdfjl//asdfasd348309
//       print("base64String: $base64String");

//       setState(() {
//         if (_croppedFile!.path != "") {
//           image = _croppedFile!.path;
//           print("image: $image");
//         }
//       });
//       // now we can save it into database
//     } else {
//       print('No image is selected');
//     }
//   }