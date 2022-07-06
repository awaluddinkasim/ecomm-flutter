import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/cart.svg',
            width: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Keranjang kosong",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
