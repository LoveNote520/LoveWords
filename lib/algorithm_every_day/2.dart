import 'dart:math';

///两数相加
//给你两个非空的链表表示两个非负的整数。它们每位数字都是按照逆序 的方式存储的，并且每个节点只能存储一位数字。
// 请你将两个数相加，并以相同形式返回一个表示和的链表。
// 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
//输入：l1 = [2,4,3], l2 = [5,6,4] 输出：[7,0,8] 解释：342 + 465 = 807.

void main() {}

class ListNode {
  int ? val;
  ListNode? next;

  ListNode( {this.val,this.next});
}

ListNode addTwoNumbers({ListNode? l1, ListNode? l2}) {
  ListNode dummy = ListNode();
  ListNode? cur = dummy;
  int carry = 0;

  while (l1 != null || l2 != null) {
    int x = l1?.val ?? 0;
    int y = l2?.val ?? 0;
    int sum = x + y + carry;
    carry = sum ~/ 10;
    cur?.next =  ListNode(val:sum % 10);
    cur = cur?.next;
    l1 = l1?.next;
    l2 = l2?.next;
  }

  if (carry > 0) {
    cur?.next =  ListNode(val: carry);
  }

  return dummy.next!;
}
