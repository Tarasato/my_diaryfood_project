import 'package:flutter/material.dart';
import 'package:my_diaryfood_project/models/member.dart';

class UpDelDiaryfoodUI extends StatefulWidget {
  const UpDelDiaryfoodUI({super.key, Member? member});

  @override
  State<UpDelDiaryfoodUI> createState() => _UpDelDiaryfoodUIState();
}

class _UpDelDiaryfoodUIState extends State<UpDelDiaryfoodUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}