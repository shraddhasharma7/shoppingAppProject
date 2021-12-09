import 'package:flutter/material.dart';
import 'package:shopping_app_project/constants/controllers.dart';
import 'package:shopping_app_project/models/cart_Items.dart';
import 'package:shopping_app_project/widgets/custom_Text.dart';

class Cart_Items_Widget extends StatelessWidget {
  final Cart_Items_Model? cartItem;

  const Cart_Items_Widget({Key? key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            cartItem!.image!,
            width: 80,
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.only(left: 14),
                child: Custom_Text(
                  text: cartItem!.name!,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      cartController.decreaseQuantity(cartItem!);
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custom_Text(
                    text: cartItem!.quantity.toString(),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      cartController.increaseQuantity(cartItem!);
                    }),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Custom_Text(
            text: "\$${cartItem!.cost}",
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
