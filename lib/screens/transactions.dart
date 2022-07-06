import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/transactions.dart';
import 'package:ecomm/screens/transaction_detail.dart';
import 'package:ecomm/widgets/empty_orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Future<void> _refresh() async {
    return Future.delayed(const Duration(seconds: 1), () {
      Provider.of<TransactionState>(
        context,
        listen: false,
      ).getTransactions(
        token: "${Provider.of<Auth>(
          context,
          listen: false,
        ).token}",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TransactionState>(
        context,
        listen: false,
      ).getTransactions(
        token: "${Provider.of<Auth>(
          context,
          listen: false,
        ).token}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List items = Provider.of<TransactionState>(
      context,
    ).orderan;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: !Provider.of<TransactionState>(
            context,
            listen: false,
          ).loading
              ? Provider.of<TransactionState>(
                  context,
                  listen: false,
                ).orderan.isEmpty
                  ? const EmptyOrders()
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return OrderanItem(item: items[index]);
                      },
                      itemCount: items.length,
                    )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
        ),
      ),
    );
  }
}

class OrderanItem extends StatelessWidget {
  const OrderanItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item['status'] == 'Pending' ? 'Menunggu Pembayaran / Verifikasi' : item['status']}",
                  style: TextStyle(
                    color: item['status'] == "Selesai"
                        ? Colors.green
                        : (item['status'] == "Batal" ? Colors.red : Colors.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${item['tanggal']}"),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Text(
              "${item['kode']}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, overflow: TextOverflow.ellipsis),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Belanja"),
                    Text(
                      'Rp. ${formatter.format(int.parse(item["total_harga"]))}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('${item["item"].length} produk'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: TransactionDetail(data: item),
                    );
                  },
                  child: const Text("Detail"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
