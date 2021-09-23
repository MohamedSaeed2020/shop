import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubits/search/states.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/constants.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(ShopSearchInitialState());
  static SearchCubit get (context){
    return BlocProvider.of(context);
  }

  SearchModel? searchModel;
  Future<void> search(String text) async {
    emit(ShopSearchLoadingState());
    await DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print('searchError: $error');
      emit(ShopSearchErrorState());
    });
  }


}