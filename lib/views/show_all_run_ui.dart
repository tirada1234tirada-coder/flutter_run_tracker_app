// ignore_for_file: unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ appBar
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 1, 80),
        title: Text(
          'Run Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      // ส่วนของ floatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // เปิดไป AddRunUI() แบบย้อนกลับได้
          Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (context) => AddRunUi(),
              builder: (context) => UpdateDeleteRunUi(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 5, 1, 80),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // ส่วนของ body
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.355,
              height: MediaQuery.of(context).size.width * 0.355,
              fit: BoxFit.cover,
            ),
            Text(
              'วิงกันเถอะ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.0325,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}