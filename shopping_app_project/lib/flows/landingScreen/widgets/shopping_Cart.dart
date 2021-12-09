import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shopping_app_project/constants/controllers.dart';
import 'package:shopping_app_project/flows/landingScreen/widgets/cart_Items_Widget.dart';
import 'package:shopping_app_project/widgets/custom_Button.dart';
import 'package:shopping_app_project/widgets/custom_Text.dart';
import 'package:shopping_app_project/widgets/payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Shopping_Cart_Widget extends StatelessWidget {
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

    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Custom_Text(
                text: "My Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.cart!
                      .map((cartItem) => Cart_Items_Widget(
                            cartItem: cartItem,
                          ))
                      .toList(),
                )),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Obx(
                  () => Custom_Button(
                      text:
                          "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                      onTap: () async {
                        await initPaymentSheet(context,
                            email: "abcd@gmail.com",
                            amount: cartController.totalCartPrice.value * 100);

                        /*{

                        /*
                        // S payment code will come here
                        print(cartController.totalCartPrice.value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Payment(
                                    amount:
                                        cartController.totalCartPrice.value)));*/
                      }*/
                      }),
                )))
      ],
    );
  }
}
