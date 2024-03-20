import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ShopSalesChart extends StatefulWidget {
  @override
  _ShopSalesChartState createState() => _ShopSalesChartState();
}

class _ShopSalesChartState extends State<ShopSalesChart> {
  int tt = 0;
  late List<Map<String, dynamic>> products; // Initialize products list

  @override
  void initState() {
    super.initState();
    // Fetch products data when the widget is initialized
    _fetchProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: Text('Sales Chart of Enzo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your chart widget here, using the products data
            _buildSalesChart(),
          ],
        ),
      ),
    );
  }

  int generateRandomSales() {
    // Assuming a range between 50 and 200 for demonstration purposes
    final Random random = Random();
    return random.nextInt(15000) + 50;
  }

  int calculateTotalSales(List<Map<String, dynamic>> salesData) {
    int totalSales = 0;
    for (var entry in salesData) {
      totalSales += entry['sales'] as int;
    }
    return totalSales;
  }

  // Function to fetch products data from Firebase or any other source
  void _fetchProductsData() {
    // Add your logic to fetch products data and update the products list
    // Example: Fetch data from Firebase based on widget.shopName
    // products = fetchDataFromFirebase(widget.shopName);

    // For now, using dummy data
    products = [
      {'product': 'Milk', 'sales': generateRandomSales()},
      {'product': 'Bread', 'sales': generateRandomSales()},
      {'product': 'Eggs', 'sales': generateRandomSales()},
      {'product': 'Bananas', 'sales': generateRandomSales()},
      {'product': 'Cereal', 'sales': generateRandomSales()},
      {'product': 'Orange Juice', 'sales': generateRandomSales()},
      {'product': 'Apples', 'sales': generateRandomSales()},
      {'product': 'Pasta', 'sales': generateRandomSales()},
      {'product': 'Toothpaste', 'sales': generateRandomSales()},
    ];
    tt = calculateTotalSales(products);
  }

  // Function to build the sales chart
  Widget _buildSalesChart() {
    // Your chart logic here using the products data
    // Example: Using PieChart
    return Column(
      children: [
        Container(
          height: 300, // Set a specific height
          width: 300, // Set a specific width
          child: PieChart(
            PieChartData(
              sections: List.generate(
                products.length,
                (index) {
                  final product = products[index];
                  return PieChartSectionData(
                    value: product['sales'].toDouble(),
                    color: _getColor(index),
                    title: '${product['product']} \nRs ${product['sales']}',
                    radius: 50,
                  );
                },
              ),
              // Other PieChart configuration options
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Total Sales Rs ${tt}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Menlo",
          ),
        )
      ],
    );
  }

  // Function to get colors for each section of the PieChart
  Color _getColor(int index) {
    // Your logic to determine colors
    // For now, using a simple list of colors
    final List<Color> colors = [Colors.red, Colors.green, Colors.blue];
    return colors[index % colors.length];
  }
}
