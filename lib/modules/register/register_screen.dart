import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop/cubits/register/cubit.dart';
import 'package:shop/cubits/register/states.dart';
import 'package:shop/layouts/home_layout.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/constants.dart';

class RegisterScreen extends StatelessWidget {

  ///variables
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.userModel.status) {
              print(state.userModel.message);
              CacheHelper.saveData(key: 'token', value: state.userModel.data.token).then((value) {
                //update token value after register
                token=state.userModel.data.token;
                navigateAndFinish(context, HomeLayout());
              });
            }
            else{
              if(state.userModel.message!=null){
                print(state.userModel.message);
                showToast(state.userModel.message!, ToastStates.ERROR);
              }
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Register'),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/account.png'),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ///Name TFF
                        defaultTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ///Email TFF
                        defaultTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ///Password TFF
                        defaultTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icon(Icons.lock_outline),
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: cubit.isPassword,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        ///Phone TFF
                        defaultTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icon(Icons.phone),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ///Register
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopRegisterLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            pressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            radius: 20,
                          ),
                          fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
