//call_api.dart
//ไฟล์นี้จะประกอบด้วย method สําหรับเรียก api
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/utils/env.dart';

class CallAPI {
  //method เรียก API ตรวจชื่อผู้ใช้รหัสผ่าน

  static Future<Member> callCheckLoginAPI(Member member) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/check_login_api.php'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );
    if (responseData.statusCode == 200) {
      return Member.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //method เรียก API บันทึกข้อมูลสมาชิกใหม่
  static Future<Member> callRegisterAPI(Member member) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mydiaryfood/apis/register_member_api.php'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );
    if (responseData.statusCode == 200) {
      return Member.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
}
