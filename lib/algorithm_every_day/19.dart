// 删除链表的倒数第 N 个结点
// 双指针 快慢指针

import 'package:counter/algorithm_every_day/link_list_test.dart';

List<int> numberList = [1, 2, 5, 3, 4, 5, 6, 7, 8, 9, 10];

void main() {
  LinkedNode<int>? node = buildNode(numberList);
  print(deleteNode(node, 3));
}

LinkedNode<int>? buildNode(List<int> list) {
  LinkedNode<int>? node;

  for (var element in list) {
    if (node != null) {
      LinkedNode<int>? current = node;
      while(current?.next != null) {
        current = current?.next;
      }
      current?.next = LinkedNode<int>(value: element);
    } else {
      node = LinkedNode<int>(value: element);
    }
  }

  return node;
}

//倒数第多少个数
LinkedNode<int>? deleteNode(LinkedNode<int> ?node, int value) {
  LinkedNode<int>? fast = node;
  LinkedNode<int>? slow = node;

  for (int i = 0; i < value; i++) {
    fast = fast?.next;
  }

  while (fast?.next != null) {
    slow = slow?.next;
    fast = fast?.next;
  }
  slow?.next = slow.next?.next;

  return node;
}
