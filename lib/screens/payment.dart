import 'package:chain_x/screens/Shops.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;

  PaymentPage({required this.totalAmount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Amount: Rs ${widget.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildPaymentMethodRadio('Credit Card'),
              _buildPaymentMethodRadio('PayPal'),
              _buildPaymentMethodRadio('Google Pay'),
              _buildPaymentMethodRadio('Cash on Delivery'),
              // Add more payment methods as needed
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(50, 50, 50, 1),
                      ),
                    ),
                    onPressed: () {
                      if (selectedPaymentMethod != null) {
                        _processPayment(selectedPaymentMethod!);
                      } else {
                        // Show an error message, no payment method selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a payment method.'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Process Payment',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRadio(String paymentMethod) {
    return ListTile(
      title: Text(paymentMethod),
      leading: Radio<String>(
        value: paymentMethod,
        groupValue: selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
      ),
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
      },
    );
  }

  void _processPayment(String paymentMethod) {
    // Show a circular progress indicator
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Processing Payment...'),
            ],
          ),
        );
      },
    );

    // Simulate processing payment with a delay
    Future.delayed(Duration(seconds: 3), () {
      // Close the dialog
      Navigator.pop(context);

      // Show success page
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 16),
                Text('Payment Successful'),
              ],
            ),
          );
        },
      );

      // Delay before navigating to the home screen
      Future.delayed(Duration(seconds: 2), () {
        // Close the success page dialog
        Navigator.pop(context);

        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Shops(), // Replace with the actual home screen
          ),
        );
      });
    });
  }
}
