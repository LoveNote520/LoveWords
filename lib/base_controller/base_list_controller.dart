//
// abstract class BaseListController<T> extends BaseController {
//   int pageNumber = 0;
//   int pageSize = 20;
//   int offset = 0;
//
//   String keywords = '';
//
//   List<T> list = [];
//   List<T> selectedList = [];
//
//   void clearKeywords() {
//     keywords = '';
//   }
//
//   ///刷新插件的控制器来控制刷新完成的状态的
//   EasyRefreshController easyRefreshController = EasyRefreshController();
//
//   ///初始化数据把页面状态设置成busy
//   initData() async {
//     setBusy();
//     await refresh(init: true);
//   }
//
//   ///最开始加载数据
//   Future<List<T>?> loadData();
//
//   ///加载完成
//   void onCompleted(List<T> data) {}
//
//   /// 下拉刷新
//   /// [init] 是否是第一次加载
//   /// true:  Error时,需要跳转页面
//   /// false: Error时,不需要跳转页面,直接给出提示
//   /// 上拉加载更多
//   ///
//   bool isLoadMore = false;
//
//   Future<List<T>> loadMore() async {
//     isLoadMore = true;
//     try {
//       easyRefreshController.resetRefreshState();
//       pageNumber++;
//       offset = list.length;
//       var data = await loadData();
//       data ??= [];
//       if (data.isEmpty) {
//         pageNumber--;
//         easyRefreshController.finishLoad(noMore: true);
//       } else {
//         list.addAll(data);
//         onCompleted(data);
//         if (data.length < pageSize) {
//           easyRefreshController.finishLoad(noMore: true);
//         } else {
//           easyRefreshController.finishLoad();
//         }
//       }
//       isLoadMore = false;
//       notifyListeners();
//       return data;
//     } catch (e, s) {
//       isLoadMore = false;
//       pageNumber--;
//       easyRefreshController.finishLoad(success: false);
//       easyRefreshController.resetRefreshState();
//       setError(e: e, stackTrace: s);
//       return [];
//     }
//   }
//
//   Future<List<T>?> refresh({bool init = false}) async {
//     try {
//       easyRefreshController.resetLoadState();
//       pageNumber = 0;
//       offset = 0;
//       var data = await loadData();
//       data ??= [];
//       list.clear();
//       if (data.isEmpty) {
//         onCompleted(data);
//         setEmpty();
//       } else {
//         list.addAll(data);
//         // 小于分页的数量,禁止上拉加载更多
//         //noMore为true不允许加载了
//         easyRefreshController.finishLoad(noMore: data.length < pageSize);
//         onCompleted(data);
//         setIdle();
//       }
//       easyRefreshController.finishRefresh(success: true);
//       notifyListeners();
//       return data;
//     } catch (e, s) {
//       /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
//       /// 而是显示之前的页面数据.给出错误提示
//       /// 为什么判断是不是第一次 因为如果不是第一次在报错时候要显示之前的数据
//       if (init) list.clear();
//       easyRefreshController.finishRefresh(success: false);
//       setError(e: e, stackTrace: s);
//       return [];
//     }
//   }
//
//   Future<List<T>?> reLoadData() async {
//     try {
//       var data = await loadData();
//       data ??= [];
//       if (data.isEmpty) {
//         list.clear();
//         setEmpty();
//       } else {
//         list.clear();
//         list.addAll(data);
//         onCompleted(data);
//         setIdle();
//       }
//       return data;
//     } catch (e, s) {
//       setError(e: e, stackTrace: s);
//       return null;
//     }
//   }
//
//   @override
//   void dispose() {
//     easyRefreshController.dispose();
//     super.dispose();
//   }
// }
