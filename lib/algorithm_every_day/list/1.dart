void main (){
   ListNode listNode = ListNode(1,ListNode(9,ListNode(9,ListNode(4))));

print(listNode);
}

class ListNode{

  int val;
  ListNode ?next;
  ListNode( [this.val =0, this.next]);



  @override
  String toString(){
    ListNode? cur = this;
    String result="";
    while (cur!=null ){
      result = result +cur.val.toString();
     if(cur.next!=null) result = "$result->";
     cur = cur.next;

    }
    return result;
  }
}


