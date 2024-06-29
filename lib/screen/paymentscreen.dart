import 'package:flutter/material.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final double totalAmount;
  final double serviceTaxPercent = 5.0; // Example service tax percentage

  PaymentSummaryScreen({required this.totalAmount, Key? key}) : super(key: key);

  @override
  _PaymentSummaryScreenState createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  bool _isPaymentSuccessful = false;

  @override
  Widget build(BuildContext context) {
    final serviceTax = (widget.serviceTaxPercent / 100) * widget.totalAmount;
    final finalAmount = widget.totalAmount + serviceTax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Summary'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.teal[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Items: 5', // Example total items, update accordingly
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Service Tax (${widget.serviceTaxPercent.toStringAsFixed(2)}%): \$${serviceTax.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Amount: \$${finalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isPaymentSuccessful
                  ? Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 60,
                            key: ValueKey<bool>(_isPaymentSuccessful),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Payment Successful',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      key: ValueKey<bool>(_isPaymentSuccessful),
                      onPressed: () {
                        setState(() {
                          _isPaymentSuccessful = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment Successful')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Confirm Payment'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
