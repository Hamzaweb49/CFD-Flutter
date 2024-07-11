import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class CommercialServicesRepo {
  /// add data

  static Future<ResponseItem> addCommercialServicesRepo(
      {required Map<String, dynamic> commercialServices}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.addCommercialService;
    result = await BaseApiHelper.postRequest(requestUrl, commercialServices);
    return result;
  }

  /// GET ALL Comercial Services

  static Future<ResponseItem> getAllComercialServices() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllCommercialService;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// upload image

  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl =
        AppUrls.BASE_URL + MethodNames.uploadCommercialServiceImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }

  /// pincode data

  static Future<ResponseItem> pincodeRepo({required String? pincode}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.PINCODE_URL + pincode!;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put CommercialService data
class UpdateCommercialServiceData {
  static Future<ResponseItem> updateCommercialServiceData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.updateCommercialService}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}