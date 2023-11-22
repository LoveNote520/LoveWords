import 'package:cses_saas/cses_saas.dart';

abstract class BaseListLogic<T> extends BaseLogic {
  final RxList<T> list = RxList<T>([]);

  void clearKeywords() {
    keywords.value = '';
  }

  void initData() async {
    pageState.value = ViewState.loading;
    await refreshData(init: true);
  }

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<List<T>?> refreshData({bool init = false}) async {
    try {
      easyRefreshController.resetLoadState();
      pageNumber.value = 0;
      offset.value = 0;
      var data = await loadData();
      data ??= [];
      list.clear();
      if (data.isEmpty) {
        onCompleted([]);
        pageState.value = ViewState.empty;
      } else {
        list.addAll(data);
        onCompleted(data);
        list.refresh();
        // 小于分页的数量,禁止上拉加载更多
        easyRefreshController.finishLoad(noMore: data.length < pageSize.value);
        pageState.value = ViewState.success;
      }
      easyRefreshController.finishRefresh(success: true);
      hiddenLoading();
      return data;
    } catch (e) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      Log.e("错误$e=================");
      if (init) list.clear();
      list.refresh();
      easyRefreshController.finishRefresh(success: false);
      hiddenLoading();
      pageState.value = ViewState.error;
      return [];
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      easyRefreshController.resetRefreshState();
      pageNumber.value++;
      offset.value = list.length;
      var data = await loadData();
      data ??= [];
      if (data.isEmpty) {
        pageNumber.value--;
        easyRefreshController.finishLoad(noMore: true);
      } else {
        list.addAll(data);
        list.refresh();
        onCompleted(data);
        if (data.length < pageSize.value) {
          easyRefreshController.finishLoad(noMore: true);
        } else {
          easyRefreshController.finishLoad();
        }
      }
      update();
      return data;
    } catch (e) {
      pageNumber.value--;
      easyRefreshController
        ..finishLoad(success: false)
        ..resetRefreshState();
      pageState.value = ViewState.error;
      return [];
    }
  }

  void loadDataBySearch({String keywords = ''}) async {
    pageNumber.value = 0;
    this.keywords.value = keywords;
    showLoading();
    var data = await loadData();
    data ??= [];
    hiddenLoading();
    list.clear();
    list.addAll(data);
    list.refresh();
  }

  /// 加载数据
  Future<List<T>?> loadData();

  void onCompleted(List<T> data) {}

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }
}
