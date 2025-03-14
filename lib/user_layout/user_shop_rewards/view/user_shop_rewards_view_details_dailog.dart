import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../core/auto_direction.dart';
import '../../../hospital_layout/hospital_medicine_rewards/model/hospital_medicine_rewards_model.dart';

Future<dynamic> userShopRewardsViewDetailsDailog(
    BuildContext context, HospitalMedicineRewardsModel model) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel".tr(context)))
            ],
            title: AutoDirection(text: model.name!, child: Text(model.name!)),
            content: AutoDirection(
                text: model.description!, child: Text(model.description!)),
          ));
}
