import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/blocs/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/dummy_data.dart/dummy_product_list.dart';
import 'package:flutter_bloc_tutorial/views/cart_screen.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Products",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                        maintainState: true,
                      ));
                },
              ),
              Positioned(
                right: 8,
                top: 4,
                child: BlocBuilder<CartBloc, CartState>(
                    bloc: BlocProvider.of<CartBloc>(context),
                    builder: (context, cartState) {
                      if (cartState is CartOperationSuccess &&
                          cartState.cartItems.length > 0)
                        return Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${cartState.cartItems.length}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        );
                      else {
                        return Container();
                      }
                    }),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
          itemCount: DummyProductList.products.length,
          itemBuilder: (context, index) {
            final product = DummyProductList.products[index];
            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  radius: double.infinity,
                  backgroundImage: NetworkImage(product.image),
                ),
              ),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddToCart(product));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveFromCart(product));
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
