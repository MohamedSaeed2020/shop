import 'package:shop/models/user_model.dart';

abstract class ShopLoginStates{
}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{

  final UserModel  userModel;

  ShopLoginSuccessState(this.userModel);

}
class ShopLoginErrorState extends ShopLoginStates{
  final  error;

  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}
