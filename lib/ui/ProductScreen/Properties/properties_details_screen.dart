import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/product_list_model/get_property_response_model.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_wishlist_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Properties/properties_screen_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertiesDetailScree extends StatefulWidget {
  const PropertiesDetailScree({super.key});

  @override
  State<PropertiesDetailScree> createState() => _PropertiesDetailScreeState();
}

class _PropertiesDetailScreeState extends State<PropertiesDetailScree> {
  GetPropertiesController getPropertiesController =
      Get.put(GetPropertiesController());

  GetAllPropertyResponseModel? productData;

  SubCategoryResponseModel? selectedData;
  MyWishListController myWishListController = Get.put(MyWishListController());

  @override
  void initState() {
    productData = Get.arguments['product'];
    selectedData = Get.arguments['subcategory'];
    detailsScreen();
    super.initState();
  }

  List<Map<String, dynamic>> details = [];

  Future detailsScreen() async {
    if (selectedData?.subCategoryName == 'For Sale: Houses & Apartments') {
      details = [
        {
          'title': 'HouseType',
          'value': productData?.houseType == 0
              ? "ApartMent"
              : productData?.houseType == 1
                  ? "BuilderFloor"
                  : productData?.houseType == 2
                      ? "FarmHouses"
                      : "HousesVilas"
        },
        {'title': 'Bathrooms', 'value': productData?.bathrooms},
        {
          'title': 'ConstructionStatus',
          'value': productData?.constructionStatus == 0
              ? "NewLaunch"
              : productData?.constructionStatus == 1
                  ? "ReadyToMove"
                  : "UnderConstruction"
        },
        {
          'title': 'SuperBuildUpArea',
          'value': "${productData?.superBuildUpArea}"
        },
        {
          'title': 'MaintenanceCharge',
          'value': "${productData?.maintenanceCharge}"
        },
        {'title': 'FloorNumber', 'value': "${productData?.floorNumber}"},
        {
          'title': 'FacingType',
          'value': productData?.facingType == 0
              ? "East"
              : productData?.facingType == 1
                  ? "North"
                  : productData?.facingType == 2
                      ? "NorthEast"
                      : productData?.facingType == 3
                          ? "NorthWest"
                          : productData?.facingType == 4
                              ? "South"
                              : productData?.facingType == 5
                                  ? "SouthEast"
                                  : productData?.facingType == 6
                                      ? "SouthWest"
                                      : "West"
        },
        {'title': 'Bedrooms', 'value': "${productData?.bedrooms}"},
        {
          'title': 'FurnishingStatus',
          'value': productData?.furnishingStatus == 0
              ? "Furnished"
              : productData?.furnishingStatus == 1
                  ? "SemiFurnished"
                  : "UnFurnished"
        },
        {
          'title': 'ListedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
        {'title': 'CarpetArea', 'value': "${productData?.carpetArea}"},
        {'title': 'TotalFloors', 'value': "${productData?.totalFloors}"},
        {'title': 'CarParking', 'value': "${productData?.carParking}"},
        {'title': 'ProjectName', 'value': "${productData?.projectName}"},
      ];
    } else if (selectedData?.subCategoryName ==
        'For Rent: Houses & Apartments') {
      details = [
        {
          'title': 'HouseType',
          'value': productData?.houseType == 0
              ? "ApartMent"
              : productData?.houseType == 1
                  ? "BuilderFloor"
                  : productData?.houseType == 2
                      ? "FarmHouses"
                      : "HousesVilas"
        },
        {'title': 'Bathrooms', 'value': "${productData?.bathrooms}"},
        {
          'title': 'ConstructionStatus',
          'value': productData?.constructionStatus == 0
              ? "NewLaunch"
              : productData?.constructionStatus == 1
                  ? "ReadyToMove"
                  : "UnderConstruction"
        },
        {
          'title': 'SuperBuildUpArea',
          'value': "${productData?.superBuildUpArea}"
        },
        {
          'title': 'MaintenanceCharge',
          'value': "${productData?.maintenanceCharge}"
        },
        {'title': 'FloorNumber', 'value': "${productData?.floorNumber}"},
        {
          'title': 'FacingType',
          'value': productData?.facingType == 0
              ? "East"
              : productData?.facingType == 1
                  ? "North"
                  : productData?.facingType == 2
                      ? "NorthEast"
                      : productData?.facingType == 3
                          ? "NorthWest"
                          : productData?.facingType == 4
                              ? "South"
                              : productData?.facingType == 5
                                  ? "SouthEast"
                                  : productData?.facingType == 6
                                      ? "SouthWest"
                                      : "West"
        },
        {'title': 'Bedrooms', 'value': "${productData?.bedrooms}"},
        {
          'title': 'FurnishingStatus',
          'value': productData?.furnishingStatus == 0
              ? "Furnished"
              : productData?.furnishingStatus == 1
                  ? "SemiFurnished"
                  : "UnFurnished"
        },
        {
          'title': 'ListedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
        {
          'title': 'BachelorAllowed',
          'value': "${productData?.bachelorAllowed}"
        },
        {'title': 'CarpetArea', 'value': "${productData?.carpetArea}"},
        {'title': 'TotalFloors', 'value': "${productData?.totalFloors}"},
        {'title': 'CarParking', 'value': "${productData?.carParking}"},
        {'title': 'ProjectName', 'value': "${productData?.projectName}"},
      ];
    } else if (selectedData?.subCategoryName == 'Lands & Plot') {
      details = [
        {
          'title': 'serviceType',
          'value': productData?.serviceType == 0
              ? "ForSale"
              : productData?.serviceType == 1
                  ? "ForRent"
                  : "ForLease"
        },
        {
          'title': 'FacingType',
          'value': productData?.facingType == 0
              ? "East"
              : productData?.facingType == 1
                  ? "North"
                  : productData?.facingType == 2
                      ? "NorthEast"
                      : productData?.facingType == 3
                          ? "NorthWest"
                          : productData?.facingType == 4
                              ? "South"
                              : productData?.facingType == 5
                                  ? "SouthEast"
                                  : productData?.facingType == 6
                                      ? "SouthWest"
                                      : "West"
        },
        {'title': 'plotArea', 'value': "${productData?.plotArea}"},
        {'title': 'breadth', 'value': "${productData?.breadth}"},
        {
          'title': 'ListedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
        {'title': 'ProjectName', 'value': "${productData?.projectName}"},
        {'title': 'lenght', 'value': "${productData?.lenght}"},
      ];
    } else if (selectedData?.subCategoryName == 'For Rent: Shop & Offices') {
      details = [
        {'title': 'bathrooms', 'value': "${productData?.bathrooms}"},
        {
          'title': 'listedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
        {'title': 'carpetArea', 'value': "${productData?.carpetArea}"},
        {
          'title': 'furnishingStatus',
          'value': productData?.furnishingStatus == 0
              ? "Furnished"
              : productData?.furnishingStatus == 1
                  ? "SemiFurnished"
                  : "UnFurnished"
        },
        {
          'title': 'superBuildUpArea',
          'value': "${productData?.superBuildUpArea}"
        },
        {
          'title': 'maintenanceCharge',
          'value': "${productData?.maintenanceCharge}"
        },
        {'title': 'projectName', 'value': "${productData?.projectName}"},
      ];
    } else if (selectedData?.subCategoryName == 'For Sale: Shops & Offices') {
      details = [
        {'title': 'bathrooms', 'value': "${productData?.bathrooms}"},
        {
          'title': 'constructionStatus',
          'value': productData?.constructionStatus == 0
              ? "NewLaunch"
              : productData?.constructionStatus == 1
                  ? "ReadyToMove"
                  : "UnderConstruction"
        },
        {'title': 'carpetArea', 'value': "${productData?.carpetArea}"},
        {'title': 'carParking', 'value': "${productData?.carParking}"},
        {
          'title': 'furnishingStatus',
          'value': productData?.furnishingStatus == 0
              ? "Furnished"
              : productData?.furnishingStatus == 1
                  ? "SemiFurnished"
                  : "UnFurnished"
        },
        {
          'title': 'listedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
        {
          'title': 'maintenanceCharge',
          'value': "${productData?.maintenanceCharge}"
        },
        {'title': 'projectName', 'value': "${productData?.projectName}"},
      ];
    } else if (selectedData?.subCategoryName == 'PG & Guest Houses') {
      details = [
        {
          'title': 'furnishingStatus',
          'value': productData?.furnishingStatus == 0
              ? "Furnished"
              : productData?.furnishingStatus == 1
                  ? "SemiFurnished"
                  : "UnFurnished"
        },
        {'title': 'carParking', 'value': "${productData?.carParking}"},
        {
          'title': 'listedBy',
          'value': productData?.listedBy == 0
              ? "Builder"
              : productData?.listedBy == 1
                  ? "Dealer"
                  : "Owner"
        },
      ];
    } else {
      details = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    log('property data -------');
    String formattedTime =
        DateFormat.yMd().format(DateTime.parse(productData?.createdOn ?? ''));

    final stateCode = stateAbbreviation('${productData?.state}');

    /// Properties Detail

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return AppContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            h: h,
            w: w,
            title: '',
            action: const Icon(
              Icons.share,
              color: whiteColor,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<GetPropertiesController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (h * 0.02).addHSpace(),
                    CarouselSlider.builder(
                      itemCount: productData?.propertyImageList?.length ?? 1,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return cachedNetworkImage(
                            url: productData
                                    ?.propertyImageList?[index].imageUrl ??
                                '',
                            height: h * 0.1);
                      },
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            controller.updateData(index);
                          },
                          autoPlay: false,
                          reverse: productData?.propertyImageList?.length == 0
                              ? true
                              : false,
                          clipBehavior: Clip.none,
                          viewportFraction: 1,
                          height: h * 0.4,
                          aspectRatio: 1,
                          pageSnapping: true),
                    ),
                    (h * 0.02).addHSpace(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: 7,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          productData?.propertyImageList?.length ?? 1,
                          (index) => Container(
                            height: h * 0.006,
                            width: h * 0.017,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: controller.selectProductDetails == index
                                    ? appColor
                                    : Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.02, bottom: h * 0.0011),
                                  child: "${productData?.title}"
                                      .boldMontserratTextStyle(
                                          fontSize: 18,
                                          maxLine: 5,
                                          textOverflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    controller.selectLikeData();
                                    Map<String, dynamic> wishListData = {
                                      "id": 0,
                                      "productId": productData?.tableRefGuid,
                                      "categoryId": productData?.categoryId,
                                      "createdBy": preferences
                                          .getInt(SharedPreference.userId),
                                      "createdOn":
                                          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                                              .format(DateTime.now()),
                                    };
                                    await myWishListController.addWishListData(
                                        wishListData: wishListData);
                                  },
                                  child: Container(
                                    height: h * 0.047,
                                    width: h * 0.047,
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ], shape: BoxShape.circle, color: appColor),
                                    child: Center(
                                      child: controller.likeSelect
                                          ? const Icon(
                                              Icons.favorite,
                                              color: secondaryAppColor,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: whiteColor,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          (h * 0.002).addHSpace(),
                          '₹ ${productData?.price}'
                              .semiBoldMontserratTextStyle(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.011),
                            child: const Divider(thickness: 1),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: h * 0.013, horizontal: w * 0.04),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: appColor,
                                      ),
                                      (w * 0.02).addWSpace(),
                                      AppString.postingDate
                                          .regularMontserratTextStyle(
                                              fontSize: 15),
                                      const Spacer(),
                                      (w * 0.02).addWSpace(),
                                      formattedTime.semiBoldMontserratTextStyle(
                                          fontSize: 15)
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: h * 0.035,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: appColor,
                                      ),
                                      (w * 0.02).addWSpace(),
                                      AppString.locationCap
                                          .regularMontserratTextStyle(
                                              fontSize: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: w * 0.52,
                                            child: "${productData?.nearBy}"
                                                .regularMontserratTextStyle(
                                                    textAlign: TextAlign.right,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    maxLine: 4,
                                                    fontSize: 15),
                                          ),
                                          (h * 0.003).addHSpace(),
                                          SizedBox(
                                            width: w * 0.52,
                                            child:
                                                "${productData?.city}($stateCode)"
                                                    .semiBoldMontserratTextStyle(
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        maxLine: 4,
                                                        textAlign:
                                                            TextAlign.right,
                                                        fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.011),
                            child: AppString.details
                                .semiBoldMontserratTextStyle(fontSize: 19),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: details.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: h * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        "${details[index]['title']}"
                                            .w500MontserratTextStyle(),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${details[index]['value']}"
                                            .w500MontserratTextStyle(),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.011),
                            child: AppString.descriptions
                                .semiBoldMontserratTextStyle(fontSize: 19),
                          ),
                          "${productData?.discription}"
                              .regularMontserratTextStyle(fontSize: 15),
                          (h * 0.02).addHSpace(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Padding(
            padding: EdgeInsets.only(
                top: h * 0.009,
                left: w * 0.15,
                right: w * 0.15,
                bottom: h * 0.002),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   flex: 1,
                //   child: AppFilledButton(
                //     radius: 6,
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const Icon(
                //           CupertinoIcons.chat_bubble,
                //           color: whiteColor,
                //           size: 22,
                //         ),
                //         Padding(
                //           padding: EdgeInsets.only(left: w * 0.019),
                //           child: AppString.chatText.semiBoldMontserratTextStyle(
                //               fontColor: whiteColor, fontSize: 17),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // (w * 0.035).addWSpace(),
                Expanded(
                  flex: 1,
                  child: AppFilledButton(
                    radius: 6,
                    onPressed: () async {
                      String phoneNumber = '+91${productData?.mobile ?? ''}';
                      final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch ${uri.toString()}';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.call,
                          size: 22,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.019),
                          child: AppString.callText.semiBoldMontserratTextStyle(
                              fontColor: whiteColor, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}