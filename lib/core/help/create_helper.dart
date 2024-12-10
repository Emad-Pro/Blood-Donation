import 'dart:io';

void main() {
  // قائمة بأسماء الكلاسات
  List<String> classNames = [
    "UserEditProfileUpdateButton",
    "UserEditProfileDiseasesButtonWidget",
    "UserEditProfileLastDateBloodDonationWidget",
    "UserEditProfileSelecetBloodType",
    "UserEditProfileWeightHeightAgeAndSelectGenderWidget",
    "UserEditProfilePhoneNumberWidgets",
    "UserEditProfileLocationWidgets",
    "UserEditProfileImageNameEmailWidgets",
  ];

  // مسار إنشاء الملفات
  String outputPath = '../../user_layout/user_edit_profile/view/widgets/';

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
