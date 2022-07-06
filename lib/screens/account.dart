import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/screens/cart.dart';
import 'package:ecomm/screens/logout.dart';
import 'package:ecomm/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 400,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          height: 60,
                          width: 60,
                          image: NetworkImage('https://ecomm.my.id/img/u/${Provider.of<Auth>(context).user!.pict}'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${Provider.of<Auth>(context).user!.name}",
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profil saya"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    pushNewScreen(context, screen: const ProfileScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.cart_fill),
                  title: const Text("Keranjang saya"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    pushNewScreen(context, screen: const CartScreen(), withNavBar: false);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Logout"),
                  onTap: () {
                    logout();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void logout() {
    Provider.of<Auth>(context, listen: false).logout();
    pushNewScreen(
      context,
      screen: const LogoutScreen(),
      withNavBar: false,
    );
  }
}
