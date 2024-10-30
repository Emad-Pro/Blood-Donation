import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/global_sub_title_text_widget.dart';
import 'package:blood_donation/core/widget/global_title_text_widget.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';

class UserForgotPasswordScreen extends StatelessWidget {
  const UserForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Password recovery".tr(context)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GlobalTitleTextWidget(title: 'Forgot Password'.tr(context)),
            SizedBox(
              height: 15,
            ),
            GlobalSubTitleTextWidget(
              subTitle:
                  'In our app, we take the security of your information seriously.'
                      .tr(context),
            ),
            SizedBox(
              height: 30,
            ),
            GlobalTextFormFiled(
              lableText: 'Email or Phone Number'.tr(context),
              keyboardType: TextInputType.emailAddress,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: GlobalButton(text: 'Reset Password'.tr(context), onTap: () {}),
      ),
    );
  }
}
