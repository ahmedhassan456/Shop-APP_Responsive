import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeCubit/HomeCubit.dart';
import 'package:shop_app/HomeCubit/HomeStates.dart';

import 'Search/SearchScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text('SAQR'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SearchScreen()));
              },
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'Categories'
            ),
            BottomNavigationBarItem(
              icon: Icon(
              Icons.settings,
            ),
              label: 'Settings'
            ),
          ],
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            cubit.onChangeNavBar(index: index);
          },
          currentIndex: cubit.currentIndex,
        ),
      ),
    );
  }
}
