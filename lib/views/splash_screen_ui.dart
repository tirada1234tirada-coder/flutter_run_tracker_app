// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/show_all_run_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // delay หน้าจอ 3 วิ แล้วเปิดไปหน้ิา ShowAllRunUI() แบบย้อนกลับไม่ได้
    Future.delayed(
      // เวลาดีเลย์
      Duration(
        seconds: 3,
      ),
      //เมื่อครบเวลา เปิดไปหน้ิา ShowAllRunUI() แบบย้อนกลับไม่ได้
      (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShowAllRunUi(),
          ),
        );
      }
    );
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 1, 80),
      body: Stack(
        children: [
          // ชั้นที่ 1 แสดง Logo ชื่อแอป โปรเกรส ....
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Run Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.038,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
 
          // ชั้นที่ 2 แสดงข้อความด้านล่าง copyright ...
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Copyright © 2026 RUN TRACKER',
                  style: TextStyle(
                    color: const Color.fromARGB(158, 153, 152, 152),
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
                Text(
                  'Created by NinniN SAU TEAM',
                  style: TextStyle(
                    color: const Color.fromARGB(158, 153, 152, 152),
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}