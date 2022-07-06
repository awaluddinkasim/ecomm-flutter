import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/providers/settings.dart';
import 'package:ecomm/screens/thanks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Order"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final formatter = NumberFormat.decimalPattern();

    TextEditingController address = TextEditingController();
    TextEditingController phone = TextEditingController();
    num total = Provider.of<CartState>(context, listen: false).total;
    num delivery = Provider.of<Settings>(context).ongkir;

    phone.text = "${Provider.of<Auth>(context).user!.phone}";

    checkout() {
      Map data = {
        "alamat_kirim": address.text,
        "no_hp": phone.text,
        "total_harga": total + delivery,
      };

      Provider.of<CartState>(context, listen: false).checkout(
        token: "${Provider.of<Auth>(context, listen: false).token}",
        data: data,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ThankYouScreen(),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal"),
                Text("Rp. ${formatter.format(total)}"),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ongkos Kirim"),
                Text("Rp. ${formatter.format(delivery)}"),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total"),
                Text("Rp. ${formatter.format(total + delivery)}"),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                "Alamat Pengiriman".toUpperCase(),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Form wajib diisi";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.multiline,
                    controller: address,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Alamat Lengkap",
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                "Nomor Kontak".toUpperCase(),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Form wajib diisi";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: const InputDecoration(
                      prefix: Text("+62"),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                "Detail Pembayaran".toUpperCase(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Silahkan transfer pembayaran ke rekening"),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Bank ${Provider.of<Settings>(context, listen: false).bank}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${Provider.of<Settings>(context, listen: false).norek}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text("an ${Provider.of<Settings>(context, listen: false).pemilik}"),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkout();
                  }
                },
                child: const Text(
                  "Confirm Order",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
