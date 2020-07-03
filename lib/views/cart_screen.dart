import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/blocs/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, cartState) {
          if (cartState is CartOperationSuccess &&
              cartState.cartItems.length > 0) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartState.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartState.cartItems[index];
                      return ListTile(
                        leading: Text("x${cartItem.quantity}"),
                        title: Text(cartItem.product.name),
                        trailing: Text(cartItem.product.price.toString()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Text(
                      "Total Price :  ${calculatePrice(cartState.cartItems)}"),
                ),
              ],
            );
          } else if (cartState is CartLoading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("No items in cart yet! Please add first!"),
              ),
            );
          }
        },
      ),
    );
  }

  int calculatePrice(List<CartItem> cartItems) {
    int result = 0;
    cartItems.forEach((element) {
      result += (element.quantity * element.product.price);
    });
    return result;
  }
}
