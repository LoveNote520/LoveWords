// import 'package:flutter/cupertino.dart';
//
// ///每个页面都有公共的状态，以及共享下context
// class BaseController extends ChangeNotifier {
//   /// 防止页面销毁后,异步任务才完成,导致报错
//   bool _disposed = false;
//
//   /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
//   ViewState _viewState;
//   ScrollController? scrollController;
//
//   ViewState get viewState => _viewState;
//
//   /// 根据状态构造
//   /// 子类可以在构造函数指定需要的页面状态
//   /// FooModel():super(viewState:ViewState.busy);
//   BaseController({ViewState? viewState}) : _viewState = viewState ?? ViewState.busy {
//     debugPrint('BaseModel---constructor--->$runtimeType');
//   }
//
//   BuildContext? context;
//
//   bool _isShowLoading = false;
//
//   ///每个页面都有 加载，错误 和正常的状态，通过model的状态来返回不同的页面
//   void setContext(BuildContext context) {
//     if (this.context == null) {
//       this.context = context;
//       initDataWithContext();
//     }
//   }
//
//   set viewState(ViewState viewState) {
//     _viewState = viewState;
//     notifyListeners();
//   }
//
//   ///通过上下文初始化数据
//   void initDataWithContext() {}
//
//   /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
//
//   bool get busy => viewState == ViewState.busy;
//
//   bool get idle => viewState == ViewState.idle;
//
//   bool get empty => viewState == ViewState.empty;
//
//   bool get error => viewState == ViewState.error;
//
//   void setIdle() {
//     viewState = ViewState.idle;
//   }
//
//   void setBusy() {
//     viewState = ViewState.busy;
//   }
//
//   void setEmpty() {
//     viewState = ViewState.empty;
//   }
//
//   void hiddenLoading() {
//     if (_isShowLoading) BotToast.closeAllLoading();
//     _isShowLoading = false;
//     notifyListeners();
//   }
//
//   /// [e]分类Error和Exception两种
//   void setError({e, stackTrace}) {
//     hiddenLoading();
//     viewState = ViewState.error;
//     printErrorStack(e: e, s: stackTrace);
//   }
//
//   /// [e]为错误类型 :可能为 Error , Exception ,String
//   /// [s]为堆栈信息
//   printErrorStack({e, s}) {
//     if (s != null) {
//       debugPrint('''
//       <-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
//       $s
//       <-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
//     ''');
//     }
//   }
//
//   @override
//   void notifyListeners() {
//     if (!_disposed) {
//       super.notifyListeners();
//     }
//   }
// }
