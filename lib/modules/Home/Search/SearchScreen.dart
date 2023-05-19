import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../SearchCubit/SearchCubit.dart';
import '../../../SearchCubit/SearchStates.dart';
import '../../../models/SearchModel/SearchModel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var searchKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                condition: state is SearchLoadingState,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: searchKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: searchController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'this field must not be empty';
                            }
                            return null;
                          },
                          onFieldSubmitted: (String value){
                            SearchCubit.get(context).search(text: value);
                          },
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Search'),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ListView.separated(
                          itemBuilder: (context , index) => searchItem(SearchCubit.get(context).model!.data!.data![index]),
                          separatorBuilder:(context, index) => const SizedBox(height: 5.0,),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            ),
      ),
    );
  }
}

Widget searchItem(ItemSearchData model) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage(model.image!),
          width: double.infinity,
          height: 200.0,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(),
              ),
              const SizedBox(
                height: 1.0,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Spacer(),
                  // CircleAvatar(
                  //   radius: 17.0,
                  //   backgroundColor: HomeCubit
                  //       .get(context)
                  //       .favorites[model.id]! ? Colors.red : Colors
                  //       .grey[300],
                  //   child: IconButton(
                  //     onPressed: () {
                  //       HomeCubit.get(context).changeFavoritesItem(
                  //           model.id);
                  //     },
                  //     icon: const Icon(
                  //       Icons.favorite_border,
                  //       size: 16.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// build your item search
