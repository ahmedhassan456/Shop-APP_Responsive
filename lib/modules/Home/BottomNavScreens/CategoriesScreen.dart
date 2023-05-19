import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../HomeCubit/HomeCubit.dart';
import '../../../HomeCubit/HomeStates.dart';
import '../../../models/CategoriesModel/CategoriesModel.dart';
import '../../../models/HomeModel/HomeModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context , state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context ,index) => buildCategoriesItem(cubit.categoriesModel!.data!.data![index]),
          separatorBuilder:(context,index) => const Divider(
            height: 20.0,
            color: Colors.red,
          ),
          itemCount: cubit.categoriesModel!.data!.data!.length,
        ),
      ),
    );
  }

  Widget buildCategoriesItem(ListDataCategories model) => Row(
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
      const SizedBox(width: 10.0,),
      Text(
        '${model.name}',
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
    ],
  );
}
