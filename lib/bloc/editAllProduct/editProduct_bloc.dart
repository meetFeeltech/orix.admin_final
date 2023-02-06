
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/EditProductmodel/editProductModel.dart';
import '../../model/orderstatus/order_status_model.dart';
import '../../network/repositary.dart';
import '../viewAllProducts/all_product_bloc.dart';

part 'editProduct_event.dart';
part 'editProduct_state.dart';

class EditProductPageBloc extends Bloc<EditProductPageEvent, EditProductPageState> {
  final Repository repositoryRepo;

  EditProductPageBloc(this.repositoryRepo) : super(EditProductPageInitialState()) {

    on<EditProductPageEvent>((event, emit) async {

      if(event is AllFetchDataForProductPageEvent2){
        late EditProduct_model allproductData1;

        try {
          emit(EditProductPageLoadingState(true));
          allproductData1 =
          await repositoryRepo.getOneProductsData(id: event.id);
          emit(EditProductPageLoadingState(false));
          emit(AllFetchDataForProductPageState2(allproductData1));
        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(EditProductPageLoadingState(false));
          emit(ApiFailureState2(Exception(error.toString())));
        }
      }


      if(event is PutProductDataEvent){
        late StatusChange_model productPut;

        Map<String, dynamic> prodPutData ={
          'prodName': event.prodName,
          'prodSku': event.prodSku,
          'tax': event.tax,
          'freight': event.freight,
          'prodQty': event.prodQty,
          'branchPrice': event.branchPrice,
          'distributorPrice': event.distributorPrice,
          'dealerPrice': event.dealerPrice,
          'wholesalerPrice': event.wholesalerPrice,
          'technicianPrice': event.technicianPrice,
          'categoryId': event.categoryId,
          'brandId': event.brandId,
          'thumbnail':event.thumbnail
        };


        try{
          emit(EditProductPageLoadingState(true));
          productPut = await repositoryRepo.putProductData(id: event.id,prodPutData);
          print("product data here : $prodPutData");
          emit(EditProductPageLoadingState(false));
          emit(EditPutProductDataState(productPut));
        }catch (error, stacktrace) {
          print(stacktrace);
          emit(EditProductPageLoadingState(false));
          emit(ApiFailureState2(Exception(error.toString())));
        }
      }
    });

  }
  }
