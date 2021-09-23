import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/cubits/home_cubit/cubit.dart';
import 'package:shop/cubits/home_cubit/states.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(
              onPressed: (){
                navigateTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),
          ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
            elevation: 20.0,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index){cubit.changeIndex(index);},
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                label: 'Setting'
              ),
            ],

          ),
        );
      },
    );
  }
}
