
part of 'all_product_bloc.dart';

abstract class ProductPageState{}

class ProductPageInitialState extends ProductPageState{}

class AllFetchDataForProductPageState extends ProductPageState{
  final List<ViewAllPro_model> allProductModelresponse;
  AllFetchDataForProductPageState(this.allProductModelresponse);
}
class AllFetchDataForProductPageState3 extends ProductPageState{
  final List<ViewAllPro_model> allProductModelresponse;
  AllFetchDataForProductPageState3(this.allProductModelresponse);
}

class ProductPageLoadingState extends  ProductPageState{
  final bool showProgress;
  ProductPageLoadingState(this.showProgress);
}

// class PutProductDataState extends ProductPageState {
//   StatusChange_model productPutResponse;
//
//   PutProductDataState(this.productPutResponse);
// }

class ApiFailureState extends ProductPageState  {
  final Exception exception;
  ApiFailureState(this.exception);
}
