class Run {
  //ตัวแปรล้อกับคอลัมในตาราง
  String? id;
  String? create_at;
  String? runWhere;
  String? runPerson;
  int? runDistance;
  String? runImageUrl;

  //Construct
  Run({
    this.id,
    this.create_at,
    this.runWhere,
    this.runPerson,
    this.runDistance,
    this.runImageUrl,
  });

  //การแปลงข้อมูลฝั่ง mobile เป็น JSON เพื่อส่งไปยัง Supabase : toJson
  Map<String,dynamic> toJson() => {
    "id": id,
    "created_at": create_at,
    "runWhere": runWhere,
    "runPerson": runPerson,
    "runDistance": runDistance,
    "runImageUrl": runImageUrl,
  };
 
  //การแปลงข้อมูลฝั่ง Supabase มาใช้ในฝั่ง mobile : fromJson
  factory Run.fromJson(Map<String,dynamic> json) => Run(
    id: json["id"] as String?,
    create_at: json["created_at"] as String?,
    runWhere: json["runWhere"] as String?,
    runPerson: json["runPerson"] as String?,
    runDistance: json["runDistance"] as int?,
    runImageUrl: json["runImageUrl"] as String?,
  );

}