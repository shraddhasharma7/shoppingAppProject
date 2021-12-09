import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment extends StatelessWidget {
  final double amount;
  Payment({required this.amount});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Payment',
      theme: ThemeData(
        shadowColor: Color(0xFFEBEBEB),
      ),
      home: PaymentScreen(
        amount: this.amount,
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  double amount;
  PaymentScreen({required this.amount});
  @override
  Widget build(BuildContext context) {
    Stripe.publishableKey =
        "pk_test_51K0vkiDlc5t7kxduKR2KnfE6Srk951FJIfzmn2ITpJiPdyGsN2bfCctP8SFnIaNSFdkxCXwAvDEykWG8YEu5HPMs00n3Bu5ZMe";
    Future<void> initPaymentSheet(context,
        {required String email, required double amount}) async {
      try {
        final response = await http.post(
            Uri.parse(
                'https://us-central1-shoppingappproject-1cccf.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });

        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Grocery Checkout',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
            style: ThemeMode.light,
            testEnv: true,
            merchantCountryCode: 'US',
          ),
        );

        await Stripe.instance.presentPaymentSheet();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment is Successful')),
        );
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong. Retry!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                await initPaymentSheet(context,
                    email: "abcd@gmail.com", amount: this.amount * 100);
              },
              child: const Text(
                'Confirm and Pay ',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
