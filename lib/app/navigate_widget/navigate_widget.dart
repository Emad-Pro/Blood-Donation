import 'package:blood_donation/app/public/choose_screen/view/choose_screen.dart';
import 'package:blood_donation/hospital_layout/hospital_main/view/hospital_main_screen.dart';
import 'package:blood_donation/user_layout/user_main/view/user_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NavigateWidget extends StatefulWidget {
  const NavigateWidget({Key? key}) : super(key: key);

  @override
  _NavigateWidgetState createState() => _NavigateWidgetState();
}

class _NavigateWidgetState extends State<NavigateWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_rounded,
                        size: 100,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "لا يوجد اتصال بالإنترنت",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "تأكد من اتصالك بالإنترنت وحاول مرة أخرى.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await Supabase.instance.client.auth.getUser();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("إعادة المحاولة"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor:
                              Theme.of(context).colorScheme.surface,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final session = snapshot.data?.session;
          if (session == null) {
            print(session);
            return const ChooseScreen();
          }

          final user = session.user;
          final identityData = user.identities?.first.identityData;

          if (identityData != null || identityData!['roule'] != null) {
            final roule = identityData['roule'];
            if (roule == 'hospital' && roule != null) {
              return const HospitalMainScreen();
            } else if (roule == 'user' && roule != null) {
              return const UserMainScreen();
            } else {
              return const ChooseScreen();
            }
          }

          return const ChooseScreen(); // Fallback for unrecognized roles.
        },
      ),
    );
  }
}
