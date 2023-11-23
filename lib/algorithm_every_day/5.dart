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

//动态规划思想  对于一个子串而言，如果它是回文串，并且长度大于 2，那么将它首尾的两个字母去除之后，
// 它仍然是个回文串。例如对于字符串 “ababa”，
// 如果我们已经知道 “bab” 是回文串，那么 “ababa” 一定是回文串，这是因为它的首尾两个字母都是 “a”。


 String longestPalindrome(String s) {
  int len = s.length;
  if (len < 2) {
    return s;
  }

  int maxLen = 1;
  int begin = 0;
  // // dp[i][j] 表示 s[i..j] 是否是回文串
  // boolean[][] dp =  boolean[len][len];
  // 初始化：所有长度为 1 的子串都是回文串
  // for (int i = 0; i < len; i++) {
  //   dp[i][i] = true;
  // }
  //
  // char[] charArray = s.toCharArray();
  // 递推开始
  // 先枚举子串长度
  // for (int L = 2; L <= len; L++) {
  //   // 枚举左边界，左边界的上限设置可以宽松一些
  //   for (int i = 0; i < len; i++) {
  //     // 由 L 和 i 可以确定右边界，即 j - i + 1 = L 得
  //     int j = L + i - 1;
  //     // 如果右边界越界，就可以退出当前循环
  //     if (j >= len) {
  //       break;
  //     }
  //
  //     if (charArray[i] != charArray[j]) {
  //       dp[i][j] = false;
  //     } else {
  //       if (j - i < 3) {
  //         dp[i][j] = true;
  //       } else {
  //         dp[i][j] = dp[i + 1][j - 1];
  //       }
  //     }
  //
  //     // 只要 dp[i][L] == true 成立，就表示子串 s[i..L] 是回文，此时记录回文长度和起始位置
  //     if (dp[i][j] && j - i + 1 > maxLen) {
  //       maxLen = j - i + 1;
  //       begin = i;
  //     }
  //   }
  // }
  return s.substring(begin, begin + maxLen);
}


// public String longestPalindrome(String s) {
//   if (s == null || s.length() < 1) {
//     return "";
//   }
//   int start = 0, end = 0;
//   for (int i = 0; i < s.length(); i++) {
//     int len1 = expandAroundCenter(s, i, i);
//     int len2 = expandAroundCenter(s, i, i + 1);
//     int len = Math.max(len1, len2);
//     if (len > end - start) {
//       start = i - (len - 1) / 2;
//       end = i + len / 2;
//     }
//   }
//   return s.substring(start, end + 1);
// }
//
// public int expandAroundCenter(String s, int left, int right) {
//   while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
//     --left;
//     ++right;
//   }
//   return right - left - 1;
// }

