import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Column(
          children: [
            SvgPicture.asset(
              'assets/empty.svg',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Tidak ada produk ditemukan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        )
      ],
    );
  }
}
