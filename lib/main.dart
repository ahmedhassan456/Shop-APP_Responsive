import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/DioHelper.dart';
import 'package:shop_app/LoginCubit/LoginStates.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/modules/Home/HomeScreen.dart';
import 'package:shop_app/modules/login/LoginShopApp.dart';
import 'HomeCubit/HomeCubit.dart';
import 'LoginCubit/LoginCubit.dart';
import 'layout/OnBoardingScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  bool checkToken = false;
  if(token == null){
    checkToken = false;
  }else{
    checkToken = true;
  }
  runApp(MyApp(token: checkToken,));
}

class MyApp extends StatelessWidget {
  final bool token;
  const MyApp({super.key, required this.token,});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(context) => LoginCubit(),
        ),
        BlocProvider(
            create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: myColor,
              elevation: 0.0,
              actionsIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 0.0,
              backgroundColor: myColor,
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              selectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.5),
              unselectedIconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.5),
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          home: token ? const HomeScreen() : const OnBoardingScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }

}
