import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: Image.network(
                              value.cartItems[index]
                                  .photo, // Replace this with the URL of your network image
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index].name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              '\$${value.cartItems[index].price}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () => Provider.of<CartModel>(context,
                                      listen: false)
                                  .removeItemFromCart(value.cartItems[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // total amount + pay now

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(color: Colors.black),
                          ),

                          const SizedBox(width: 100),
                          // total price
                          Text(
                            '${value.calculateTotal()} DT',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfffa4a0c),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // pay now
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xfffa4a0c),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Center(
                            child: Text(
                          'Complete order',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
