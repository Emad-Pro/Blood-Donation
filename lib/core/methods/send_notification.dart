import 'package:dio/dio.dart';

Future<String> sendNotification(
    {required String contents,
    required String headings,
    String? bigPicture,
    List<String>? recivedIds,
    String? contentAr,
    String? headingAr}) async {
  final dio = Dio();

  // إعدادات الإشعار
  final notificationData = {
    "app_id": "cb0266c5-a7c7-458d-ac6f-5fef6ba42e43",
    "include_external_user_ids": recivedIds,
    "contents": {"en": contents, "ar": contentAr},
    "headings": {"en": headings, "ar": headingAr},
    "big_picture": "https://www.shutterstock.com/image-photo/example-image.jpg"
  };

  try {
    // إرسال الطلب
    final response = await dio.post(
      'https://onesignal.com/api/v1/notifications',
      data: notificationData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic os_v2_app_zmbgnrnhy5cy3ldpl7xwxjboinscv5rfrj6uydfhlkrkr2nhyl6tqrvmizkzehxtlxxezrw764jpx2mps6y2whe7afszvqv2xi7ii7q', // أضف مفتاح API الخاص بـ OneSignal
        },
      ),
    );

    // التحقق من نجاح الطلب
    if (response.statusCode == 200) {
      return "Notification sent successfully";
    } else {
      return "Failed to send notification";
    }
  } catch (e) {
    return "Error while sending notification";
  }
}
