import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/user_edit_profile_cubit.dart';

Future<dynamic> showSelecetImageDialog(
    BuildContext context, UserEditProfileCubit userEditProfileCubit) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  trailing: Icon(Icons.camera),
                  title: Text("Take Photo".tr(context)),
                  onTap: () async {
                    await userEditProfileCubit.takeImage();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.image),
                  title: Text("Pick Image".tr(context)),
                  onTap: () async {
                    await userEditProfileCubit.pickImage();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.delete),
                  title: Text("Delete Image".tr(context)),
                  onTap: () {
                    userEditProfileCubit.deleteImage();
                  },
                )
              ],
            ),
          ));
}
