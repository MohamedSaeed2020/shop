import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop/cubits/login/cubit.dart';
import 'package:shop/cubits/login/states.dart';
import 'package:shop/layouts/home_layout.dart';
import 'package:shop/modules/register/register_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/constants.dart';

class LoginScreen extends StatelessWidget {

  final  formKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.userModel.status) {
              print(state.userModel.message);
              print(state.userModel.data.token);
              CacheHelper.saveData(key: 'token', value: state.userModel.data.token).then((value) {
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
          var cubit=ShopLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Login...'
              ),
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
                          onSubmit: (_){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }
                          },
                          isPassword: cubit.isPassword,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ///Login
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopLoginLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            pressed: () {
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            radius: 20,
                          ),
                          fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ///Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
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
