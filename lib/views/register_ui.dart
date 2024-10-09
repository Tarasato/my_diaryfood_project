// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/services/call_api.dart';
import 'package:my_diaryfood_project/views/home_ui.dart';
import 'package:my_diaryfood_project/views/login_ui.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'ลงทะเบียน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2024/09/23/05/54/wave-9067749_640.jpg',
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
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
                  controller: memFullnameCtrl,
                  decoration: InputDecoration(
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
                        memAgeCtrl.text.isEmpty ||
                        memFullnameCtrl.text.isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนข้อมูลให้ครบถ้วน');
                    } else {
                      //ส่งข้อมูลไปเก็บลงฐานข้อมูล
                      Member member = Member(
                        memFullname: memFullnameCtrl.text.trim(),
                        memEmail: memEmailCtrl.text.trim(),
                        memUsername: memUsernameCtrl.text.trim(),
                        memPassword: memPasswordCtrl.text.trim(),
                        memAge: memAgeCtrl.text.trim(),
                      );
                      //เรียกใช้ API
                      CallAPI.callRegisterAPI(member).then((value) {
                        if (value.message == '1') {
                           showCompleteDialog(context, 'ลงทะเบียนสำเร็จ!!').then((value){
                             Navigator.pop(context);
                           });
                          } else {
                            showWaringDialog(
                                context, 'ลงทะเบียนไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                          }
                      });
                    }
                  },
                  child: Text(
                    'บันทึกการลงทะเบียน',
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
