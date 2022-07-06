import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
        ),
        Column(
          children: [
            SvgPicture.asset(
              'assets/favorites.svg',
              width: 180,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Belum ada item favorite",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}
