import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/LoginCubit/LoginCubit.dart';
import 'package:shop_app/LoginCubit/LoginStates.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/modules/Home/HomeScreen.dart';
import 'package:shop_app/modules/login/Register/registerScreen.dart';

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
          backgroundColor: myColor,
          appBar: AppBar(
            backgroundColor: myColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                height: 450.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
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
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'this is a login screen for shop app',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                    'Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIconColor: Colors.white,
                                focusColor: Colors.white,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
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
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changeItemPasswordLoginScreen();
                                  },
                                  icon: Icon(
                                    LoginCubit.get(context).passwordIcon,
                                    color: Colors.white,
                                  ),
                                ),
                                label: const Text(
                                  'password',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
                                  color: myColor,
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
                                  const Center(child: CircularProgressIndicator(color: Colors.white,)),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "don't have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
                                  child: Text(
                                    'Register now',
                                    style: TextStyle(
                                      color: myColor,
                                    ),
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
          ),
        ),
      ),
    );
  }
}
