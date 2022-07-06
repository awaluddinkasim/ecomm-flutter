import 'package:dio/dio.dart';
import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/services/dio.dart';
import 'package:ecomm/widgets/empty_product.dart';
import 'package:ecomm/widgets/header.dart';
import 'package:ecomm/widgets/product_items.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String text;
  const SearchScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchItem();
  }

  void fetchItem() async {
    try {
      Response res =
          await dio(token: "${Provider.of<Auth>(context, listen: false).token}").get('products?search=${widget.text}');
      setState(() {
        items = res.data["produk"];
        loading = false;
      });
    } on DioError catch (e) {
      print(e.response);
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
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      'Hasil pencarian dengan kata kunci "${widget.text}"',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
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
