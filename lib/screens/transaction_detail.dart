import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/settings.dart';
import 'package:ecomm/providers/transactions.dart';
import 'package:ecomm/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    int total = data['item'].fold(0, (p, c) => p + int.parse(c['product']['harga']));
    final formatter = NumberFormat.decimalPattern();

    void back() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Detail transaksi")),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data['status'] == 'Pending' ? 'Menunggu Pembayaran / Verifikasi' : data['status']}",
                      style: TextStyle(
                        color: data['status'] == "Selesai"
                            ? Colors.green
                            : (data['status'] == "Batal" ? Colors.red : Colors.black),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "${data['kode']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${data['tanggal']}"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rincian produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    for (var i in data['item'])
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: ProductDetailScreen(data: i['product']),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage("https://ecomm.my.id/img/p/${i['product']['img']}"),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${i['product']['nama_produk']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("Rp. ${formatter.format(int.parse(i['product']['harga']))} x ${i['qty']}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rincian pembayaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total harga"),
                        Text("Rp. ${formatter.format(total)}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ongkos kirim"),
                        Text("Rp. ${formatter.format(int.parse(data['total_harga']) - total)}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total pembayaran"),
                        Text("Rp. ${formatter.format(int.parse(data['total_harga']))}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (data['status'] == "Pending")
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 50,
                                  horizontal: 40,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Apakah Ada ingin membatalkan pesanan ini?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Tidak"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Provider.of<TransactionState>(context, listen: false).cancelTransaction(
                                              token: "${Provider.of<Auth>(context, listen: false).token}",
                                              data: data,
                                            );
                                            Navigator.pop(context);
                                            back();
                                          },
                                          child: const Text("Iya"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text("Batalkan pesanan"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            else
              const SizedBox(
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
