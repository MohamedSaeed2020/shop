import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/home_cubit/cubit.dart';
import 'package:shop/cubits/search/cubit.dart';
import 'package:shop/cubits/search/states.dart';
import 'package:shop/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit=SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter text to search';
                        }
                      },
                      controller: searchController,
                      type: TextInputType.name,
                      label: 'Search',
                      prefix: Icon(Icons.search),
                      onSubmit: (text){
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    const SizedBox(height: 10.0,),
                    if(state is ShopSearchLoadingState)
                      LinearProgressIndicator(),
                    const SizedBox(height: 10.0,),
                    if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                      itemBuilder: (context, index) => buildListProduct(
                          cubit.searchModel!.data.data[index],
                        ShopCubit(),isOldPrice: false),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: cubit.searchModel!.data.data.length,
                    ),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
