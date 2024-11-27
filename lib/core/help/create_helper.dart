import 'dart:io';

void main() {
  // قائمة بأسماء الكلاسات
  List<String> classNames = [
    "HospitalHomeResentListview",
    "HospitalHomeResentText",
    "HospitalHomeEmergencyButton",
    "HospitalHomeSlider",
    "HospitalHomeAppbar",
  ];

  // مسار إنشاء الملفات
  String outputPath =
      '../../hospital_layout/hospital_main/pages/hospital_home_screen/view/widgets/';

  // التأكد من وجود المجلد
  Directory(outputPath).createSync(recursive: true);

  // تحويل أسماء الكلاسات إلى أسماء ملفات وإنشائها
  for (var className in classNames) {
    String fileName = classNameToFileName(className);
    File file = File('$outputPath$fileName.dart');
    file.createSync();
    file.writeAsStringSync(
        '// File for class $className\n\nclass $className {}\n');
    print('File created: ${file.path}');
  }
}

String classNameToFileName(String className) {
  return className
      .replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) =>
            (match.start != 0 ? '_' : '') + match.group(0)!.toLowerCase(),
      )
      .replaceAll(RegExp(r'_{2,}'), '_');
}
