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
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
            print(roule);
            return const HospitalMainScreen();
          } else if (roule == 'user' && roule != null) {
            return const UserMainScreen();
          } else {
            return const ChooseScreen();
          }
        }

        return const ChooseScreen(); // Fallback for unrecognized roles.
      },
    );
  }
}
