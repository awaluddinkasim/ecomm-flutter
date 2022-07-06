import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/favorites.dart';
import 'package:ecomm/screens/product_details.dart';
import 'package:ecomm/widgets/empty_favs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> _refresh() async {
    return Future.delayed(const Duration(seconds: 1), () {
      Provider.of<FavoriteState>(
        context,
        listen: false,
      ).getFavorites(
        token: "${Provider.of<Auth>(
          context,
          listen: false,
        ).token}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List items = Provider.of<FavoriteState>(
      context,
    ).favorites;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: !Provider.of<FavoriteState>(
            context,
            listen: false,
          ).loading
              ? items.isEmpty
                  ? const EmptyFavorites()
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: const Text(
                                  "Produk favorit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              FavoriteItem(item: items[index]),
                            ],
                          );
                        }
                        return FavoriteItem(item: items[index]);
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

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern();
    return Card(
      child: Material(
        child: InkWell(
          onTap: () {
            pushNewScreen(context, screen: ProductDetailScreen(data: item['product']));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage("https://ecomm.my.id/img/p/${item['product']['img']}"),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['product']['nama_produk']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Rp. ${formatter.format(int.parse(item['product']['harga']))}"),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
