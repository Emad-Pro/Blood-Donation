import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/global_sub_title_text_widget.dart';
import 'package:blood_donation/core/widget/global_title_text_widget.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';

class HospitalSignupScreen extends StatefulWidget {
  @override
  _HospitalSignupScreenState createState() => _HospitalSignupScreenState();
}

class _HospitalSignupScreenState extends State<HospitalSignupScreen> {
  final List<String> daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Select all', // Moved "All" to the end of the list
  ];

  List<String> selectedDays = []; // Store selected days
  TimeOfDay openingTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay closingTime = TimeOfDay(hour: 17, minute: 0);

  Future<void> _selectTime(BuildContext context, bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening ? openingTime : closingTime,
    );
    if (picked != null) {
      setState(() {
        if (isOpening) {
          openingTime = picked;
        } else {
          closingTime = picked;
        }
      });
    }
  }

  Future<void> _showDaysDialog(BuildContext context) async {
    List<String> tempSelectedDays =
        List.from(selectedDays); // Copy current selection
    bool allSelected = tempSelectedDays.contains('Select all');

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Operating Days"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...daysOfWeek.sublist(0, daysOfWeek.length - 1).map((day) {
                    return CheckboxListTile(
                      title: Text(day),
                      value: tempSelectedDays.contains(day),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelectedDays.add(day);
                          } else {
                            tempSelectedDays.remove(day);
                            allSelected =
                                false; // Uncheck "select all" if any day is deselected
                          }
                        });
                      },
                    );
                  }).toList(),
                  CheckboxListTile(
                    title: Text("Select all"),
                    value: allSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        allSelected = value ?? false;
                        if (allSelected) {
                          tempSelectedDays = List.from(daysOfWeek.sublist(
                              0,
                              daysOfWeek.length -
                                  1)); // Select all days except "All"
                        } else {
                          tempSelectedDays.clear(); // Deselect all
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedDays = tempSelectedDays; // Update the selected days
                });
                Navigator.pop(context);
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalTitleTextWidget(title: "Create Account"),
              SizedBox(height: 8),
              GlobalSubTitleTextWidget(
                  subTitle:
                      "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!"),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                lableText: "Full Name",
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                lableText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                lableText: "Phone Number",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                lableText: "Primary Contact Person",
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                keyboardType: TextInputType.visiblePassword,
                lableText: "Password",
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                keyboardType: TextInputType.visiblePassword,
                lableText: "Confirm Password",
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                keyboardType: TextInputType.text,
                lableText: "Current Location",
                readOnly: true,
                iconButton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.location_on)),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () =>
                    _showDaysDialog(context), // Show multi-select dialog
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    selectedDays.isEmpty
                        ? "Select Operating Days"
                        : selectedDays.join(', '),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text(
                        'Opening Time: ${openingTime.format(context)}',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text(
                        'Closing Time: ${closingTime.format(context)}',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              GlobalButton(
                  text: "Sign Up",
                  onTap: () {
                    // Handle sign-up logic
                    // You can access selectedDays, openingTime, and closingTime here
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
