
part of 'editProduct_bloc.dart';


abstract class EditProductPageState{}

class EditProductPageInitialState extends EditProductPageState{}

class EditProductPageLoadingState extends  EditProductPageState{
  final bool showProgress;
  EditProductPageLoadingState(this.showProgress);
}

class AllFetchDataForProductPageState2 extends EditProductPageState{
  final EditProduct_model allProductModelresponse;
  AllFetchDataForProductPageState2(this.allProductModelresponse);
}

class EditPutProductDataState extends EditProductPageState {
  StatusChange_model productPutResponse;

  EditPutProductDataState(this.productPutResponse);
}

class ApiFailureState2 extends EditProductPageState  {
  final Exception exception;
  ApiFailureState2(this.exception);
}

