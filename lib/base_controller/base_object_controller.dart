//
// abstract class BaseObjectBaseController<T> extends BaseController {
//   final EasyRefreshController _easyRefreshController = EasyRefreshController();
//
//   EasyRefreshController get easyRefreshController => _easyRefreshController;
//   int pageNumber = 0;
//   int pageSize = 20;
//
//   initData() async {
//     setBusy();
//     await refresh();
//   }
//
//   T? bean;
//
//   /// 下拉刷新
//   /// [init] 是否是第一次加载
//   /// true:  Error时,需要跳转页面
//   /// false: Error时,不需要跳转页面,直接给出提示
//   Future<T?> refresh() async {
//     try {
//       pageNumber = 0;
//       var res = await loadData();
//       easyRefreshController.resetLoadState();
//       if (res == null) {
//         setError();
//       } else {
//         bean = res;
//         onCompleted(res);
//         setIdle();
//       }
//       easyRefreshController.finishRefresh();
//       notifyListeners();
//       onDone(res);
//       return res;
//     } catch (e, s) {
//       /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
//       /// 而是显示之前的页面数据.给出错误提示
//       bean = null;
//       setError(e: e, stackTrace: s);
//       easyRefreshController.resetLoadState();
//       easyRefreshController.finishRefresh(success: false);
//       return null;
//     }
//   }
//
//   /// 加载数据
//   Future<T> loadData();
//
//   void onCompleted(T data) {}
//
//   void onDone(T data) {}
//
//   @override
//   void dispose() {
//     easyRefreshController.dispose();
//
//     super.dispose();
//   }
// }
