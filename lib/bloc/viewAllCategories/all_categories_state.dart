
part of 'all_categories_bloc.dart';

abstract class CategoryPageState{}

class CategoryPageInitialState extends CategoryPageState{}

class AllFetchDataForCategryPageState extends CategoryPageState{
  final List<ViewAllCategories_model> allCatoModel;
  AllFetchDataForCategryPageState(this.allCatoModel);
}


class CategoryPageLoadingState extends  CategoryPageState{
  final bool showProgress;
  CategoryPageLoadingState(this.showProgress);
}

class ApiFailureState extends CategoryPageState{
  final Exception exception;
  ApiFailureState(this.exception);
}

