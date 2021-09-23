import 'package:shop/models/user_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final UserModel userModel;

  ShopRegisterSuccessState(this.userModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
