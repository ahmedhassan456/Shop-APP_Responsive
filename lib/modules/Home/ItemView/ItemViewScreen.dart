import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/HomeCubit/HomeCubit.dart';
import 'package:shop_app/HomeCubit/HomeStates.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/models/HomeModel/HomeModel.dart';

class ViewItemScreen extends StatelessWidget {
  int? idx;
  HomeModel? productModel;

  ViewItemScreen(index, model, {super.key}) {
    idx = index;
    productModel = model;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: productModel != null && idx != null,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 200.0,
                      color: Colors.white,
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(
                            "${productModel?.data?.products[idx!].image}"),
                        width: double.infinity,
                        height: 200.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "${productModel?.data?.products[idx!].name}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.red,
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Salary: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${productModel?.data?.products[idx!].price}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            if (productModel?.data?.products[idx!].discount !=
                                0)
                              Text(
                                '${productModel?.data?.products[idx!].oldPrice.round()}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 40.0,
                          color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              TextButton(
                                onPressed: (){},
                                child: const Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.red,
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${productModel?.data?.products[idx!].description}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
