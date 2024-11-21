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
        if (session == null || session.user == null) {
          return const ChooseScreen();
        }

        final user = session.user!;
        final identityData = user.identities?.first.identityData;

        if (identityData != null) {
          final role = identityData['roule'];
          if (role == 'hospital') {
            return const HospitalMainScreen();
          } else if (role == 'user') {
            return const UserMainScreen();
          }
        }

        return const ChooseScreen(); // Fallback for unrecognized roles.
      },
    );
  }
}
