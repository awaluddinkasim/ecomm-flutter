import 'package:dio/dio.dart';
import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/providers/favorites.dart';
import 'package:ecomm/services/dio.dart';
import 'package:ecomm/widgets/empty_product.dart';
import 'package:ecomm/widgets/header.dart';
import 'package:ecomm/widgets/product_items.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchItem();
      Provider.of<CartState>(context, listen: false).countCart("${Provider.of<Auth>(context, listen: false).token}");
      Provider.of<FavoriteState>(context, listen: false).getFavorites(
        token: "${Provider.of<Auth>(context, listen: false).token}",
      );
    });
  }

  void fetchItem() async {
    try {
      Response res = await dio(token: "${Provider.of<Auth>(context, listen: false).token}").get('products');
      setState(() {
        items = res.data["produk"];
        loading = false;
      });
    } on DioError catch (e) {
      items = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            slivers: [
              const AppHeader(),
              if (loading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 150, horizontal: 150),
                    child: SizedBox(
                      child: LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                      ),
                    ),
                  ),
                )
              else if (items.isNotEmpty)
                ProductItems(
                  items: items,
                )
              else
                const SliverToBoxAdapter(
                  child: EmptyProduct(),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1), () {
      fetchItem();
    });
  }
}
