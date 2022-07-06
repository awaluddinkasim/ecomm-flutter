import 'package:badges/badges.dart';
import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/providers/favorites.dart';
import 'package:ecomm/screens/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map data;
  const ProductDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final formatter = NumberFormat.decimalPattern();
  bool loved = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkFav();
    });
  }

  void checkFav() {
    List favs = Provider.of<FavoriteState>(context, listen: false).favorites;

    Map filter = favs.firstWhere((e) => e['product_id'].toString() == widget.data['id'].toString());
    if (favs.isNotEmpty && filter.isNotEmpty) {
      setState(() {
        loved = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.grey,
            icon: Badge(
              showBadge: Provider.of<CartState>(context).count > 0 ? true : false,
              badgeContent: Text(
                '${Provider.of<CartState>(context).count}',
                style: const TextStyle(color: Colors.white),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              pushNewScreen(context, screen: const CartScreen(), withNavBar: false);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "${widget.data['nama_produk']}",
          style: TextStyle(color: Colors.grey.shade800),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Container(
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://ecomm.my.id/img/p/${widget.data['img']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rp. ${formatter.format(int.parse(widget.data['harga']))},-",
                    style:
                        TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Text(
                "Stok: ${widget.data['stok'] == 0 ? 'Habis' : widget.data['stok']}",
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.data['stok'] == 0 ? Colors.red : Colors.black),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kategori",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text("${widget.data['tipe_produk']}"),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<FavoriteState>(
                        context,
                        listen: false,
                      ).favoriteAction(
                        token: "${Provider.of<Auth>(
                          context,
                          listen: false,
                        ).token}",
                        data: {
                          "id": widget.data['id'],
                        },
                      );
                      setState(() {
                        loved = !loved;
                      });
                    },
                    icon: Icon(
                      loved ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      color: loved ? Colors.red.shade400 : Colors.black54,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Deskripsi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.data['deskripsi']}",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildAddToCartButton(),
          ],
        )
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: int.parse(widget.data['stok']) == 0
                  ? null
                  : () {
                      addToCart();
                    },
              child: Text(int.parse(widget.data['stok']) == 0 ? 'Stok Habis' : 'Tambah ke Keranjang'),
            ),
          ),
        ),
      ],
    );
  }

  void addToCart() {
    Map data = {
      "product_id": "${widget.data['id']}",
    };

    Provider.of<CartState>(context, listen: false)
        .addToCart(data: data, token: "${Provider.of<Auth>(context, listen: false).token}");
  }
}
