class TreeNode<T> {
  TreeNode? left;
  TreeNode? right;
  T? val;

  TreeNode({this.left, this.right, this.val, });

  @override
  String toString() {
    return val.toString();
  }
}
