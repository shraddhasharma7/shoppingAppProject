import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app_project/models/cart_Items.dart';

class User_Model {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";

  String? id;
  String? name;
  String? email;
  List<Cart_Items_Model>? cart;

  User_Model({this.id, this.name, this.email, this.cart});

  User_Model.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()![NAME];
    email = snapshot.data()![EMAIL];
    id = snapshot.data()![ID];
    cart = _convertCartItems(snapshot.data()![CART] ?? []);
  }

  List<Cart_Items_Model> _convertCartItems(List cartFomDb) {
    List<Cart_Items_Model> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(Cart_Items_Model.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();

  static void bindStream(Stream<User_Model> listenToUser) {}
}
