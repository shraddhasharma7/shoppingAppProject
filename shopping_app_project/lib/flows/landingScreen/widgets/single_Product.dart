import 'package:flutter/material.dart';
import 'package:shopping_app_project/constants/controllers.dart';
import 'package:shopping_app_project/models/products.dart';
import 'package:shopping_app_project/widgets/custom_Text.dart';

class Single_Product_Widget extends StatelessWidget {
  final Products_Model? product;

  const Single_Product_Widget({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  product!.image!,
                  width: double.infinity,
                )),
          ),
          /* Row(children: [
            Custom_Text(
              text: "Name :",
              size: 18,
              weight: FontWeight.bold,
            ),
            Custom_Text(
              text: product!.name!,
              size: 18,
              weight: FontWeight.bold,
            ),
          ]),*/
          Custom_Text(
            text: product!.name!,
            size: 18,
            weight: FontWeight.bold,
          ),
          Custom_Text(
            text: product!.brand!,
            color: Colors.grey,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              color: Color(0xFFEBEBEB),
              height: 1.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Custom_Text(
                  text: "\$${product!.price!}",
                  size: 20,
                  weight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                    cartController.addProductToCart(product!);
                  })
            ],
          ),
        ],
      ),
    );
  }
}
