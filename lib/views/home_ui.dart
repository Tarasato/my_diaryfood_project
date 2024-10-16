// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/views/update_profile_ui.dart';

class HomeUI extends StatefulWidget {
  Member? member;
  HomeUI({super.key, this.member});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'บันทึกการกิน',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Text(
                'ชื่อ-สกุล: ${widget.member!.memFullname!}',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Text(
                'อีเมล: ${widget.member!.memEmail!}',
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateProfileUI(member: widget.member),
                    ),
                  ).then((value){
                    //เอาค่าที่ส่งกลับมาหลังจากกดปุ่ม Update Profile มาแสดง
                    setState(() {
                      widget.member?.memEmail = value.memEmail;
                      widget.member?.memUsername = value.memUsername;
                      widget.member?.memPassword = value.memPassword;
                      widget.member?.memAge = value.memAge;
                    });
                  });
                },
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
