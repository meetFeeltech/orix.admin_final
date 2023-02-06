
part of 'all_product_bloc.dart';


abstract class ProductPageEvent{}

class ProductPageInitialEvent extends ProductPageEvent{}

class AllFetchDataForProductPageEvent extends ProductPageEvent{
  final String arg;
  AllFetchDataForProductPageEvent(this.arg);
}

class AllFetchDataForProductPageEvent3 extends ProductPageEvent{
  final String arg;
  AllFetchDataForProductPageEvent3(this.arg);
}

// class PutProductDataEvent extends ProductPageEvent {
//   final String? prodName, prodSku, tax,
//       freight, prodQty, branchPrice, distributorPrice,
//       dealerPrice, wholesalerPrice, technicianPrice, categoryId, brandId;
//
//   PutProductDataEvent(
//       this.prodName,
//       this.prodSku,
//       this.tax,
//       this.freight,
//       this.prodQty,
//       this.branchPrice,
//       this.distributorPrice,
//       this.dealerPrice,
//       this.wholesalerPrice,
//       this.technicianPrice,
//       this.categoryId,
//       this.brandId);
//
// }
