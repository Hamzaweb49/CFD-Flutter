import 'dart:developer';
import 'dart:io';
import 'package:claxified_app/api/repo/commercial_services_repo.dart';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/model/get_city_response_model.dart';

import 'package:claxified_app/model/get_nearby_response_model.dart';
import 'package:claxified_app/model/get_pincode_details_response_model.dart';
import 'package:claxified_app/model/get_state_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_commercial_services_res_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CommercialServicesFormController extends GetxController {
  ImagePicker picker = ImagePicker();
  List<File> addDataList = [];
  File? profileImage;
  RxBool isLoading = false.obs;
  int confirmLocation = 0;
  String nearBySelect = '';
  String stateSelect = '';
  String citySelect = '';
  String? stateIdSelect;
  String? cityIdSelect;
  bool isValidate = false;
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nearByController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  clearControllerValue(TextEditingController controller) {
    controller.clear();
    update();
  }

  removePhoto(int index) {
    addDataList.remove(addDataList[index]);
    update();
  }

  reorderImages(int newIndex, int oldIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final File image = addDataList.removeAt(oldIndex);
    addDataList.insert(newIndex, image);
    update();
  }

  ///STATE ID
  Future stateId() async {
    for (var element in getAllStateResponseModel) {
      if (element.name == stateSelect) {
        stateIdSelect = element.id.toString();
      }
    }
    log('stateIdSelect---------->>>>>> ${stateIdSelect}');
    update();
  }

  ///STATE ID
  Future cityId() async {
    for (var element in getAllCityResponseModel) {
      if (element.name == citySelect) {
        cityIdSelect = element.id.toString();
      }
    }
    log('stateIdSelect---------->>>>>> ${cityIdSelect}');
    update();
  }

  /// PICK MULTI IMAGE
  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xFilePick = pickedFile;
    if (xFilePick.isNotEmpty) {
      for (var i = 0; i < xFilePick.length; i++) {
        addDataList.add(File(xFilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
    update();
  }

  /// PICK SINGLE IMAGE
  pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    profileImage = File(file!.path);
    update();
  }

  /// ADD NEW COMMERCIAL SERVICES DATA API
  addCommercialServicesData(
      {required Map<String, dynamic> commercialServices}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await CommercialServicesRepo.addCommercialServicesRepo(
        commercialServices: commercialServices);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Publish Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====addCommercialServicesData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// UPLOAD IMAGE API
  List imageUrl = [];

  uploadImages({required List<File> requestData}) async {
    isLoading.value = true;
    ResponseItem result;
    result =
        await CommercialServicesRepo.uploadImagesRepo(requestData: requestData);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          imageUrl = result.data;
          update();
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====addCommercialServicesData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET PINCODE DATA
  List<GetPincodeDetailsResponseModel> getPincodeDetailsResponseModel = [];

  getPinCodeData({required String pinCode}) async {
    ResponseItem result;
    result = await CommercialServicesRepo.pincodeRepo(pincode: pinCode);
    try {
      if (result.status) {
        if (result.data != null) {
          getPincodeDetailsResponseModel =
              List<GetPincodeDetailsResponseModel>.from(result.data
                  .map((x) => GetPincodeDetailsResponseModel.fromJson(x)));

          if (getPincodeDetailsResponseModel.first.postOffice!.isNotEmpty) {
            stateController.text =
                getPincodeDetailsResponseModel.first.postOffice?.first.state ??
                    "";
            cityController.text = getPincodeDetailsResponseModel
                    .first.postOffice?.first.district ??
                "";
          } else {
            getPincodeDetailsResponseModel.clear();
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetPincodeDetails====>>>>====>>>>$e');
    }
    update();
  }

  ///GET STATE DATA
  List<GetAllStateResponseModel> getAllStateResponseModel = [];

  List<String> stateList = [];

  getStateData() async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetStateData.getStateData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllStateResponseModel = List<GetAllStateResponseModel>.from(
              result.data.map((x) => GetAllStateResponseModel.fromJson(x)));
          for (var element in getAllStateResponseModel) {
            stateList.add(element.name.toString() ?? "");
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CITY DATA
  List<GetAllCityResponseModel> getAllCityResponseModel = [];
  List<String> cityList = [];

  getCityData(String id) async {
    getAllCityResponseModel.clear();
    cityList.clear();

    isLoading.value = true;
    ResponseItem result;
    result = await GetCityData.getCityData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllCityResponseModel = List<GetAllCityResponseModel>.from(
              result.data.map((x) => GetAllCityResponseModel.fromJson(x)));
          for (var element in getAllCityResponseModel) {
            cityList.add(element.name.toString() ?? "");
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET NEAR BY DATA
  List<GetAllNearByResponseModel> getAllNearByResponseModel = [];
  List<String> nearByList = [];

  getNearByData(String id) async {
    nearByList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetNearByData.getNearByData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllNearByResponseModel = List<GetAllNearByResponseModel>.from(
              result.data.map((x) => GetAllNearByResponseModel.fromJson(x)));

          for (var element in getAllNearByResponseModel) {
            nearByList.add(element.name.toString());
          }
          log("++++++++++++++>>>>>>>>>>>$nearByList");
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====GetNearByData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// ASSIGN DATA
  List<GetAllCommercialServicesResponseModel> getAllCommercialData = [];
  assignData() {
    if (getAllCommercialData.isNotEmpty) {
      saveImage(
          gadgetImageList: getAllCommercialData[0].commercialServiceImagesList);

      /// Pincode Api
      getPinCodeData(pinCode: getAllCommercialData[0].pincode ?? '');
      titleController.text = getAllCommercialData[0].title ?? '';
      stateController.text = getAllCommercialData[0].state ?? '';
      stateSelect = getAllCommercialData[0].state ?? '';
      cityController.text = getAllCommercialData[0].city ?? '';
      citySelect = getAllCommercialData[0].city ?? '';
      nearByController.text = getAllCommercialData[0].nearBy ?? '';
      nearBySelect = getAllCommercialData[0].nearBy ?? '';
      descriptionController.text = getAllCommercialData[0].discription ?? '';
      priceController.text = getAllCommercialData[0].price.toString() ?? '';
      pinCodeController.text = getAllCommercialData[0].pincode ?? '';
      nameController.text = getAllCommercialData[0].name ?? '';
      phoneController.text = getAllCommercialData[0].mobile ?? '';
    }
    update();
  }

  /// SAVE ASSIGN IMAGES
  saveImage(
      {required List<CommercialServiceImagesList>? gadgetImageList}) async {
    gadgetImageList?.forEach((element) async {
      final http.Response response =
          await http.get(Uri.parse(element.imageUrl ?? ''));
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/${element.imageUrl?.split('/').last}';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      log('---xFilePick[i].path----${file.path}');

      addDataList.add(file);
    });
    update();
  }

  /// put CommercialService
  updateCommercialServiceAllData(
      {required Map<String, dynamic> putCommercialUpdateData,
      required String id}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await UpdateCommercialServiceData.updateCommercialServiceData(
        updateData: putCommercialUpdateData, id: id);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Commercial Updated Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====updateGadgetData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    addDataList = [];
    stateController.clear();
    cityController.clear();
    nearByController.clear();
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    pinCodeController.clear();
    stateSelect = '';
    citySelect = '';
    nearBySelect = '';
    confirmLocation = 0;
  }
}
