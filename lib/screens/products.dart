import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../Data/product_data.dart';
import 'cart.dart';

const desStyle = TextStyle(
  fontSize: 18,
  // color: Color.fromRGBO(85, 85, 85, 1),
  color: Colors.black87,
);

class Product {
  final String name;
  final int price;
  final String description;
  final String category;
  final String brand;
  final Map<String, int> cartInfo;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    Map<String, int>? cartInfo,
  }) : cartInfo = cartInfo ?? {name: 0};

  // ...
}

class Products extends StatefulWidget {
  final String shopName;

  Products({required this.shopName});
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final List<Product> products = dummyProductData.map((data) {
    return Product(
      name: data['name'],
      price: data['price'],
      description: data['description'],
      category: data['category'],
      brand: data['brand'],
      cartInfo: {data['name']: 0},
    );
  }).toList();

  Map<String, int> cart = {};
  int totalCartItems = 0;
  int _calculateTotalCartItems() {
    totalCartItems = 0;
    for (Product product in products) {
      totalCartItems += product.cartInfo[product.name] ?? 0;
    }
    return totalCartItems;
  }

  @override
  Widget build(BuildContext context) {
    totalCartItems = _calculateTotalCartItems();
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        leading: Container(
          child: Icon(
            Icons.menu,
            size: 36,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.shopName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      cartProducts: products
                          .where(
                              (product) => product.cartInfo[product.name]! > 0)
                          .toList(),
                      shopName: widget.shopName,
                    ),
                  ),
                );
              },
              child: CartBadge(totalCartItems),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            color: Color.fromRGBO(255, 251, 241, 1),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                      style: desStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Description: \n${product.description}',
                      style: desStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Category: ${product.category}',
                      style: desStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Brand: ${product.brand}',
                      style: desStyle,
                    ),
                  ],
                ),
                trailing: _buildAddToCartButton(product),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddToCartButton(Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            _removeFromCart(product);
          },
        ),
        Text(product.cartInfo[product.name]?.toString() ?? '0'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addToCart(product);
          },
        ),
      ],
    );
  }

  void _addToCart(Product product) {
    setState(() {
      final cartQuantity = product.cartInfo[product.name];
      if (cartQuantity != null) {
        product.cartInfo[product.name] = cartQuantity + 1;
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      final cartQuantity = product.cartInfo[product.name];
      if (cartQuantity != null && cartQuantity > 0) {
        product.cartInfo[product.name] = cartQuantity - 1;
      }
    });
  }
}

class CartBadge extends StatefulWidget {
  final int itemCount;

  CartBadge(this.itemCount);

  @override
  _CartBadgeState createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 3, end: 3),
      badgeContent: Text(
        widget.itemCount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: Icon(
        Icons.shopping_cart,
        size: 36,
      ),
    );
  }

  @override
  void didUpdateWidget(CartBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemCount != widget.itemCount) {
      // If the itemCount changes, trigger a rebuild
      setState(() {});
    }
  }
}
