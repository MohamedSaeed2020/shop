import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/register/states.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  UserModel? userModel;
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get (context){
    return BlocProvider.of(context);
  }

  void userRegister({required String email,required String password,required String name, String phone=''}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        },
    ).then((value) {
      print('True: ${value.data}');
      userModel=UserModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(userModel!));
    }).catchError((error){
      print('userRegisterError: $error');
      emit(ShopRegisterErrorState(error));
    });
  }

  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}