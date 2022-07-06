import 'package:ecomm/models/user.dart';
import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/screens/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Auth>(context).user!;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.chevron_left_rounded,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 70),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          height: 80,
                          width: 80,
                          image: NetworkImage('https://ecomm.my.id/img/u/${Provider.of<Auth>(context).user!.pict}'),
                        ),
                      ),
                    ),
                    const Text(
                      "Nama",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${user.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.badge,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${user.email}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      "No. HP",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "+62${user.phone}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: ElevatedButton(
                onPressed: () {
                  pushNewScreen(context, screen: const ProfileEditScreen());
                },
                child: const Text("Edit Profil"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
