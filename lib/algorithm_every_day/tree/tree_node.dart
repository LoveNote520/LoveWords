class TreeNode<T> {
  TreeNode? left;
  TreeNode? right;
  T? val;
  final String id;

  TreeNode({
    this.left,
    this.right,
    this.val,
    required this.id,
  });

  @override
  String toString() {
    return val.toString();
  }

  static TreeNode? formJson(Map<String, dynamic>? map) {
    if (map == null) {
      return TreeNode(id: '');
    }
    TreeNode node = TreeNode(id: map['id']);
    node.val = map['val'];
    if (map["left"] != null) node.left = TreeNode.formJson(map["left"]);
    if (map["right"] != null) node.right = TreeNode.formJson(map["right"]);
    return node;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "val": val,
      if (left != null) "left": left?.toJson(),
      if (right != null) "right": right?.toJson(),
    };
  }

  void set(String key, T value) {
    TreeNode node = this;
    TreeNode? target;
    target = traversal(node, key);
    target?.val = value;
  }

  TreeNode? traversal(TreeNode? node, String key) {
    print('======${node?.id}');
    if (node?.id == key) {
      return node;
    }
    if (node == null) {
      return null;
    }
    TreeNode? hit = traversal(node.left, key);
    if(hit!= null) return hit;
    hit = traversal(node.right, key);
    return hit;
  }

  void operator []=(String key, T value) {
    TreeNode node = this;
    TreeNode? target;
    target = traversal(node, key);
    target?.val = value;
  }
// void operator *(int a) {
//    val=val!*a;
// }
}
