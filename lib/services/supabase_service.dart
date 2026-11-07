//ไฟล์นี้จะประกอบด้วยโค้ดคำสั่งที่จะทำงานกับ supabase 
//เช่น อัปไฟล์ เพิ่ม ลบ แก้ไข ค้นหา/ตรวจสอบ/ดึง/ดู ข้อมูลในตาราง
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class SupabaseService {
  //*** สิ่งสำคัญจะต้องสร้างตัวแทน  ที่จะทำงานกับ supabase ***//
  final supabase = Supabase.instance.client;

  //ต่อจากนี้จะเป็นส่วนของเมธอดการทำงาานต่างๆกับsupabase
  //เมธอดอัปดหลดไฟล์ไปยัง bucket ที่อยู่ใน storage ของ supabase
  Future<String> uploadImageFile(XFile xfile) async{
    //ตั้งชื่อไฟล์เพื่อไม่ให้ซั้ากันเวลาอยู่ใน bucket
    final newFlieNAme = '${DateTime.now().millisecondsSinceEpoch}_&{xflie.name}';
    //upload ไฟล์
    await supabase.storage.from('run_bk').uploadBinary(
      newFlieNAme,
      await xfile.readAsBytes(),
      fileOptions: FileOptions(contentType: xfile.mimeType),
      );
    //คือค่าที่อยู่ในไฟล์ที่อัปโหลดเข้าไปใน bucket เพื่อเอาไปบันทึกลง table
    return supabase.storage.from('run_bk').getPublicUrl(newFlieNAme);
  }
  //เมธอดเพิ่มข้อมูลไปยัง table ที่อยู่ใน database Supabase
    Future<void> insertRun(Run run) async{
      await supabase.from('run_tb').insert(run.toJson());
    }
}