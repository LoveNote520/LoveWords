// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//   await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

//从左到右有A、B、C三根柱子，其中A柱子上面有从小叠到大的n个圆盘，现要求将A柱子上的圆盘移到C柱子上去
// ，期间只有一个原则：一次只能移到一个盘子且大盘子不能在小盘子上面，求移动的步骤和移动的次数

void main() {
  a(2);
}

List<int> A = [];
List<int> B = [];
List<int> C = [];

void a(int n) {
  //1-n
  A = List.generate(n, (index) => index+1);
  print(A);

}

void b(int index) {
  B.add(A[index]);
  C.add(C[index+1]);
}


//解：（1）n == 1
//
//     　第1次  1号盘  A---->C
//   sum = 1 次
//
//        (2)  n == 2
//
//        　　　　　　第1次  1号盘  A---->B
//
//       　　　　　　 第2次  2号盘  A---->C
//
//        　　　　　　第3次  1号盘  B---->C        sum = 3 次
//
// 　　（3）n == 3
//
// 　　　　　　　　第1次  1号盘  A---->C
//
// 　　　　　　　　第2次  2号盘  A---->B
//
// 　　　　　　　　第3次  1号盘  C---->B
//
// 　　　　　　　　第4次  3号盘  A---->C
//
// 　　　　　　　　第5次  1号盘  B---->A
//
// 　　　　　　　　第6次  2号盘  B---->C
//
// 　　　　　　　　第7次  1号盘  A---->C        sum = 7 次
//
//
//
// 不难发现规律：1个圆盘的次数 2的1次方减1
//
// 　　　　　　　2个圆盘的次数 2的2次方减1
//
//                          3个圆盘的次数 2的3次方减1
//
//                          。  。   。    。   。
//
//                          n个圆盘的次数 2的n次方减1


//递归实现汉诺塔的函数
  void hanoi(int n,String A,String B,String C)
{
  if(n == 1){

  }//圆盘只有一个时，只需将其从A塔移到C塔
    // TowersOfHanoi.move(1, A, C);//将编b号为1的圆盘从A移到C
  else
  {//否则
    hanoi(n - 1, A, C, B);//递归，把A塔上编号1~n-1的圆盘移到B上，以C为辅助塔
    // TowersOfHanoi.move(n, A, C);//把A塔上编号为n的圆盘移到C上
    hanoi(n - 1, B, A, C);//递归，把B塔上编号1~n-1的圆盘移到C上，以A为辅助塔
  }
}