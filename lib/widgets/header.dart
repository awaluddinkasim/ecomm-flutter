import 'package:badges/badges.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/screens/cart.dart';
import 'package:ecomm/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatefulWidget {
  final String? search;
  const AppHeader({Key? key, this.search}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      expandedHeight: 120,
      floating: true,
      flexibleSpace: SizedBox(
        height: 160,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text("Ecommerce"),
                    ),
                    IconButton(
                      icon: Badge(
                        showBadge: Provider.of<CartState>(context).count > 0 ? true : false,
                        badgeContent: Text(
                          '${Provider.of<CartState>(context).count}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Icon(Icons.shopping_cart),
                      ),
                      onPressed: () {
                        pushNewScreen(context, screen: const CartScreen(), withNavBar: false);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: keyword,
                  onEditingComplete: () {
                    if (keyword.text != "") {
                      pushNewScreen(
                        context,
                        screen: SearchScreen(text: keyword.text),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    hintText: "Pencarian...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (keyword.text != "") {
                          pushNewScreen(
                            context,
                            screen: SearchScreen(text: keyword.text),
                          );
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
