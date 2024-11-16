import 'package:flutter/material.dart';

import '../../../../settings/view/settigns_screen.dart';

class HospitalProfileScreen extends StatelessWidget {
  const HospitalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 35),
              CircleAvatar(
                radius: 50,
                backgroundColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                child: Center(
                  child: Icon(
                    Icons.local_hospital,
                    size: 55,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              Text("Hospital Name",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold)),
              Container(
                width: 300,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.7),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.5,
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Edit Profile"),
                    leading: CircleAvatar(child: Icon(Icons.edit)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Notifications"),
                    leading: CircleAvatar(child: Icon(Icons.notifications)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Appointmnet"),
                    leading: CircleAvatar(child: Icon(Icons.timeline)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Reviews"),
                    leading: CircleAvatar(child: Icon(Icons.comment_sharp)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Settings"),
                    leading: CircleAvatar(child: Icon(Icons.settings)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettignsScreen()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("FAQs"),
                    leading: CircleAvatar(child: Icon(Icons.feed)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Logout"),
                    leading: CircleAvatar(child: Icon(Icons.logout)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
