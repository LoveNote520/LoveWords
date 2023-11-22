import 'package:cses_common/cses_common.dart';
import 'package:get/get.dart';

import 'base_logic.dart';

abstract class BaseObjectLogic<T> extends BaseLogic {
  void initData() async {
    pageState.value = ViewState.loading;
    await refreshData();
  }

  Rx<T?> bean = Rx<T?>(null);

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<T?> refreshData() async {
    try {
      var res = await loadData();
      easyRefreshController.resetLoadState();
      if (res == null) {
        pageState.value = ViewState.error;
      } else {
        bean.value = res;
        onCompleted(res);
        pageState.value = ViewState.success;
      }
      easyRefreshController.finishRefresh();
      return res;
    } catch (e) {
      Log.e("$e");

      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      bean.value = null;
      pageState.value = ViewState.error;
      easyRefreshController
        ..resetLoadState()
        ..finishRefresh(success: false);
      return null;
    }
  }

  /// 加载数据
  Future<T> loadData();

  void onCompleted(T data) {}

  @override
  void onClose() {
    easyRefreshController.dispose();

    super.onClose();
  }
}
