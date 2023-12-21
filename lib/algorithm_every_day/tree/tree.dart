// import 'package:counter/algorithm_every_day/tree/tree_node.dart';
//
// enum TreeNodeType {
//   root,
//   left,
//   right,
// }
//
// void main() {
//   Tree tree = Tree();
//   TreeNode root = TreeNode(val: 1,depth: 0 );
//   TreeNode left1 = TreeNode(val: 9,depth: 1 );
//   TreeNode right1 = TreeNode(val: 9,depth: 1 );
//   TreeNode left2 = TreeNode(val: 4,depth: 2 );
//   TreeNode right2 = TreeNode(val: 0,depth: 2 );
//   TreeNode left3 = TreeNode(val: 3,depth: 2 );
//   TreeNode right3 = TreeNode(val: 2,depth: 2 );
//
//   tree.addNode(root, TreeNodeType.root);
//   tree.addNode(right1, TreeNodeType.right);
//   tree.addNode(left1, TreeNodeType.left);
//
// }
//
// class Tree {
//   TreeNode? _root;
//
//   Tree();
//
//   void addNode(TreeNode ?node, TreeNodeType type) {
//     switch (type) {
//       case TreeNodeType.root:
//         _root = node;
//         break;
//       case TreeNodeType.left:
//         _root?.left = node;
//         break;
//       case TreeNodeType.right:
//         _root?.right = node;
//       default:
//         return;
//     }
//   }
//
//   TreeNode? getNode() {
//     return _root;
//   }
// }

import 'package:counter/algorithm_every_day/tree/tree_node.dart';

enum TreeNodeType {
  root,
  left,
  right,
}

void main() {
  Tree tree = Tree();
  TreeNode root = TreeNode(val: 1, );
  TreeNode left1 = TreeNode(val: 9, );
  TreeNode right1 = TreeNode(val: 9, );
  TreeNode left2 = TreeNode(val: 4, );
  TreeNode right2 = TreeNode(val: 0, );
  TreeNode left3 = TreeNode(val: 3, );
  TreeNode right3 = TreeNode(val: 2, );

  tree.addNode(root, TreeNodeType.root);
  tree.addNode(right1, TreeNodeType.right, parent: root);
  tree.addNode(left1, TreeNodeType.left, parent: root);
  tree.addNode(left2, TreeNodeType.left, parent: left1);
  tree.addNode(right2, TreeNodeType.right, parent: left1);
  tree.addNode(left3, TreeNodeType.left, parent: right1);
  tree.addNode(right3, TreeNodeType.right, parent: right1);

  // Print the tree
  // print(tree.getNode());
  tree.printTree();
}

class Tree {
  TreeNode? _root;

  Tree();

  void addNode(TreeNode? node, TreeNodeType type, {TreeNode? parent}) {
    if (parent == null) {
      _root = node;
    } else {
      switch (type) {
        case TreeNodeType.left:
          parent.left = node;
          break;
        case TreeNodeType.right:
          parent.right = node;
          break;
        default:
          break;
      }
    }
  }

  TreeNode? getNode() {
    return _root;
  }

  void printTree() {
    printTreeNode(_root, 0);
  }

  void printTreeNode(TreeNode? node, int depth) {
    if (node == null) {
      return;
    }
    print('${node.val} (Depth: $depth)');
    printTreeNode(node.right, depth + 1);
    printTreeNode(node.left, depth + 1);
  }
}
