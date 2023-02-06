import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/model/viewallcategories/ViewAllCategories_model.dart';

import '../../network/repositary.dart';

part 'all_categories_event.dart';
part 'all_categories_state.dart';

class CateoryPageBloc extends Bloc<CateoryPageEvent, CategoryPageState> {
  final Repository repositoryRepo;

  CateoryPageBloc(this.repositoryRepo) : super(CategoryPageInitialState()) {
    on<CateoryPageEvent>((event, emit) async {

      if(event is AllFetchDataForCategoryPageEvent){
        late List<ViewAllCategories_model> allCategoryData;

        try{
          emit(CategoryPageLoadingState(true));
          allCategoryData =
          await repositoryRepo.getAllCategoryData();
          emit(CategoryPageLoadingState(false));
          emit(AllFetchDataForCategryPageState(allCategoryData));

        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(CategoryPageLoadingState(false));
          emit(ApiFailureState(Exception(error.toString())));
        }

      }



    });
  }
}
