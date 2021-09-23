
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/cubits/home_cubit/cubit.dart';
import 'package:shop/cubits/home_cubit/states.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = ShopCubit.get(context).userModel;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => userModel != null,
          widgetBuilder: (context) => buildProfileInfo(userModel!,context,state),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildProfileInfo(UserModel userModel,context,ShopStates state) {
    nameController.text = userModel.data.name;
    emailController.text = userModel.data.email;
    phoneController.text = userModel.data.phone;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if(state is ShopLoadingUpdateUserState)
              LinearProgressIndicator(),
            const SizedBox(
              height: 20.0,
            ),
            defaultTextFormField(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Name must not be empty';
                }
              },
              controller: nameController,
              type: TextInputType.name,
              label: 'Name',
              prefix: Icon(Icons.person),
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultTextFormField(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Email must not be empty';
                }
              },
              controller: emailController,
              type: TextInputType.emailAddress,
              label: 'Email Address',
              prefix: Icon(Icons.email),
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultTextFormField(
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Phone must not be empty';
                }
              },
              controller: phoneController,
              type: TextInputType.phone,
              label: 'Phone',
              prefix: Icon(Icons.phone),
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              pressed: () {
                signOut(context);
              },
              text: 'logout',
              radius: 20,
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              pressed: () {
                if(formKey.currentState!.validate()){
                  ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                  );
                }
              },
              text: 'update',
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
