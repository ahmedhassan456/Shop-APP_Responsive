import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/Register/RegisterCubit/RegisterCubit.dart';
import 'package:shop_app/modules/login/Register/RegisterCubit/RegisterStates.dart';

import '../../../LoginCubit/LoginCubit.dart';
import '../../../cacheHelper/CacheHelper.dart';
import '../../../constant/constant.dart';
import '../../Home/HomeScreen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var RegisterEmailController = TextEditingController();
    var RegisterPasswordController = TextEditingController();
    var RegisterPhoneController = TextEditingController();
    var RegisternameController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (RegisterCubit.get(context).registerModel!.status!) {
              CacheHelper.saveData(
                  key: 'token', value: RegisterCubit.get(context).registerModel!.data?.token).then((value) {
                token = RegisterCubit.get(context).registerModel!.data?.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                );
              });

              Fluttertoast.showToast(
                  msg: '${RegisterCubit.get(context).registerModel!.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: '${RegisterCubit.get(context).registerModel!.message}',
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 530.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'this is a register screen for shop app',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: RegisternameController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                    'Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
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
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: RegisterEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'email',
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
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: RegisterPasswordController,
                              obscureText: LoginCubit.get(context).obscurePassword,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.visiblePassword,
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
                                    color: Colors.white
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
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: RegisterPhoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'phone',
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
                                color: myColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).register(
                                        name: RegisternameController.text,
                                        email: RegisterEmailController.text,
                                        phone: RegisterPhoneController.text,
                                        password: RegisterPasswordController.text,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              condition: state is! RegisterLoadingState,
                              fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 20.0,
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
