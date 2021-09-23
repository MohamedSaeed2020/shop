import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/user_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final FavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates{
}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final UserModel userModel;

  ShopSuccessUserDataState(this.userModel);

}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final UserModel userModel;

  ShopSuccessUpdateUserState(this.userModel);

}
class ShopErrorUpdateUserState extends ShopStates{}
class ShopLoadingUpdateUserState extends ShopStates{}