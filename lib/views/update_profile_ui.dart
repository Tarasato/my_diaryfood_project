// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/services/call_api.dart';
import 'package:my_diaryfood_project/utils/env.dart';

class UpdateProfileUI extends StatefulWidget {
  Member? member;
  UpdateProfileUI({super.key, this.member});

  @override
  State<UpdateProfileUI> createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {
  //ตัวแปรเปิดปิดตา ของช่องรหัสผ่าน
  bool passStatus = true;

  // สร้างตัวแปรควบคุม TextField
  TextEditingController memFullnameCtrl = TextEditingController(text: '');
  TextEditingController memUsernameCtrl = TextEditingController(text: '');
  TextEditingController memPasswordCtrl = TextEditingController(text: '');
  TextEditingController memEmailCtrl = TextEditingController(text: '');
  TextEditingController memAgeCtrl = TextEditingController(text: '');

  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future showCompleteDialog(context, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'ผลการทำงาน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //method เปิดกล้องถ่ายรูป
  Future<void> _openCamera() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

  // สร้างตัวแปร image ให้เก็บไฟล์ภาพที่ถ่ายจากกล้อง/เลือกจากแกลลอรี่
  File? _imageSelected;

  String? _image64Selected;

  //method เปิดแกลลอรี่เลือกรูป
  Future<void> _openGallery() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    memFullnameCtrl.text = widget.member!.memFullname!;
    memUsernameCtrl.text = widget.member!.memUsername!;
    memPasswordCtrl.text = widget.member!.memPassword!;
    memEmailCtrl.text = widget.member!.memEmail!;
    memAgeCtrl.text = widget.member!.memAge!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.green),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: widget.member!.memImage == '' &&
                                _imageSelected == null
                            ? NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                              )
                            : widget.member!.memImage != null &&
                                    _imageSelected == null
                                ? NetworkImage(
                                    '${Env.hostName}/mydiaryfood/assets/images/picupload/memImages/${widget.member!.memImage}',
                                  )
                                : _imageSelected != null
                                    ? FileImage(_imageSelected!)
                                    : NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                      ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                _openCamera()
                                    .then((value) => Navigator.pop(context));
                              },
                              leading: Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Open Camera...',
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 5.0,
                            ),
                            ListTile(
                              onTap: () {
                                _openGallery()
                                    .then((value) => Navigator.pop(context));
                              },
                              leading: Icon(
                                Icons.browse_gallery,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Open Gallery...',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อ-สกุล :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  enabled: false,
                  controller: memFullnameCtrl,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    prefixIcon: Icon(
                      Icons.person_3_rounded,
                    ),
                    hintText: 'ป้อนชื่อ-สกุล',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อีเมลล์ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: memEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    hintText: 'ป้อนอีเมลล์',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อผู้ใช้ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: memUsernameCtrl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_add,
                    ),
                    hintText: 'ป้อนชื่อผู้ใช้',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รหัสผ่าน :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: memPasswordCtrl,
                  obscureText: passStatus,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passStatus = !passStatus;
                        });
                      },
                      icon: passStatus
                          ? Icon(
                              Icons.visibility_off,
                            )
                          : Icon(
                              Icons.visibility,
                            ),
                    ),
                    hintText: 'ป้อนรหัสผ่าน',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อายุ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: memAgeCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ป้อนอายุ',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (memUsernameCtrl.text.isEmpty ||
                        memEmailCtrl.text.isEmpty ||
                        memPasswordCtrl.text.isEmpty ||
                        memAgeCtrl.text.isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนข้อมูลให้ครบถ้วน');
                    } else if( _imageSelected == null) {
                      //ไม่ได้แก้ไขภาพ
                      //ส่งข้อมูลไปเก็บลงฐานข้อมูล
                      Member member = Member(
                        memId: widget.member!.memId!,
                        memEmail: memEmailCtrl.text.trim(),
                        memUsername: memUsernameCtrl.text.trim(),
                        memPassword: memPasswordCtrl.text.trim(),
                        memAge: memAgeCtrl.text.trim(),
                      );
                      //เรียกใช้ API
                      CallAPI.callUpdateMemberAPI(member).then((value) {
                        if (value.message == '1') {
                          showCompleteDialog(context, 'บันทึกการแก้ไขสำเร็จ!!')
                              .then((value) {
                            Navigator.pop(context, member);
                          });
                        } else {
                          showWaringDialog(context,
                              'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                        }
                      });
                    } else if(_imageSelected != null) {
                      //กรณีแก้ไขภาพ
                      //ส่งข้อมูลไปเก็บลงฐานข้อมูล
                      Member member = Member(
                        memId: widget.member!.memId!,
                        memEmail: memEmailCtrl.text.trim(),
                        memUsername: memUsernameCtrl.text.trim(),
                        memPassword: memPasswordCtrl.text.trim(),
                        memAge: memAgeCtrl.text.trim(),
                        memImage: _image64Selected,
                      );
                      //เรียกใช้ API
                      CallAPI.callUpdateMemberAPI(member).then((value) {
                        if (value.message == '1') {
                          showCompleteDialog(context, 'บันทึกการแก้ไขสำเร็จ!!')
                              .then((value) {
                            Navigator.pop(context, member);
                          });
                        } else {
                          showWaringDialog(context,
                              'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                        }
                      });
                    }
                  },
                  child: Text(
                    'บันทึกการแก้ไข',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
