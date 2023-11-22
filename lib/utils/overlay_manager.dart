import 'package:flutter/widgets.dart';

class OverlayManager {
  OverlayManager._privateConstructor(bool status);

  static final OverlayManager _instance =
  OverlayManager._privateConstructor(false);
  OverlayEntry? _entry;
  BuildContext? _context;

  //初始化单例,在根入口完成最好
  static initInstance(BuildContext context) {
    _instance._context = context;
    return _instance;
  }
  //获取单例
  static OverlayManager getInstance() {
    assert(_instance._context != null);
    return _instance;
  }

  showOverlay(bool show, {Widget widget = const Text('暂无内容')}) {
    assert(_context != null);
    if (show) {
      _entry = _handleEntry(widget);
      Overlay.of(_context!).insert(_entry!);
    } else {
      if (_entry!.mounted) {
        _entry!.remove();
      }
    }
  }

  OverlayEntry _handleEntry(Widget widget) {
    if (_entry != null) {
      if (_entry!.mounted) {
        _entry!.remove();
      }
    }
    OverlayEntry entry = OverlayEntry(builder: (context) => widget);
    return entry;
  }
}

//
// void showButtonMenu() {
//   final RenderBox button = context.findRenderObject()! as RenderBox;
//   final RenderBox overlay =
//   Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
//   final Offset offset = Offset(button.size.width / 2, button.size.height / 2);
//   final RelativeRect position = RelativeRect.fromRect(
//     Rect.fromPoints(
//       button.localToGlobal(offset, ancestor: overlay),
//       button.localToGlobal(button.size.bottomRight(Offset.zero) + offset,
//           ancestor: overlay),
//     ),
//     Offset.zero & overlay.size,
//   );
//   toly
//       .showMenu<T?>(
//     elevation: 0,
//     color: Colors.transparent,
//     context: context,
//     items: [const PopPanel()],
//     position: position,
//   )
//       .then<void>((T? newValue) {
//     if (!mounted) {
//       return null;
//     }
//     if (newValue == null) {
//       // widget.onCanceled?.call();
//       return null;
//     }
//     // widget.onSelected?.call(newValue);
//   });
//   // }
// }
