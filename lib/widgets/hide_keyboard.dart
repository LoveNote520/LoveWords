import 'package:flutter/cupertino.dart';

class HideKeyboard extends StatelessWidget {
  final Widget child;

  const HideKeyboard({ Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior:HitTestBehavior.opaque,
      child: child,
      onTap: () {
        hideKeyboard(context);
      },
    );
  }
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
