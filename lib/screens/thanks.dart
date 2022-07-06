import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/providers/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Provider.of<CartState>(context).count == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/thanks.svg',
                      width: 200,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Terima kasih",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const Text("Pesanan Anda telah terkirim"),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<TransactionState>(
                          context,
                          listen: false,
                        ).getTransactions(
                          token: "${Provider.of<Auth>(
                            context,
                            listen: false,
                          ).token}",
                        );
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text("Kembali"),
                    ),
                  ],
                )
              : Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 150, horizontal: 150),
                      child: SizedBox(
                        child: LoadingIndicator(
                          indicatorType: Indicator.circleStrokeSpin,
                        ),
                      ),
                    ),
                    Text("Sedang mengirim pesanan...")
                  ],
                ),
        ),
      ),
    );
  }
}
