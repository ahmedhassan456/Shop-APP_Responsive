import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeCubit/HomeCubit.dart';
import 'package:shop_app/HomeCubit/HomeStates.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/modules/login/LoginShopApp.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context).userData;
    var cubitEnabled = HomeCubit.get(context);
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = cubit!.data!.name;
        emailController.text = cubit.data!.email;
        phoneController.text = cubit.data!.phone;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundColor: myColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    enabled: cubitEnabled.enabled,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    enabled: cubitEnabled.enabled,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    enabled: cubitEnabled.enabled,
                    decoration: const InputDecoration(
                      label: Text('Phone'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(onPressed: (){
                        cubitEnabled.changeEnabled();
                      }, icon: const Icon(Icons.edit_note,),),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    color: myColor,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginShopApp()), (route) => false);
                        CacheHelper.removeData(key: 'token');
                      },
                      height: 40.0,
                      color: myColor,
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
