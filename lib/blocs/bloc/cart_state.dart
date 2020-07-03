part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState{}

class CartOperationSuccess extends CartState{
  final List<CartItem> cartItems;

  CartOperationSuccess(this.cartItems);
}