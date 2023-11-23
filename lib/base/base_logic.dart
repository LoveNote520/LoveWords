// import 'package:bot_toast/bot_toast.dart';
// import 'package:cses_common/cses_common.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// abstract class BaseLogic extends GetxController {
//   Rx<ViewState> pageState = ViewState.success.obs;
//
//   EasyRefreshController easyRefreshController = EasyRefreshController();
//
//   var pageNumber = 0.obs;
//   var pageSize = 20.obs;
//   var offset = 0.obs;
//
//   var keywords = ''.obs;
//
//   final _isShowLoading = false.obs;
//
//   bool get busy => pageState == ViewState.loading.obs;
//
//   bool get idle => pageState == ViewState.success.obs;
//
//   bool get empty => pageState == ViewState.empty.obs;
//
//   bool get error => pageState == ViewState.error.obs;
//
//   void setPageSize(int pageSize) {
//     this.pageSize.value = pageSize;
//   }
//
//   void showLoading() {
//     _isShowLoading.value = true;
//     BotToast.showCustomLoading(
//         crossPage: false, toastBuilder: (CancelFunc cancelFunc) => const SpinKitCircle(color: Colors.white));
//   }
//
//   void hiddenLoading() {
//     if (_isShowLoading.value) BotToast.closeAllLoading();
//     _isShowLoading.value = false;
//   }
// }
//
//
