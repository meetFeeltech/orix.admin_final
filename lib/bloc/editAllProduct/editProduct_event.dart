
part of 'editProduct_bloc.dart';


abstract class EditProductPageEvent{}

class EditProductPageInitialEvent extends EditProductPageEvent{}

class AllFetchDataForProductPageEvent2 extends EditProductPageEvent{
  final String id;
  AllFetchDataForProductPageEvent2(this.id);
}

class PutProductDataEvent extends EditProductPageEvent {

  final String? id,prodName, prodSku, categoryId, brandId;

  final int?  branchPrice, distributorPrice,
      dealerPrice, wholesalerPrice, technicianPrice,
      prodQty,freight,tax;

  final File? thumbnail;

  PutProductDataEvent(
    this.id,
      this.prodName,
      this.prodSku,
      this.tax,
      this.freight,
      this.prodQty,
      this.branchPrice,
      this.distributorPrice,
      this.dealerPrice,
      this.wholesalerPrice,
      this.technicianPrice,
      this.categoryId,
      this.brandId,
      {this.thumbnail});

}
