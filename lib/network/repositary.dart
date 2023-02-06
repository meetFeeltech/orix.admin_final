
import 'package:http/http.dart' as http;
import 'package:orix_aqua_adim/model/dashboard/dashboard_model.dart';
import 'package:orix_aqua_adim/model/viewallorders/ViewAllOrders_model.dart';
import '../api/api.dart';
import '../model/EditProductmodel/editProductModel.dart';
import '../model/login_model/login_model.dart';
import '../model/orderstatus/order_status_model.dart';
import '../model/viewallcategories/ViewAllCategories_model.dart';
import '../model/viewallproducts/viewAppProduct_model.dart';
import 'api_client.dart';
import 'cutom_exception.dart';

class Repository {

  final ApiClient apiClient;

  Repository(this.apiClient);

  static Repository getInstance() {
    return Repository(ApiClient(httpClient: http.Client()));
  }

  Future<login_model> loginPostAPI(String apiEndPoint, dynamic body) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(BASEURL, apiEndPoint, body);
      print("final received json = $json");
      login_model loginResponse = login_model.fromJson(json);
      return loginResponse;
    } on CustomException {
      rethrow;
    }
  }

  Future<Dashboard_model> getHeaderCountsData({String? dateRangeQuery}) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallGet(BASEURLHEADER,HeaderCountsEndPoint,query: dateRangeQuery ?? "");
      Dashboard_model headerCountsRes = Dashboard_model.fromJson(json);
      return headerCountsRes;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<ViewAllPro_model>> getAllProductsData({String? oneDate,required String id}) async {
    try {
      var listData = await apiClient.apiCallGet(BASEURLVAP,ViewAllProductEndPoint,query: id) as List;
      var efficiencyTableRes = listData.map((json) => ViewAllPro_model.fromJson(json)).toList();
      return efficiencyTableRes;
    } on CustomException {
      rethrow;
    }
  }

  Future<EditProduct_model> getOneProductsData({String? oneDate,required String id}) async {
    try {
      Map<String, dynamic> json= await apiClient.apiCallGet(BASEURLVAP,"${ViewAllProductEndPoint}/$id");
      EditProduct_model onepro =EditProduct_model.fromJson(json);
      return onepro;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<ViewAllCategories_model>> getAllCategoryData({String? oneDate}) async {
    try {
      var listData1 = await apiClient.apiCallGet(BASEURLVAP,ViewAllCategoriesEndPoint) as List;
      var efficiencyTableRes1 = listData1.map((json) => ViewAllCategories_model.fromJson(json)).toList();
      return efficiencyTableRes1;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<ViewAllOrders_model>> getAllOrdersData({String? oneDate}) async {
    try {
      var listData2 = await apiClient.apiCallGet(BASEURLVAO,ViewAllOrdersEndPoint) as List;
      var efficiencyTableRes2 =
      listData2.map((json) => ViewAllOrders_model.fromJson(json)).toList();
      return efficiencyTableRes2;
    } on CustomException {
      rethrow;
    }
  }

  Future<StatusChange_model>putStatusData({dynamic message,required String id}) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPut(BASEURLOS, "$OrderstatusEndPoint$id",message);
      StatusChange_model changePassModelRes = StatusChange_model.fromJson(json);
      return changePassModelRes;
    } on CustomException {
      rethrow;
    }
  }

  Future<StatusChange_model> putProductData(Map<String, dynamic> putJson, {String? id}) async {
    try {
      var json = await apiClient.apiCallMultipartPut(BASEURLPE,"$ProductEditEndPoint$id", putJson);
      print("here put json : $json");
      StatusChange_model productPut = StatusChange_model.fromJson(json);
      return productPut;
    } on CustomException {
      rethrow;
    }
  }

}
