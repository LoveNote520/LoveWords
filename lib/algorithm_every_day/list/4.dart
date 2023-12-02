import '3.dart';
//翻转链表

void main() {
  ListNode listNode = ListNode.array([1,1 ,2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6,1,1]);

  ListNode listNode1 = ListNode.array([1, 9, 9, 4, 0, 3, 8]);

  // print(findDuplicateIndexesFirst(listNode));
  // print(reversePro(listNode1));
  // print(reverseFromProMax(listNode1,2));
  print(removeElements(listNode,1));
}

/// [2023.12.01]
/// TODO: 删除链表中指定值的所有节点。
/// 输入：链表 node = [1,2,6,3,4,5,6]，val = 6;
/// 输出：[1,2,3,4,5]
///
///

ListNode? removeElements(ListNode node,int val) {
  ListNode ?cur =ListNode(0,node);
  while(cur!=null){
    cur=cur.next;
  }
  return null;
}








/// [2023.11.30]
/// TODO: 完成 findDuplicateIndexes 给定有序链表中，查询重复元素的索引。
/// 说明: 索引从 0 计数
/// 输入：链表 a = [1,2,3,3,4,4,5];
/// 输出：[3,5]
List<int> findDuplicateIndexes(
  ListNode? node,
) {
  List<int> remember = [];
  int index = 0;
  while (node != null && node.next != null) {
    index += 1;
    if (node.val == node.next!.val) {
      remember.add(index);
    }
    node = node.next;
  }

  return remember;
}

//重复元素第一个的索引
List<int> findDuplicateIndexesFirst(
  ListNode? node,
) {
  List<int> remember = [];
  ListNode? previous = ListNode(0, node);

  int index = 0;
  int? val;
  while (node != null && node.next != null) {
    val = previous?.val;
    if (node.val == node.next!.val && node.next!.val != val) {
      remember.add(index);
    }
    node = node.next;
    previous = previous?.next;
    index += 1;
  }

  return remember;
}

///翻转链表
ListNode? reverse(ListNode node) {
  ListNode? next;
  ListNode? cur = node;
  ListNode? head;
  while (cur != null) {
    next = cur.next;
    cur.next = head;
    head = cur;
    cur = next;
  }

  return node;
}


ListNode? reversePro(ListNode ?head) {
  if (head?.next == null) return head;
  ListNode ?last = reversePro(head?.next);
  head?.next?.next = head;
  head?.next = null;
  return last;
}


/// [2023.11.29]
/// TODO: 从指定的索引处，反转之后的链表节点。
/// 说明: 索引从 0 计数
/// 输入：链表 a = [1->9->9->4->0->3->2->8], index = 3;
/// 输出：链表  [1->9->9->4->8->2->3->0]
///
///
///

ListNode? reverseFrom(ListNode? node, int index) {
  int a = 0;
  a += 1;
  if (a == index) {
    while (node != null) {
      node = node.next;
    }
  }
  node?.next = reverseFrom(node.next, index);
  return node;
}

//正常
ListNode? reverseFromPro(ListNode? head, int index) {
  if (head == null || head.next == null) return head;

  ListNode dummy = ListNode();
  dummy.next = head;

  ListNode? pre = dummy;

  for (int i = 0; i < index; i++) {
    pre = pre?.next;
  }

  ListNode? cur = pre?.next;
  ListNode? next;

  while (cur != null) {
    next = cur.next;
    cur.next = next?.next;
    next?.next = pre?.next;
    pre?.next = next;
  }
  return dummy.next;
}

//递归翻转
ListNode? reverseFromProMax(ListNode? head, int index) {
  if (head == null || head.next == null) {
    return head;
  }

  if (index == 0) {
    ListNode? reversedRest = reverseFromProMax(head.next, 0);
    head.next?.next = head;
    head.next = null;
    return reversedRest;
  } else {
    ListNode? prev = reverseFromProMax(head.next, index - 1);
    head.next?.next = head;
    head.next = null;

    return prev;
  }
}
