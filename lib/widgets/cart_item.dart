import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final Map item;
  const CartItem({Key? key, required this.item}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      height: 130,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage("https://ecomm.my.id/img/p/${widget.item['product']['img']}"),
                width: 100,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "${widget.item['product']['nama_produk']}",
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            Provider.of<CartState>(context, listen: false).delete(
                              token: "${Provider.of<Auth>(context, listen: false).token}",
                              id: widget.item['id'],
                            );
                          },
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Harga: "),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Rp. ${formatter.format(int.parse(widget.item['product']['harga']))}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Sub Total: "),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Rp. ${formatter.format(int.parse(widget.item['product']['harga']) * int.parse(widget.item['qty']))}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text("Stok: "),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            formatter.format(int.parse(widget.item['product']['stok'])),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Provider.of<CartState>(context, listen: false).decrease(
                                token: "${Provider.of<Auth>(context, listen: false).token}",
                                id: widget.item['id'],
                              );
                            },
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.item['qty']}",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<CartState>(context, listen: false).increase(
                                token: "${Provider.of<Auth>(context, listen: false).token}",
                                id: widget.item['id'],
                              );
                            },
                            splashColor: Colors.lightBlue,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
