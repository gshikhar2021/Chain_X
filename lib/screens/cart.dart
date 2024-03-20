import 'package:chain_x/screens/payment.dart';
import 'package:chain_x/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartProducts;
  final String shopName;
  CartPage({required this.cartProducts, required this.shopName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            color: Color.fromRGBO(255, 251, 241, 1),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Price: Rs ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(85, 85, 85, 1),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Quantity: ${product.cartInfo[product.name]}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(85, 85, 85, 1),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Total: Rs ${(product.price * product.cartInfo[product.name]!).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(85, 85, 85, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(50, 50, 50, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(255, 251, 241, 0.5),
              ),
            ),
            onPressed: () async {
              double totalAmount = calculateTotalAmount(cartProducts);

              // Clear the cart
              // clearCart();

              // Store order data in Firebase
              await storeOrderData(cartProducts, totalAmount, shopName);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    totalAmount: totalAmount,
                  ),
                ),
              );
            },
            child: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateTotalAmount(List<Product> products) {
    double totalAmount = 0.0;
    for (var product in products) {
      totalAmount += product.price * product.cartInfo[product.name]!;
    }
    return totalAmount;
  }

  // void clearCart() {
  //   // Clear the cart data (reset or set to an empty list)
  //   // Example: cartProducts.clear();
  // }

  Future<void> storeOrderData(
      List<Product> products, double totalAmount, String Name) async {
    String shopName = Name; // Replace with your logic to get the shop name

    // Create a reference to the orders collection
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');

    // Use the set method with SetOptions(merge: true) to create or update the document
    await orders.doc(shopName).set({
      'totalAmount': FieldValue.increment(totalAmount),
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Update the products array
    await orders.doc(shopName).update({
      'products': FieldValue.arrayUnion(
        products
            .map((product) => {
                  'name': product.name,
                  'price': product.price,
                  'quantity': product.cartInfo[product.name],
                })
            .toList(),
      ),
    });
  }
}
