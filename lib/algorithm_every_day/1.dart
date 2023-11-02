//给定一个整数数组 nums 和一个整数目标值 target，
// 请你在该数组中找出 和为目标值 target 的那两个整数，并返回它们的数组下标。
// 你可以假设每种输入只会对应一个答案。但是数组中同一个元素在答案里不能重复出现。
// 你可以按任意顺序返回答案。
//
// 示例 1：
//
// 输入：nums = [2,7,11,15], target = 9
// 输出：[0,1]
import 'dart:math';
///两数之和
void main() {
  two2Sum(random(), Random().nextInt(15));
}

void twoSum(List<int> list, int target) {
  print("$target");
  for (int i = 0; i < list.length; i++) {
    for (int j = 0; j < list.length; j++) {
      if (list[i] == target - list[j]) {
        print("${list[i]}  === ${list[j]}");
        print("下标$i  === 下标$j}");
        return;
      }
    }
  }
}

void two2Sum(List<int> list, int target) {
  print("$target");
  Map<int, int> map = {};
  // map[10]=10;
  for (int i = 0; i < list.length; i++) {
    if (i == 0) {
      map[i] = list[i];
    } else {
      map[i] = list[i];
      if (map.containsValue(target - list[i])) {
        map.forEach((key, value) {
         if( ( target - list[i])==value){
           print(" $key==========");
         }
        });
        print(" $i==========");

        break;
      }
    }
  }
  print(map.toString());
}

List<int> random() {
  List<int> list = [];
  for (int i = 0; i <= 10; i++) {
    list.add(Random().nextInt(10) + 1);
  }
  print(list);
  return list;
}
