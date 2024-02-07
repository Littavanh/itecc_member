import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:itecc_member/controller/address_controller.dart';
import 'package:itecc_member/controller/check_token_key_controller.dart';
import 'package:itecc_member/controller/icon_and_background_controller.dart';
import 'package:itecc_member/controller/updateUser_controller.dart';
import 'package:itecc_member/model/province_model.dart';
import 'package:flutter/material.dart' show showCupertinoModalPopup;
import 'package:itecc_member/screen/onLogin/buttom_navigate.dart';
import 'package:itecc_member/services/todo_services.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itecc_member/style/color.dart';

import '../../alert/progress.dart';
import '../../component/customcontainer.dart';
import '../../controller/login_controller.dart';
import '../../style/size.dart';

final box = GetStorage();

class Profile extends StatefulWidget {
  Profile({super.key, required this.phone, required this.otp});
  final String phone;
  final String otp;

  @override
  State<Profile> createState() => _ProfileState();
}

final _picker = ImagePicker();

String imagepath = ""; //  for the path of my image
String base64String = "";
String fileExtension = "";
String _image = box.read('userImage');

class _ProfileState extends State<Profile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  final birthDateController = TextEditingController(text: '');
  int _gropRadioVal = 0;
  int villageId = 0;
  LoginController loginController = Get.put(LoginController());
  AddressController addressController = Get.put(AddressController());
  UpdateUserController updateUserController = Get.put(UpdateUserController());
  AppController appController = Get.put(AppController());
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController(text: widget.phone);
    final phoneController = TextEditingController(text: widget.phone);
    final otp = widget.otp;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [gra, dient],
                ),
              ),
            ),
            centerTitle: true,
            title: const Text("ຂໍ້ມູນສ່ວນຕົວ",
                style: TextStyle(color: Colors.white))),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _image == ""
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primaryColor,
                                          ),
                                          child: const Icon(
                                              Icons.account_circle_outlined,
                                              size: 150,
                                              color: icolor)),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                            children: [
                                              WidgetSpan(
                                                child: InkWell(
                                                    onTap: () =>
                                                        _choiceDialogImage(),
                                                    child: Text(
                                                      'ອັບໂຫຼດຮູບ',
                                                      style: TextStyle(
                                                          color: dient,
                                                          fontSize: 16),
                                                    )),
                                              ),
                                              WidgetSpan(
                                                child: InkWell(
                                                  onTap: () =>
                                                      _choiceDialogImage(),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: dient,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: _image,
                                            fit: BoxFit.fill,
                                            width: 150,
                                            height: 150,
                                            placeholder: (context, url) =>
                                                Container(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              radius: 50,
                                              child: ClipOval(
                                                  child: Image.file(
                                                File(
                                                  _image,
                                                ),
                                                fit: BoxFit.fill,
                                                width: 150,
                                                height: 150,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                            children: [
                                              WidgetSpan(
                                                child: InkWell(
                                                    onTap: () =>
                                                        _choiceDialogImage(),
                                                    child: Text(
                                                      'ອັບໂຫຼດຮູບ',
                                                      style: TextStyle(
                                                          color: dient,
                                                          fontSize: 16),
                                                    )),
                                              ),
                                              WidgetSpan(
                                                child: InkWell(
                                                  onTap: () =>
                                                      _choiceDialogImage(),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: dient,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _buildForm(userNameController, phoneController),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 28,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await updateUserController.postUpdateUser(
                            userName: userNameController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            dob: _dateTime.toString(),
                            gender: _gropRadioVal == 0 ? 'M' : 'F',
                            emailAddr: emailController.text,
                            villageCode: villageId.toString(),
                            userImage: base64String,
                            userImageExtention: extention);

                        await CheckTokenKeyController.postCheckTokenKey(
                            token: box.read('tokenKey'));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient:
                                const LinearGradient(colors: [gra, dient]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: 400,
                          height: 100,
                          alignment: Alignment.center,
                          child: const Text(
                            'ບັນທຶກ',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget _buildForm(userNameController, phoneController) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Form(
        child: Column(
          children: [
            CustomContainer1(
                title: const Text("ຊື່ຜູ້ໃຊ້",
                    style: TextStyle(color: Colors.black)),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.account_circle_outlined),
                  ),
                )),
            CustomContainer1(
                title: const Text("ຊື່", style: TextStyle(color: Colors.black)),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                  ),
                )),
            CustomContainer1(
                title: const Text("ນາມສະກຸນ",
                    style: TextStyle(color: Colors.black)),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                  ),
                )),
            CustomContainer1(
                title: const Text(
                  "ວັນທີເດືອນປີເກີດ",
                  style: TextStyle(color: Colors.black),
                ),
                child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: birthDateController,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        fillColor: textColor,
                        hoverColor: textColor,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 10),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      30), // radius of 10
                                              gradient: const LinearGradient(
                                                  colors: [gra, dient]),
                                            ),
                                            height: 400,
                                            child: CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime: _dateTime,
                                              onDateTimeChanged: (dateTime) {
                                                _dateTime = dateTime;
                                                birthDateController.text =
                                                    fmdate.format(_dateTime);
                                                // print(_dateTime);
                                                // print(birthDateController.text);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [gra, dient]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'ເລືອກ',
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.date_range))))),
            CustomContainer1(
                title: const Text("ເພດ", style: TextStyle(color: Colors.black)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: [
                        Radio(
                            value: 0,
                            activeColor: textColor,
                            groupValue: _gropRadioVal,
                            onChanged: (int? value) {
                              if (value != null) {
                                setState(() {
                                  _gropRadioVal = value;
                                });
                              }
                            }),
                        const Text("ຊາຍ", style: TextStyle(color: Colors.black))
                      ]),
                      Row(children: [
                        Radio(
                            value: 1,
                            activeColor: textColor,
                            groupValue: _gropRadioVal,
                            onChanged: (int? value) {
                              if (value != null) {
                                setState(() {
                                  _gropRadioVal = value;
                                });
                              }
                            }),
                        const Text('ຍິງ', style: TextStyle(color: Colors.black))
                      ])
                    ])),
            Obx(() => addressController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomContainer1(
                    title: const Text("ແຂວງ",
                        style: TextStyle(color: Colors.black)),
                    child: Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                              titleMedium: TextStyle(color: Colors.black))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSearchBox: true,
                            showSelectedItems: true,
                            // selectedItem: widget.user.profile.province!.name,
                            maxHeight: Get.height / 1.4,
                            searchFieldProps: const TextFieldProps(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    helperText: 'ເລືອກແຂວງ',
                                    hintText: 'ຄົ້ນຫາ',
                                    suffixIcon: Icon(Icons.search_rounded))),
                            dropdownSearchDecoration:
                                const InputDecoration(border: InputBorder.none),
                            items: addressController.provinceModel?.data!
                                .map((e) => e.provinceName)
                                .toList(),

                            // compareFn: (String? i, String? s) => (i == s) ? true : false,
                            onChanged: (value) {
                              for (var element
                                  in addressController.provinceModel!.data!) {
                                if (element.provinceName == value) {
                                  int provinceId =
                                      int.parse(element.provinceId!);
                                  print(provinceId);
                                  addressController.fetchDistrict(provinceId);
                                  // context
                                  //     .read<DistrictBloc>()
                                  //     .add(FetchDistrict(provinceId: provinceId));
                                  return;
                                }
                              }
                            }),
                      ),
                    ))),
            Obx(() => addressController.isLoading1.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomContainer1(
                    title: const Text("ເມືອງ",
                        style: TextStyle(color: Colors.black)),
                    child: Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                              titleMedium: TextStyle(color: Colors.black))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSearchBox: true,
                            showSelectedItems: true,
                            // selectedItem: widget.user.profile.province!.name,
                            maxHeight: Get.height / 1.4,
                            searchFieldProps: const TextFieldProps(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    helperText: 'ເລືອກເມືອງ',
                                    hintText: 'ຄົ້ນຫາ',
                                    suffixIcon: Icon(Icons.search_rounded))),
                            dropdownSearchDecoration:
                                const InputDecoration(border: InputBorder.none),
                            items: addressController.districtModel?.data!
                                .map((e) => e.districtName!)
                                .toList(),

                            // compareFn: (String? i, String? s) => (i == s) ? true : false,
                            onChanged: (value) {
                              for (var element
                                  in addressController.districtModel!.data!) {
                                if (element.districtName == value) {
                                  int districtId =
                                      int.parse(element.districtId!);
                                  print(districtId);
                                  addressController.fetchVillage(districtId);
                                  return;
                                }
                              }
                            }),
                      ),
                    ))),
            Obx(() => addressController.isLoading2.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomContainer1(
                    title: const Text("ບ້ານ",
                        style: TextStyle(color: Colors.black)),
                    child: Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                              titleMedium: TextStyle(color: Colors.black))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSearchBox: true,
                            showSelectedItems: true,
                            // selectedItem: widget.user.profile.province!.name,
                            maxHeight: Get.height / 1.4,
                            searchFieldProps: const TextFieldProps(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    helperText: 'ເລືອກບ້ານ',
                                    hintText: 'ຄົ້ນຫາ',
                                    suffixIcon: Icon(Icons.search_rounded))),
                            dropdownSearchDecoration:
                                const InputDecoration(border: InputBorder.none),
                            items: addressController.villageModel?.data!
                                .map((e) => e.villageName!)
                                .toList(),

                            // compareFn: (String? i, String? s) => (i == s) ? true : false,
                            onChanged: (value) {
                              for (var element
                                  in addressController.villageModel!.data!) {
                                if (element.villageName == value) {
                                  villageId = int.parse(element.villageId!);
                                  print(villageId);

                                  return;
                                }
                              }
                            }),
                      ),
                    ))),
            CustomContainer1(
                title:
                    const Text("ເບີໂທ", style: TextStyle(color: Colors.black)),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone),
                  ),
                )),
            CustomContainer1(
                title:
                    const Text("ອີເມລ", style: TextStyle(color: Colors.black)),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<ImageSource?> _choiceDialogImage() {
    return showDialog<ImageSource>(
        context: context,
        builder: (_context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              width: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _pickerImage(ImageSource.camera);
                              },
                              icon: const Icon(Icons.camera_alt_rounded,
                                  color: icolor)),
                          const Text(
                            "ກ້ອງຖ່າຍ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                  const Spacer(),
                  Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _pickerImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.image_rounded,
                                  color: icolor)),
                          const Text('ຮູບພາບ',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  String extention = "";
  Future<void> _pickerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      // imagepath = pickedFile.path;
      // print(imagepath);
      setState(() {
        _pickedFile = pickedFile;
      });
      if (_pickedFile != null) {
        // Crop Image
        final croppedFile = await ImageCropper().cropImage(
          cropStyle: CropStyle.circle,
          sourcePath: _pickedFile!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 70,
          uiSettings: [
            AndroidUiSettings(
                showCropGrid: false,
                toolbarTitle: 'Crop',
                toolbarColor: dient,
                toolbarWidgetColor: Colors.white,
                hideBottomControls: true,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: const CroppieBoundary(
                width: 520,
                height: 520,
              ),
              viewPort: const CroppieViewPort(
                  width: 480, height: 480, type: 'circle'),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            ),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            _croppedFile = croppedFile;
            print("_croppedFile: $_croppedFile");
          });
        }
      }

      String fileExtension = p.extension(_croppedFile!.path);
      extention = fileExtension.substring(1);
      print(extention);
      // now convert it into a file and then numbers or bytes
      File imagefile = File(_croppedFile!.path);
      // now converting into numbers

      Uint8List imagebytes = await imagefile.readAsBytes();
      // print(imagebytes); // 38439849384
      print("fileSize : ${imagebytes.lengthInBytes}"); // 38439849384

      final bytes = imagefile.readAsBytesSync().lengthInBytes;
      print("fileSize : $bytes"); // 38439849384
      final kb = bytes / 1024;
      print("fileSizeKB : $kb"); // 38439849384
      final mb = kb / 1024;
      print("fileSizeMB : $mb"); // 38439849384
      // now convert it into string
      base64String = base64.encode(imagebytes); // asdfjaklsdfjl//asdfasd348309
      print("base64String: $base64String");

      setState(() {
        if (_croppedFile!.path != "") {
          _image = _croppedFile!.path;
          print("_image: $_image");
        }
      });
      // now we can save it into database
    } else {
      print('No image is selected');
    }
  }

  void updateUser() async {
    print('---------------------------------');
  }
}
