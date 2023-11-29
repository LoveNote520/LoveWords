import 'list/3.dart';

///合并两个升序链表并返回
///

void main() {
  ListNode listNode1 = ListNode.array([1, 2, 4, 5, 7, 8, 9]);
  ListNode listNode2 = ListNode.array([1, 3, 4, 6, 7, 9,]);
  print(mergeTwoLists(listNode1, listNode2));
  // print(addNodeAfter(listNode1, 3, 5));
  // print(recursiveTraversal(listNode1));
}

ListNode? mergeTwoLists(ListNode list1, ListNode list2) {
  ListNode? newListNode = ListNode(
    0,
  );
  ListNode? pev = newListNode;
  ListNode? cur = list1;
  ListNode? pre = list2;
  while (cur != null && pre != null) {
    if (cur.val <= pre.val) {
      pev?.next = cur;
      pev = pev?.next;
      cur = cur.next;
    } else {
      pev?.next = pre;
      pev = pev?.next;
      pre = pre.next;
    }
  }
  if (cur != null) {
    pev?.next = cur;
  }
  if (pre != null) {
    pev?.next = pre;
  }
  return newListNode.next;
}
//递归

ListNode? mergeTwoListsPro(ListNode? list1, ListNode? list2) {
  if (list1 == null) {
    return list2;
  }
  if (list2 == null) {
    return list1;
  }
  //对比当前节点谁小返回谁
  if (list1.val < list2.val) {
    list1.next = mergeTwoListsPro(list1.next, list2);
    return list1;
  } else {
    list2.next = mergeTwoListsPro(list1, list2.next);
    return list2;
  }
}

//递归遍历链表
ListNode? recursiveTraversal(ListNode? node) {
  if (node == null) {
    return null;
  }
  node.next = recursiveTraversal(node.next);
  return node;
}

ListNode? addNodeAfter(ListNode? node, int target, int value) {
  if (node == null) return ListNode(value);
  if (node.val == target) {
    ListNode newNode = ListNode(value);
    newNode.next = node.next;
    node.next = newNode;
    return node;
  }
  node.next = addNodeAfter(node.next, target, value);
  return node;
}
