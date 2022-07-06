import 'package:ecomm/screens/product_details.dart';
import 'package:ecomm/widgets/empty_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProductItems extends StatefulWidget {
  final List items;
  const ProductItems({Key? key, required this.items}) : super(key: key);

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  final formatter = NumberFormat.decimalPattern();
  @override
  Widget build(BuildContext context) {
    // if (widget.items.isEmpty) {
    //   return const SliverToBoxAdapter(
    //     child: EmptyProduct(),
    //   );
    // }
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Material(
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                pushNewScreen(
                  context,
                  screen: ProductDetailScreen(
                    data: widget.items[index],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: NetworkImage("https://ecomm.my.id/img/p/${widget.items[index]['img']}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${widget.items[index]["nama_produk"]}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Rp. ${formatter.format(int.parse(widget.items[index]["harga"]))}',
                      style: const TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }, childCount: widget.items.length),
    );
  }
}
