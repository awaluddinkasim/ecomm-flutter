import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({Key? key}) : super(key: key);

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
              'assets/orderan.svg',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Anda belum melakukan transaksi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        )
      ],
    );
  }
}
