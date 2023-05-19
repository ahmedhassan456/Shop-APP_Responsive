import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/HomeCubit/HomeCubit.dart';
import 'package:shop_app/LoginCubit/LoginCubit.dart';
import 'package:shop_app/LoginCubit/LoginStates.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/modules/Home/HomeScreen.dart';
import 'package:shop_app/modules/login/register.dart';

class LoginShopApp extends StatelessWidget {
  const LoginShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.shopLoginModel.status) {
              CacheHelper.saveData(
                  key: 'token', value: state.shopLoginModel.data?.token).then((value) {
                    token = state.shopLoginModel.data?.token;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
              });

              Fluttertoast.showToast(
                  msg: '${LoginCubit.get(context).shopLoginModel!.massage}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: '${LoginCubit.get(context).shopLoginModel!.massage}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'this is a login screen for shop app',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text('Email'),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: LoginCubit.get(context).obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changeItemPasswordLoginScreen();
                            },
                            icon: Icon(
                              LoginCubit.get(context).passwordIcon,
                            ),
                          ),
                          label: const Text(
                            'password',
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).postData(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        condition: state is! LoginLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            "don't have an account?",
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                            child: const Text(
                              'Register now',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
