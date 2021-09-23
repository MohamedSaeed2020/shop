import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/login/states.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  UserModel? userModel;
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get (context){
    return BlocProvider.of(context);
  }

  void userLogin({required String email,required String password}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      userModel=UserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(userModel!));
    }).catchError((error){
      print('userLoginError: $error');
      emit(ShopLoginErrorState(error));
    });
  }

  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }


}