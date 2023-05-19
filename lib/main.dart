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
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          home: token ? const HomeScreen() : const OnBoardingScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }

}
