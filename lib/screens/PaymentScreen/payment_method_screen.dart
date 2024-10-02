import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'options': ['Visa', 'MasterCard', 'Amex']
    },
    {
      'name': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'options': ['PayPal Account 1', 'PayPal Account 2']
    },
    {
      'name': 'Google Pay',
      'icon': Icons.payment,
      'options': ['Google Account 1', 'Google Account 2']
    },
  ];

  // To track which item is expanded
  final Map<String, bool> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    // Initialize expanded items map with false for each method
    for (var method in paymentMethods) {
      _expandedItems[method['name']] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Goes back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          final isExpanded = _expandedItems[method['name']] ?? false;

          return Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedItems[method['name']] = !isExpanded;
                    });
                  },
                  child: ListTile(
                    leading: Icon(method['icon']),
                    title: Text(method['name']),
                    trailing: IconButton(
                      icon: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          _expandedItems[method['name']] = !isExpanded;
                        });
                      },
                    ),
                  ),
                ),
                if (isExpanded)
                  Column(
                    children: method['options'].map<Widget>((option) {
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          // Handle option selection logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: $option')),
                          );
                        },
                      );
                    }).toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
