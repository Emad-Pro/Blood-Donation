import 'package:flutter/material.dart';

import '../../view_model/user_profile_cubit.dart';

class UserProfileHeaderWidgets extends StatelessWidget {
  const UserProfileHeaderWidgets({super.key, required this.state});
  final UserProfileState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(
              state.userSignupModel!
                  .profileImage!, // Replace with the user's image URL
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${state.userSignupModel!.fullName}",
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
                    Expanded(
                      child: Text(
                        state.userSignupModel!.currentLocation!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, color: Colors.white.withOpacity(0.8)),
                      ),
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
                      state.userSignupModel!.phone!,
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
