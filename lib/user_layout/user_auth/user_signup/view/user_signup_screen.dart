import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/global_sub_title_text_widget.dart';
import 'package:blood_donation/core/widget/global_title_text_widget.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';

class UserSignupScreen extends StatelessWidget {
  const UserSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Signup',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalTitleTextWidget(title: "Create Account"),
              SizedBox(
                height: 8,
              ),
              GlobalSubTitleTextWidget(
                  subTitle:
                      "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!"),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                lableText: "Full Name",
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                lableText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                lableText: "Phone Number",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                keyboardType: TextInputType.visiblePassword,
                lableText: "Password",
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                keyboardType: TextInputType.visiblePassword,
                lableText: "Confirm Password",
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                keyboardType: TextInputType.text,
                lableText: "Current Location",
                readOnly: true,
                iconButton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.location_on)),
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                keyboardType: TextInputType.text,
                lableText: "Gender",
              ),
              SizedBox(
                height: 8,
              ),
              GlobalTextFormFiled(
                keyboardType: TextInputType.text,
                lableText: "Date of last blood donation",
                readOnly: true,
                onTap: () {
                  DateTime currentDate = DateTime.now();
                  DateTime threeMonthsAgo = DateTime(
                      currentDate.year, currentDate.month - 3, currentDate.day);

                  showDatePicker(
                      context: context,
                      firstDate: DateTime(1970),
                      initialDate: threeMonthsAgo,
                      lastDate: DateTime.now());
                },
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Text(
                        "Are there any chronic diseases or contraindications to donation (prohibited diseases can be clarified, such as infectious or chronic diseases that prevent donation)"),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GlobalButton(text: "Sign Up", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
