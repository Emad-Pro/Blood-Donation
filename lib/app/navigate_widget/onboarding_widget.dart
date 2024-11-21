import 'package:blood_donation/app/navigate_widget/navigate_widget.dart';
import 'package:flutter/material.dart';

import '../../core/shared_preferences/cache_helper.dart';
import '../public/onboarding_screen/view/onboarding_screen.dart';

class OnBoardingSkip {
  static bool skipOnBoarding = false;
  static initCheckBoarding() async {
    skipOnBoarding = await CacheHelper.getSaveData(key: "boarding") != null;
    return skipOnBoarding;
  }

  static Widget WidgetIntApp() {
    if (skipOnBoarding) {
      return const NavigateWidget();
    } else {
      return const OnboardingScreen();
    }
  }
}
