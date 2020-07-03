import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/models/cart_item.dart';
import 'package:flutter_bloc_tutorial/models/product.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cartItem = List.unmodifiable([]);
  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddToCart) {
      yield CartLoading();
      await Future.delayed(Duration(seconds: 3));
      List<CartItem> tempList = List<CartItem>.from(_cartItem);
      bool exists = false;
      int index;
      for (var i = 0; i < _cartItem.length; i++) {
        if (event.product.name == _cartItem[i].product.name) {
          exists = true;
          index = i;
          break;
        }
      }
      if (exists) {
        tempList[index] = CartItem(
          product: event.product,
          quantity: tempList[index].quantity + 1,
        );
      } else {
        tempList.add(
          CartItem(
            quantity: 1,
            product: event.product,
          ),
        );
      }

      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    } else if (event is RemoveFromCart) {
      yield CartLoading();
      await Future.delayed(Duration(seconds: 3));
      List<CartItem> tempList = List<CartItem>.from(_cartItem);

      int index;
      for (var i = 0; i < _cartItem.length; i++) {
        if (event.product.name == _cartItem[i].product.name) {
          index = i;
          break;
        }
      }
      if (index != null) {
        if (tempList[index].quantity == 1) {
          tempList.removeAt(index);
        } else {
          tempList[index] = CartItem(
            product: event.product,
            quantity: tempList[index].quantity - 1,
          );
        }
      }
      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    }
  }
}
