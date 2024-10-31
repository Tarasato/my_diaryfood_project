// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class InsertDiaryfoodUI extends StatefulWidget {
  const InsertDiaryfoodUI({super.key});

  @override
  State<InsertDiaryfoodUI> createState() => _InsertDiaryfoodUIState();
}

class _InsertDiaryfoodUIState extends State<InsertDiaryfoodUI> {
  //ตัวแปรสําหรับเก็บค่าที่กรอกในฟอร์ม
  TextEditingController foodShopnameCtrl = TextEditingController(text: '');
  TextEditingController foodPayCtrl = TextEditingController(text: '');
  TextEditingController foodDateCtrl = TextEditingController(text: '');
  // สร้างตัวแปร image ให้เก็บไฟล์ภาพที่ถ่ายจากกล้อง/เลือกจากแกลลอรี่
  File? _imageSelected;

  String? _image64Selected;

  int? meal = 1;

  String? _foodDateSelected;

  //ตัวแปรเก็บจังหวัดที่เลือก
  String? _foodprovinceSelected;

  //ประกาศ/สร้างตัวแปรเพื่อเก็บข้อมูลรายการที่จะเอาไปใช้กับ DropdownButton
  List<DropdownMenuItem<String>> provinceItems = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี'
  ]
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Center(
              child: Text(
                e,
                textAlign: TextAlign.center,
              ),
            ),
          ))
      .toList();

//ตัวแปรเก็บตําแหน่งที่ Latitude, Longitude
  String? _foodLat, _foodLng;

//ตัวแปรเก็บตําแหน่งที่ Latitude, Longitude
  Position? currentPosition;
//method ดึงตําแหน่งปัจจุบัน
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      currentPosition = position;
      _foodLat = position.latitude.toString();
      _foodLng = position.longitude.toString();
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
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

  //เปิดปฏิทินเลือกวันที่
  Future<void> _showCalendar() async {
    final DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1),
      lastDate: DateTime(2100),
    );
    //นำค่าวันที่ที่เลือกมาแสดงใน TextField
    if (_picker != null) {
      setState(() {
        _foodDateSelected = _picker.toString().substring(0, 10); //2024-01-31
        foodDateCtrl.text = convertToThaiDate(_picker); //31 มกราคม 2567
      });
    }
  }

  //เมธอดแปลงวันที่แบบสากล (ปี ค.ศ.-เดือน ตัวเลข-วัน ตัวเลข) ให้เป็นวันที่แบบไทย (วัน เดือน ปี)
  //                             2023-11-25
  convertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }

    return day + ' ' + month + ' ' + year;
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'เพิ่มบันทึกการกิน',
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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
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
                          image: _imageSelected == null
                              ? AssetImage(
                                  'assets/images/banner.jpg',
                                )
                              : FileImage(_imageSelected!),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ร้านอาหาร',
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
                    controller: foodShopnameCtrl,
                    decoration: InputDecoration(
                      hintText: 'ป้อนชื่อร้านอาหาร',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
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
                      'ค่าใช้จ่าย',
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
                    controller: foodPayCtrl,
                    decoration: InputDecoration(
                      hintText: 'ป้อนค่าใช้จ่าย',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
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
                      'อาหารมื้อ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      onChanged: (int? value) {
                        setState(() {
                          meal = value;
                        });
                      },
                      value: 1,
                      groupValue: meal,
                      activeColor: Colors.green,
                    ),
                    Text(
                      'เช้า',
                    ),
                    Radio(
                      onChanged: (int? value) {
                        setState(() {
                          meal = value;
                        });
                      },
                      value: 2,
                      groupValue: meal,
                      activeColor: Colors.green,
                    ),
                    Text(
                      'กลางวัน',
                    ),
                    Radio(
                      onChanged: (int? value) {
                        setState(() {
                          meal = value;
                        });
                      },
                      value: 3,
                      groupValue: meal,
                      activeColor: Colors.green,
                    ),
                    Text(
                      'เย็น',
                    ),
                    Radio(
                      onChanged: (int? value) {
                        setState(() {
                          meal = value;
                        });
                      },
                      value: 4,
                      groupValue: meal,
                      activeColor: Colors.green,
                    ),
                    Text(
                      'ว่าง',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'วันที่กิน',
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
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: foodDateCtrl,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'เลือกวันที่',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showCalendar();
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.green,
                        ),
                      ),
                    ],
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
                      'จังหวัด',
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
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      items: provinceItems,
                      onChanged: (String? value) {
                        setState(() {
                          _foodprovinceSelected = value!;
                        });
                      },
                      value: _foodprovinceSelected,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'บันทึกการกิน',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
