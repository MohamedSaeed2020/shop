import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/home_cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favorite_section_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/favorites/favourites_screen.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/settings/setting_screen.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  ///Variables
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int,bool> favorites={};
  FavoritesModel? favoritesModel;
  FavoritesSectionModel? favoritesSectionModel;
  UserModel? userModel;

  ///Methods
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  Future<void> getHomeData() async {
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('getHomeDataError: $error');
      emit(ShopErrorHomeDataState());
    });
  }
  Future<void> getCategories() async {
    await DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print('getHomeDataError: $error');
      emit(ShopErrorCategoriesState());
    });
  }
  Future<void> changeFavorites(int productId) async {
    bool? favoritesState=favorites[productId];
    if(favoritesState!=null){
      favoritesState=!favoritesState;
      favorites[productId]=favoritesState;
      emit(ShopChangeFavoritesState());
    }
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
      token: token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      if(!favoritesModel!.status){
        if(favoritesState!=null)
          favoritesState=!favoritesState!;
        favorites[productId]=favoritesState!;
      }
      else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(favoritesModel!));
    }).catchError((error) {
      print('changeFavoritesError: $error');
      if(favoritesState!=null)
        favoritesState=!favoritesState!;
      favorites[productId]=favoritesState!;
      emit(ShopErrorChangeFavoritesState());
    });
  }
  Future<void> getFavorites() async {
    emit(ShopLoadingGetFavoritesState());
    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesSectionModel = FavoritesSectionModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('getFavorites: $error');
      emit(ShopErrorGetFavoritesState());
    });
  }
  Future<void> getUserData() async {
    emit(ShopLoadingUserDataState());
    await DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print('getUserData: $error');
      emit(ShopErrorUserDataState());
    });
  }
  Future<void> updateUserData({required String name,required String email,required String phone}) async {
    emit(ShopLoadingUpdateUserState());
    await DioHelper.updateData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print('updateUserData: $error');
      emit(ShopErrorUpdateUserState());
    });
  }

}
