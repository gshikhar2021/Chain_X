import 'package:chain_x/Data/shop_data.dart';
import 'package:chain_x/screens/AdminPanel.dart';
import 'package:chain_x/screens/Auth.dart';
import 'package:chain_x/screens/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Shop {
  final String name;
  final String openingTime;
  final String closingTime;
  final double distance;
  final String discount;
  final double rating;

  Shop({
    required this.name,
    required this.openingTime,
    required this.closingTime,
    required this.distance,
    required this.discount,
    required this.rating,
  });
}

class Shops extends StatefulWidget {
  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  final List<Shop> shops = dummyShopData.map((data) {
    return Shop(
      name: data['name'],
      openingTime: data['openingTime'],
      closingTime: data['closingTime'],
      distance: data['distance'],
      discount: data['discount'],
      rating: data['rating'],
    );
  }).toList();

  List<Shop> filteredShops = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredShops = shops;
    super.initState();
  }

  void _filterShops(String query) {
    setState(() {
      filteredShops = shops
          .where(
              (shop) => shop.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
                size: 36,
              ),
              SizedBox(
                width: 10,
              ),
              Text('NCR, India'),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.shopping_cart,
              size: 36,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(255, 251, 241, 1),
                boxShadow: [
                  BoxShadow(blurRadius: 22),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: _filterShops,
                decoration: InputDecoration(
                  labelText: 'Search for a Shop',
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 30,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      _filterShops('');
                    },
                    icon: Icon(
                      Icons.mic,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredShops.length,
              itemBuilder: (context, index) {
                final shop = filteredShops[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Products(
                          shopName: shop.name,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Color.fromRGBO(255, 251, 241, 1),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          shop.name,
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
                              'Open: ${shop.openingTime} - Close: ${shop.closingTime}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${shop.distance.toStringAsFixed(2)} km away',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Discount: ${shop.discount}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rating: ${shop.rating.toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(85, 85, 85, 1),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Show Products ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(50, 50, 50, 1),
              ),
              child: Center(
                child: Text(
                  'Welcome to ChainX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Admin Panel'),
              onTap: () {
                // Handle Admin Panel action
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminPanel()), // Navigate to AdminPanel
                );
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                // Handle Sign Out action
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context); // Close the drawer
                // After signing out, you can navigate to the login or home screen
                // For example:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Authentication(), // Replace YourLoginScreen with the actual widget/screen
                  ),
                ); // Replace '/login' with your login screen route
              },
            ),
          ],
        ),
      ),
    );
  }
}
