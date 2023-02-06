import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../api/api.dart';
import 'cutom_exception.dart';

class ApiClient {
  http.Client? httpClient;

  ApiClient({this.httpClient});

  // GETAPICALL
  Future<dynamic> apiCallGet(String baseUrl, String apiEndPoint, {String query = ""}) async {
    var getResponseJson;
    var getUrl;

    if(query.isNotEmpty){
      getUrl = '$baseUrl$apiEndPoint?$query';
    } else {
      getUrl = '$baseUrl$apiEndPoint';
    }


    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "$accessToken"
    };

    print("url: $getUrl, headers: $headers");


    try {
      var response = await httpClient?.get(Uri.parse(getUrl), headers: headers);
      getResponseJson = await _parseGetResponse(response!);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return getResponseJson;
  }

  Future<dynamic> _parseGetResponse(http.Response response) async {
    debugPrint("Get Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var getResponseJson = json.decode(response.body);
        return getResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      case 400:
        throw ServerValidationError("hi");

      default:
        throw Exception("Something went Wrong");
    }
  }

  Future<dynamic> apiCallPost(String baseUrl,String apiEndPoint, dynamic postBody) async {
    var postResponseJson;
    var getUrl;

    getUrl = '$baseUrl$apiEndPoint';

    var encodedBody = json.encode(postBody);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "$accessToken"
    };

    print("url: $getUrl, headers: $headers");
    try{
      var response = await httpClient?.post(Uri.parse(getUrl), headers: headers, body: encodedBody);
      postResponseJson = await _parsePostResponse(response!);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return postResponseJson;
  }

  Future<dynamic> _parsePostResponse(http.Response response) async {
    debugPrint("Post Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var postResponseJson = json.decode(response.body);
        return postResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      default:
        throw Exception("Something went Wrong");
    }
  }

  Future<dynamic> apiCallPut(String baseUrl, String apiEndPoint, dynamic putBody) async {
    var putResponseJson;
    var getUrl;

    getUrl ='$baseUrl$apiEndPoint';

    var encodedBody = json.encode(putBody);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "$accessToken"
    };

    print("url: $getUrl, headers: $headers");
    try {

      var response = await httpClient!.put(Uri.parse(getUrl), headers: headers, body: encodedBody);
     print("response : ${response.body}");
      putResponseJson = await _parsePutResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return putResponseJson;
  }

  Future<dynamic> _parsePutResponse(http.Response response) async {
    debugPrint("Put Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var putResponseJson = json.decode(response.body);
        return putResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      case 400:
        throw ServerValidationError("hi");

      default:
        throw Exception("Something went Wrong");
    }
  }

  // PUTAPICALL
  Future<dynamic> apiCallMultipartPut(String baseUrl, String apiEndPoint, dynamic putBody) async {
    // Map<String, dynamic> jDecoded = json.decode(putBody);
    putData data = putData.fromJson(putBody);
    // print("${data.email} ${data.image} ${data.dob} ${data.state} ${data.district} ${data.area}");
    print(" here data ${data.prodName} ${data.prodSku} ${data.tax} ${data.freight} ${data.prodQty} ${data.branchPrice} ${data.distributorPrice} ${data.dealerPrice} ${data.wholesalerPrice} ${data.technicianPrice} ${data.categoryId} ${data.brandId} ${data.thumbnail}");

        var putResponse;
        var getUrl;

    getUrl = Uri.parse('$baseUrl$apiEndPoint');
    print("putUrl $getUrl");

    var request = http.MultipartRequest('PUT', getUrl);

    request.headers.addAll({
      "Content-Type": "application/json",
      "isClient": "true",
      "Authorization": "$accessToken"
    });

    if(data.thumbnail != null) {
      var stream = http.ByteStream(data.thumbnail!.openRead());
      stream.cast();
      var length = await data.thumbnail!.length();
      var multiport = await http.MultipartFile.fromPath("thumbnail",data.thumbnail!.path, contentType: MediaType('image', 'jpg'));
      request.files.add(multiport);
    }


    request.fields['prodName'] = data.prodName!;
    request.fields['prodSku'] = data.prodSku!;
    request.fields['tax'] = data.tax!.toString();
    request.fields['freight'] = data.freight!.toString();
    request.fields['prodQty'] = data.prodQty!.toString();
    request.fields['branchPrice'] = data.branchPrice!.toString();
    request.fields['distributorPrice'] = data.distributorPrice!.toString();
    request.fields['dealerPrice'] = data.dealerPrice!.toString();
    request.fields['wholesalerPrice'] = data.wholesalerPrice!.toString();
    request.fields['technicianPrice'] = data.technicianPrice!.toString();
    request.fields['categoryId'] = data.categoryId!.toString();
    request.fields['brandId'] = data.brandId!.toString();
    // request.fields['thumbnail'] = data.thumbnail!.toString();


    var response = await request.send();

    var stringResponse = await response.stream.bytesToString();
    print("string response ${stringResponse}");
    print(response.request);
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var jDecode = json.decode(stringResponse);
        return jDecode;

      // case 400:
      //   Map<String, dynamic> jsonD = json.decode(stringResponse);
      //   ChangePassModel changePassModelRes = ChangePassModel.fromJson(jsonD);
      //   throw ServerValidationError(changePassModelRes.message);

      case 400:
        throw ServerValidationError("Server validation error : 404");

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      default:
        throw Exception("Something went Wrong");
    }
  }

}

class putData {
  String? prodName, prodSku,categoryId,brandId;
  int? tax, freight, prodQty, branchPrice,distributorPrice,dealerPrice,wholesalerPrice,technicianPrice;
  File? thumbnail;

  putData({
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
    this.thumbnail,
  });

  putData.fromJson(Map<String, dynamic> json) {
    prodName = json['prodName'];
    prodSku = json['prodSku'];
    tax = json['tax'];
    freight = json['freight'];
    prodQty = json['prodQty'];
    branchPrice = json['branchPrice'];
    distributorPrice = json['distributorPrice'];
    dealerPrice = json['dealerPrice'];
    wholesalerPrice = json['wholesalerPrice'];
    technicianPrice = json['technicianPrice'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    thumbnail = json['thumbnail'];
  }
}
