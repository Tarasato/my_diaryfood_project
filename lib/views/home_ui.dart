// ignore_for_file: prefer_const_constructors, must_be_immutable, unrelated_type_equality_checks
//Test push
import 'package:flutter/material.dart';
import 'package:my_diaryfood_project/models/diaryfood.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/services/call_api.dart';
import 'package:my_diaryfood_project/utils/env.dart';
import 'package:my_diaryfood_project/views/update_profile_ui.dart';

class HomeUI extends StatefulWidget {
  Member? member;
  HomeUI({super.key, this.member});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //ตัวแปรเก็บข้อมูลการกินของที่ได้จาก API
  Future<List<Diaryfood>>? diaryfoodData;

  //method เรียกห API ที่ CallAPI
  getAllDiaryFoodByMember(Diaryfood diaryfood) {
    setState(() {
      diaryfoodData = CallAPI.callGetAllDiaryFoodByMemberAPI(diaryfood);
    });
  }

  @override
  void initState() {
    Diaryfood diaryfood = Diaryfood(
      memId: widget.member!.memId,
    );
    //เรียก method เรียก API ดึงข้อมูลบันทึกการกิน ที่ CallAPI
    getAllDiaryFoodByMember(diaryfood);
    super.initState();
  }

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
                  ).then((value) {
                    //ตรวจดูว่า value ที่ส่งกลับมาจากหน้า UpdateProfileUI มีค่าเท่ากับ null หรือไม่
                    if (value != null) {
                      //เอาค่าที่ส่งกลับมาหลังจากกดปุ่ม Update Profile มาแสดง
                      setState(() {
                        widget.member?.memEmail = value.memEmail;
                        widget.member?.memUsername = value.memUsername;
                        widget.member?.memPassword = value.memPassword;
                        widget.member?.memAge = value.memAge;
                      });
                    }
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
              Expanded(
                  child: FutureBuilder<List<Diaryfood>>(
                future: diaryfoodData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data![0].message == [0]) {
                      return Text('ไม่มีข้อมูลการกิน');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {},
                                tileColor: index % 2 == 0 ? Colors.red[50] : Colors.green[50],
                                leading: ClipRRect(
                                  child: Image.network(
                                    '${Env.hostName}/mydiaryfood/assets/images/picupload/foods/${snapshot.data![index].foodImage}',
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  snapshot.data![index].foodShopname!,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.green[800],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ))
            ],
          ),
        ));
  }
}
