import 'dart:io';

void main() {
  List<String> classNames = [
    "UserLoginPrivacyPolicyTextButtonWidgets",
    "UserLoginForgotPasswordRememberWidgets",
    "UserLoginEmailPasswordFormfiledWidgets",
    "UserLoginTitleSubtitleWidgets",
  ];
  String filePath = '../user_layout/user_auth/user_login/view/widgets/';
  for (String className in classNames) {
    String fileName = convertToSnakeCase(className);
    File('$filePath${fileName}.dart').createSync();
    print("تم إنشاء الملف بنجاح: $fileName.dart");
  }
}

// دالة لتحويل الأحرف الكبيرة إلى صيغة `snake_case`
String convertToSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
    String letter = match.group(0)!;
    return '_${letter.toLowerCase()}';
  }).replaceFirst('_', '');
}
