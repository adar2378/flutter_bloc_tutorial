import 'package:flutter_bloc_tutorial/models/product.dart';

class CartItem {
  final Product product;

  final int quantity;

  CartItem({this.product, this.quantity});
}
