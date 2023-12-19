class TreeNode {
  TreeNode? left;
  TreeNode? right;
  int? val;
  int depth;

  TreeNode({this.left, this.right, this.val, this.depth = 0});

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < depth; i++) {
      result += '-';
    }
    result += '$val';
    return result;
  }
}
