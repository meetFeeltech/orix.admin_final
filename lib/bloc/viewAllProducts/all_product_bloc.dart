import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/network/repositary.dart';
import '../../model/viewallproducts/viewAppProduct_model.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class ProductPageBloc extends Bloc<ProductPageEvent, ProductPageState> {
  final Repository repositoryRepo;

  ProductPageBloc(this.repositoryRepo) : super(ProductPageInitialState()) {
    on<ProductPageEvent>((event, emit) async {

      if(event is AllFetchDataForProductPageEvent){
        late List<ViewAllPro_model> allproductData;

        try {
          emit(ProductPageLoadingState(true));
          allproductData =
          await repositoryRepo.getAllProductsData(id: event.arg);
          emit(ProductPageLoadingState(false));
          emit(AllFetchDataForProductPageState(allproductData));
        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(ProductPageLoadingState(false));
          emit(ApiFailureState(Exception(error.toString())));
        }
      }
      if(event is AllFetchDataForProductPageEvent3){
        late List<ViewAllPro_model> allproductData;
        try {
          allproductData =
          await repositoryRepo.getAllProductsData(id: event.arg);
          emit(AllFetchDataForProductPageState3(allproductData));
        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(ApiFailureState(Exception(error.toString())));
        }
      }

      // if(event is PutProductDataEvent){
      // late StatusChange_model productPut;
      // Map<String, dynamic> prodPutData ={
      //   'prodName': event.prodName,
      //   'prodSku': event.prodSku,
      //   'tax': event.tax,
      //   'freight': event.freight,
      //   'prodQty': event.prodQty,
      //   'branchPrice': event.branchPrice,
      //   'distributorPrice': event.distributorPrice,
      //   'dealerPrice': event.dealerPrice,
      //   'wholesalerPrice': event.wholesalerPrice,
      //   'technicianPrice': event.technicianPrice,
      //   'categoryId': event.categoryId,
      //   'brandId': event.brandId
      // };
      //
      //
      // try{
      //     emit(ProductPageLoadingState(true));
      //     productPut = await repositoryRepo.putProductData(prodPutData);
      //     emit(ProductPageLoadingState(false));
      //     emit(PutProductDataState(productPut));
      // }catch (error, stacktrace) {
      //   print(stacktrace);
      //   emit(ProductPageLoadingState(false));
      //   emit(ApiFailureState(Exception(error.toString())));
      // }
      //
      //
      // }


    });
  }
}


