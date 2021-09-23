import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop/cubits/home_cubit/cubit.dart';
import 'package:shop/cubits/home_cubit/states.dart';
import 'package:shop/models/favorite_section_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.favoritesSectionModel!=null,
          widgetBuilder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                cubit.favoritesSectionModel!.data.data[index].product, cubit
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesSectionModel!.data.data.length,
          ),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
