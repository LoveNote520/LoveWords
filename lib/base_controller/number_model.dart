// import 'package:flutter/cupertino.dart';
//
// class NumberModel extends ChangeNotifier {
//   ///默认手机号从缓存里拿
//   String number1 = "";
//
//   String number2 = "";
//
//   int receiveSms = 0;
//   int sendSms = 0;
//
//
//   NumberModel() {
//     number1 = SpUtil.getString(Keys.NUMBER_ONE,defValue: "")!;
//     number2 = SpUtil.getString(Keys.NUMBER_TWO,defValue: "")!;
//     receiveSms = SpUtil.getInt(Keys.RECEIVE_SMS,defValue: 0);
//     sendSms = SpUtil.getInt(Keys.SEND_SMS,defValue: 0);
//   }
//
//   ///更新手机号
//   void updateNumber({String? numberOne, String? numberTwo}) {
//     if (numberOne != null) {
//       number1 = numberOne;
//     }
//     if (numberTwo != null) {
//       number2 = numberTwo;
//     }
//     notifyListeners();
//   }
//
//   ///更新
//   void updateReceiveSms() {
//     receiveSms += 1;
//
//     SpUtil.setInt(Keys.RECEIVE_SMS, receiveSms);
//
//     notifyListeners();
//   }
//
//   ///更新
//   void updateSendSms() {
//     sendSms += 1;
//     SpUtil.setInt(Keys.SEND_SMS, sendSms);
//     notifyListeners();
//   }
// }
