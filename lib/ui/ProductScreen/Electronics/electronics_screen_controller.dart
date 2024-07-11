import 'dart:developer';
import 'package:claxified_app/api/repo/electronics_form_repo.dart';
import 'package:claxified_app/model/product_list_model/get_all_electronics_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetElectronicsController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());

  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();
  double start = 1.00;
  double end = 1000000.00;

  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

  int selectProductDetails = 0;

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

  ///productScreen
  List<int> likedData = [];

  addFavouriteData(int index) {
    if (likedData.contains(index)) {
      likedData.remove(index);
    } else {
      likedData.add(index);
    }
    update();
  }

  /// GET ALL GADGET DATA
  List<GetAllElectronicsResponseModel> getAllElectronicsResponseModel = [];
  List<GetAllElectronicsResponseModel> electronicsFilterData = [];

  getAllElectronicsData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllElectronicsData.getAllElectronicsData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getAllElectronicsResponseModel Data
                getAllElectronicsResponseModel.add(
                    GetAllElectronicsResponseModel.fromJson(result.data[i]));

                /// Filter Data
                electronicsFilterData.add(
                    GetAllElectronicsResponseModel.fromJson(result.data[i]));
              }
            }
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message ?? 'Something went wrong');
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  setElectronicsFilter() async {
    electronicsFilterData = [];
    for (var element in getAllElectronicsResponseModel) {
      if ((element.title
              .toString()
              .toLowerCase()
              .contains(searchController.text.toString())) &&

          ///State
          (productScreenController.stateSelect.isEmpty ||
              productScreenController.stateSelect ==
                  element.state.toString()) &&

          ///City
          (productScreenController.citySelect.isEmpty ||
              productScreenController.citySelect == element.city) &&

          ///NearBy
          (productScreenController.nearBySelect.isEmpty ||
              productScreenController.nearBySelect == element.nearBy) &&

          ///Price-------------------------------------
          (element.price!.toDouble() >= start &&
              end >= element.price!.toDouble())) {
        electronicsFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    electronicsFilterData = getAllElectronicsResponseModel;
    Get.back();
    update();
  }

  clearData() {
    start = 1.00;
    end = 1000000.00;
    searchController.clear();
  }
}
