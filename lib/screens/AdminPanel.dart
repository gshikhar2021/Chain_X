import 'package:chain_x/Data/Order_data.dart';
import 'package:chain_x/screens/bubble_chart.dart';
import 'package:chain_x/screens/sales_analysis.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of top-level tabs
      child: Scaffold(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          title: Text('Admin Panel'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Order History'),
              Tab(text: 'Analytics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Order History Tab
            OrderHistoryTab(),

            // Analytics Tab
            AnalyticsTab(),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyOrdersData.length,
      itemBuilder: (context, index) {
        final order = dummyOrdersData[index];
        return Card(
          color: Color.fromRGBO(255, 251, 241, 1),
          margin: EdgeInsets.all(8.0),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //set border radius more than 50% of height and width to make circle
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                '${order['userName']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Order Date: ${order['orderDate']}'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Order Number: ${order['orderNumber']}'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Payment Status: ${order['paymentStatus']}'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Amount: ${order['amount']}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnalyticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of sub-tabs
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor, // Set the background color
            child: TabBar(
              labelColor:
                  Colors.white, // Set the text color of the selected tab
              unselectedLabelColor:
                  Colors.black, // Set the text color of unselected tabs
              indicatorColor: Colors.white, // Set the indicator color
              tabs: [
                Tab(
                  text: 'Bar Chart',
                  icon: Icon(Icons.bar_chart),
                ),
                Tab(
                  text: 'Bubble Chart',
                  icon: Icon(Icons.bubble_chart),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Bar Chart Tab
                ShopSalesChart(),

                // Bubble Chart Tab
                BubbleChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
