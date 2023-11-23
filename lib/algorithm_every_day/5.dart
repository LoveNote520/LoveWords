//给你一个字符串 s，找到 s 中最长的回文子串。
//
// 如果字符串的反序与原始字符串相同，则该字符串称为回文字符串。
//
// 示例 1：
//
// 输入：s = "babad"
// 输出："bab"
// 解释："aba" 同样是符合题意的答案。
// 示例 2：
//
// 输入：s = "cbbd"
// 输出："bb"

void main() {
  ListNode node = ListNode(
      val: 4,
      next: ListNode(
          val: 3,
          next: ListNode(
              val: 2,
              next: ListNode(
                val: 1,
              ))));

  print(node.size());
  node.deleteAt(3);
  print(node.size());
}

find() {}

class ListNode {
  int val;
  ListNode? next;

  ListNode({this.val = 0, this.next});

  int size() {
    ListNode? cur = this;
    int size = 0;
    while (cur != null) {
      size += 1;
      cur = cur.next;
    }
    return size;
  }

  void deleteAt(int index) {
    if (index < 0 || index >= size()) {
      return;
    }
    ListNode? cur = this;
    for (int i = 0; i < index - 1; i++) {
      cur = cur?.next;
    }
    ListNode? del = cur?.next;
    cur?.next = del?.next;
    del = null;
  }

  // ListNode? removeNthFromEnd(ListNode head, int n) {
  //   ListNode dummy = ListNode(val: 0, next: head);
  //   int length = getLength(head);
  //   ListNode? cur = dummy; //哑节点
  //   for (int i = 1; i < length - n + 1; ++i) {
  //     cur = cur?.next;
  //   }
  //   cur?.next = cur.next?.next;
  //   ListNode? ans = dummy.next;
  //   return ans;
  // }
  //
  // int getLength(ListNode? head) {
  //   int length = 0;
  //   while (head != null) {
  //     ++length;
  //     head = head.next;
  //   }
  //   return length;
  // }




   ListNode ? removeNthFromEnd(ListNode head, int n) {
    ListNode dummy =  ListNode(val:0, next: head);
    ListNode? first = head;
    ListNode? second = dummy;
    for (int i = 0; i < n; ++i) {
      first = first?.next;
    }
    while (first != null) {
      first = first.next;
      second = second?.next;
    }
    second?.next = second.next?.next;
    ListNode ?ans = dummy.next;
    return ans;
  }

}
