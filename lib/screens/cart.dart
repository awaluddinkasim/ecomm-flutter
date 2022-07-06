import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/screens/checkout.dart';
import 'package:ecomm/widgets/cart_item.dart';
import 'package:ecomm/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatter = NumberFormat.decimalPattern();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CartState>(context, listen: false).fetchItem("${Provider.of<Auth>(context, listen: false).token}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: Column(
        children: [
          if (Provider.of<CartState>(context, listen: false).loading)
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 50,
                    child: LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin,
                      strokeWidth: 5,
                    ),
                  ),
                ],
              ),
            )
          else
            (Provider.of<CartState>(context, listen: false).items.isEmpty)
                ? const EmptyCart()
                : Flexible(
                    child: ListView.builder(
                      itemCount: Provider.of<CartState>(context).items.length,
                      itemBuilder: (context, int index) {
                        return CartItem(
                          item: Provider.of<CartState>(context).items[index],
                        );
                      },
                    ),
                  ),
          _checkoutSection(),
        ],
      ),
    );
  }

  Widget _checkoutSection() {
    int cc = Provider.of<CartState>(context, listen: false).count;
    return Material(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const Text(
                    "Total checkout:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Text(
                    "Rp. ${formatter.format(Provider.of<CartState>(context).total)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: cc > 0 ? Colors.red : Colors.black26,
              elevation: 1.0,
              child: InkWell(
                onTap: () {
                  if (cc > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const CheckoutScreen();
                      }),
                    );
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
