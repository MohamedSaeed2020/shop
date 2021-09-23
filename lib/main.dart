import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/home_cubit/cubit.dart';
import 'package:shop/layouts/home_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/on_boarding/on_boarding.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/constants.dart';
import 'package:shop/cubits/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///init dio and cache helper
  DioHelper.init();
  await CacheHelper.init();

  ///check the widget to open the app on it.
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  ///to observe bloc
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
