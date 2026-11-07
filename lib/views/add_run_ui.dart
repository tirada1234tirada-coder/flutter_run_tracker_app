import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:image_picker/image_picker.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  //------ส่วนของโค้ดที่เกี่ยวข้องกับการเปิดกล้อง
  Uint8List? imageBytes;
  XFile? imageFile;
  //เปิดกล้อง
  Future<void> selectImageFormCamera() async {
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);

    //ตรวจสอบว่าได้ถ่ายไหม
    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  //เปิดแกลลอรี่
  Future<void> selectImageFormGallery() async {
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    //ตรวจสอบว่าได้ถ่ายไหม
    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  //ส่วนของโค้ดที่เกี่ยวข้องกับการ upload และ save ข้อมูล
  //ตัวแปรสำหรับเก็บตำแหน่งไฟล์ที่อัปโหลดไป
  String imageURL = "";

  //สร้างตัวควบคุม Textfield
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runPersonCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  Future<void> uploadAndSaveData() async {
    //upload file แต่ต้องตรวจสอบก่อนว่ามีไฟล์ที่จะอัปโหลดไหม
    if (imageFile != null) {
      imageURL = await SupabaseService().uploadImageFile(imageFile!);
    }
    //save ข้อมูลลง table
    //validate ข้อมูลก่อนว้าผู้ใช้กรอกข้อมูลครบหรือไม่
    if (runWhereCtrl.text.isNotEmpty ||
        runPersonCtrl.text.isNotEmpty ||
        runDistanceCtrl.text.isNotEmpty) {
      //อันไหนว่างแสดงเตือนการใช้ snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "กรุณากรอกข้อมูลให้ครบ",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    //ผ่าน vaildate มาก็ได้ก็แพ็คขข้อมูลเพื่อส่งไปบันทึกลง table
    Run runData = Run(
      runWhere : runWhereCtrl.text,
      runPerson : runPersonCtrl.text,
      runDistance : int.parse(runDistanceCtrl.text),
      runImageUrl : imageURL,
    );
    //ส่งข้อมูลที่เเพ็คไปบันทึกลง table
    await SupabaseService().insertRun(runData);

    //หลังจากบันทึกเสร็จแสดงข้อความแจ้ง
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "อัปโหลดและบันทึกข้อมูลเรียบร้อยเเล้ว",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      //แล้วย้อนกลับไปหน้า ShowAllRun()
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ appBar
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 1, 80),
        title: Text(
          'Run Tracker (เพิ่ม)',
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
      // ส่วนของ body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: 50,
            bottom: 50,
            left: 45,
            right: 45,
          ),
          child: Center(
            child: Column(
              children: [
                //ใช้ ternary operator => _______?_________ : __________
                imageBytes == null
                    ? InkWell(
                        onTap: () {
                          //เรียกเปิดใช้งานเมธอดเปิดกล้องหรือแกลอรี่
                          selectImageFormCamera();
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: MediaQuery.of(context).size.width * 0.50,
                          color: Colors.grey,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          //เรียกเปิดใช้งานเมธอดเปิดกล้องหรือแกลอรี่
                          selectImageFormCamera();
                        },
                        child: Image.memory(
                          imageBytes!,
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.50,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งที่ไหน',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runWhereCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น สวนหลวง, .....',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งกับใคร',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runPersonCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น เพื่อน, .....',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง (กิโลเมตร)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: runDistanceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น 5, 10, .....',
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),

                //ทำปุ่มกดบันทึกและลบข้อมูล
                ElevatedButton(
                  onPressed: () {
                    //อัปโหลดรูปไปยัง bucket และบันทึกข้อมูลลง table
                    //แต่โค้ดมันยาว ขอไปทำเป็นชื่อมธอดชื่อ uploadAndSaveData() ไว้ด้านบนแล้วเรียกใช้
                    uploadAndSaveData();
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(350.0, 65.0),
                    backgroundColor: Color.fromARGB(255, 28, 143, 29),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(350.0, 65.0),
                    backgroundColor: Color.fromARGB(255, 233, 72, 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
