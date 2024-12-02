import 'package:blood_donation/app/public/choose_screen/view/choose_screen.dart';
import 'package:blood_donation/app/settings_screen/view/settings_screen.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_auth/user_login/view/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserMainProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(
                      "https://via.placeholder.com/150", // Replace with the user's image URL
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Areen",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white.withOpacity(0.8)),
                            SizedBox(width: 4),
                            Text(
                              "Zarqa, Jordan",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "0789867482",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatCard(
                      label: "Age",
                      value: "3",
                      icon: Icons.calendar_today,
                    ),
                    StatCard(
                      label: "Weight",
                      value: "60kg",
                      icon: Icons.line_weight_rounded,
                    ),
                    StatCard(
                      label: "Height",
                      value: "170cm",
                      icon: Icons.accessibility_new,
                    ),
                    StatCard(
                      label: "Blood Type",
                      value: "B+",
                      icon: Icons.bloodtype_rounded,
                    ),
                  ],
                ),
              ),
            ),

            // Donation Availability Toggle
            ListTile(
              leading: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                "I am available to donate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            // Donation Date Section
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(
                "Donation Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text("Mar 11 (2 days left)"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            ),

            Divider(),

            // Options
            OptionTile(
              icon: Icons.edit,
              title: "Edit Profile",
            ),
            OptionTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            OptionTile(
              icon: Icons.card_giftcard,
              title: "Rewards",
            ),
            OptionTile(
                icon: Icons.logout,
                title: "Logout",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.1),
                              child: Center(
                                child: Icon(Icons.logout,
                                    size: 55,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Are you sure to log out of your account?"
                                  .tr(context),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .surface),
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  onPressed: () {
                                    Supabase.instance.client.auth
                                        .signOut()
                                        .then((onValue) {});
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (builder) {
                                      return UserLoginScreen();
                                    }), (route) => false);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Logout".tr(context))),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel".tr(context))),
                            ),
                          ]),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 36),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
        ),
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const OptionTile(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
    );
  }
}
