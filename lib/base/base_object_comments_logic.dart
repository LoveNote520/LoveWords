import 'package:cses_saas/cses_saas.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseObjectCommentsLogic<T> extends BaseLogic {
  String? dataId;
  DataType dataType;

  BaseObjectCommentsLogic(this.dataId, this.dataType);

  initData() async {
    pageState.value = ViewState.loading;
    refreshData(isFirst: true);
  }

  var isFirstLoading = false.obs;

  Future refreshData({bool isFirst = false}) async {
    if (isFirst) {
      isFirstLoading.value = true;
    }
    var res = await refreshObject();

    if (res != null) {
      easyRefreshController.finishRefresh(success: true);
      onCompleted(res);
      pageState.value = ViewState.success;
      await refreshList();
      isFirstLoading.value = false;
    } else {
      easyRefreshController.finishRefresh(success: false);
      if (isFirst) {
        pageState.value = ViewState.error;
      } else {
        Log.d("网络请求失败");
      }
    }
  }

  Future<T?> refreshObject() async {
    var res = await loadObjectData();
    bean.value = res;
    easyRefreshController.resetLoadState();
    return bean.value;
  }

  RxList<CommentBean> list = RxList<CommentBean>([]);

  Rx<T?> bean = Rx<T?>(null);

  Future<List<CommentBean>> refreshList() async {
    offset.value = 0;
    var data = await loadListData();
    easyRefreshController.finishRefresh();
    list.clear();
    list.addAll(data);
    offset.value = list.length;
    list.refresh();

    /// 完成加载、没有数据了
    easyRefreshController.finishLoad(success: true, noMore: data.length < pageSize.value);
    return list;
  }

  /// 上拉加载更多
  Future<List<CommentBean>> loadMore() async {
    try {
      var data = await loadListData();
      if (data.isEmpty) {
        easyRefreshController.finishLoad(success: true, noMore: true);
      } else {
        list.addAll(data);
        list.refresh();
        offset.value = list.length;
        if (data.length < pageSize.value) {
          easyRefreshController.finishLoad(success: true, noMore: true);
        } else {
          easyRefreshController.finishLoad();
        }
      }
      return data;
    } catch (e) {
      easyRefreshController.finishLoad(success: false);
      return [];
    }
  }

  Future<T?> loadObjectData();

  Future<List<CommentBean>> loadListData();

  void onCompleted(T? data) {}

  /// 提交评价
  Future<bool> submitComment(String comment) async {
    Map<String, dynamic> params = {};
    params[Keys.Content] = comment;
    params[Keys.DATA_ID] = dataId;
    params[Keys.DATA_TYPE] = EnumToString.parse(dataType);
    showLoading();
    CommentBean result = await CommonRepository.commitComment(params);
    hiddenLoading();
    if (result.isSuccess) {
      list.insert(0, result);
      list.refresh();
      pageState.value = ViewState.success;
      return true;
    } else {
      showToast(text: "评论失败");
      return false;
    }
  }

  /// 回复评价
  Future replyComment(String comment, String? parentId, String? replyId, int index) async {
    Map<String, dynamic> params = {};
    params[Keys.Content] = comment;
    params[Keys.DATA_ID] = dataId;
    params[Keys.DATA_TYPE] = EnumToString.parse(dataType);
    params[Keys.PARENT_ID] = parentId;
    params[Keys.TO_ID] = replyId;
    params["replyId"] = replyId; // todo
    showLoading();
    CommentBean result = await CommonRepository.replyComment(params);
    hiddenLoading();
    if (result.isSuccess) {
      if (parentId == replyId) {
        list[index].lastReply = CommentBean(
            lastReplyId: result.id,
            lastReplyContent: result.content,
            lastReplyUserId: result.userId,
            lastReplyUserName: result.userName);
      }
      list[index].replyCount = list[index].replyCount + 1;
      list.refresh();
    } else {
      showToast(text: "评论失败");
    }
  }

  /// 赞成或取消赞成评论
  ///
  /// [id] 评论ID
  /// [index] 父评论的下标
  /// [replyIndex] 回复评论的下标
  /// [opinion] 观点,none 为取消，approval表示赞成
  ///
  Future likeComment(String? id, int index, CommentOperationType opinion) async {
    showLoading();
    BaseBean result = await CommonRepository.updateCommentOpinion(id, opinion);
    hiddenLoading();
    if (result.isSuccess) {
      if (opinion == CommentOperationType.none) {
        list[index].approvalCount = list[index].approvalCount - 1;
      } else {
        list[index].approvalCount = list[index].approvalCount + 1;
      }
      list[index].opinion = opinion;
      list.refresh();
    } else {
      showToast(text: result.message!);
    }
  }

  /// 删除评论（replyIndex 不等于-1时则表示删除的为当前用户回复的评论）
  ///
  /// [id] 评论ID
  /// [index] 父评论的下标
  ///
  Future deleteComment(String? id, int index) async {
    showLoading();
    return CommonRepository.deleteComment(id, dataId, dataType).then((res) {
      hiddenLoading();
      if (res.isSuccess) {
        list.removeAt(index);
        list.refresh();
        eventBus.fire(DeleteCommentEvent(dataId, dataType));
      } else {
        showToast(text: res.message ?? "");
      }
    }).catchError((error) {
      showToast(text: "删除失败");
    });
  }

  /// 更新点赞状态
  ///
  /// [id] 要点赞的评论的ID
  /// [index]  主评论下标
  /// [isCancel] 是否取消点赞
  ///
  Future toggleLikeState(String? id, int index, bool isCancel) async {
    showLoading();
    BaseBean result = await CommonRepository.like(dataId: id, isCancel: isCancel, dataType: DataType.comment);
    hiddenLoading();
    if (result.isSuccess) {
      /// 将状态改为相反的状态
      list[index].behavior!.isLike = !isCancel;
      if (list[index].behavior!.isLike) {
        /// 点赞数+1
        list[index].behavior!.likeCount = list[index].behavior!.likeCount + 1;
      } else {
        /// 点赞数-1
        list[index].behavior!.likeCount = list[index].behavior!.likeCount - 1;
      }
      list.refresh();
    } else {
      showToast(text: result.message ?? "");
    }
  }

  /// 更多操作弹窗
  ///
  /// [context] 上下文
  /// [index] 主评论下标
  /// [comment] 评论对象
  /// [isMyself] 是否为评论的发布者
  /// [isMyTopic] 是否为帖子作者
  ///
  void showOperationDialog(BuildContext context, int index, CommentBean comment,
      {bool isMyself = false, bool isMyTopic = false}) {
    List<TypeBean> commentOperationList = [];

    /// 如果评论的资源是问答则显示的是采纳和取消采纳，如果是其他类型则显示的为赞成或取消赞成
    if (comment.opinion == CommentOperationType.none) {
      commentOperationList.add(TypeBean<CommentOperationType>(
          name: comment.approvalCount > 0 ? '赞成(${comment.approvalCount})' : '赞成',
          type: CommentOperationType.approval));
    }
    if (comment.opinion == CommentOperationType.approval) {
      commentOperationList
          .add(TypeBean<CommentOperationType>(name: '取消赞成(${comment.approvalCount})', type: CommentOperationType.none));
    }
    if (StringUtil.isNotEmpty(comment.content)) {
      commentOperationList.add(TypeBean<CommentOperationType>(name: "复制", type: CommentOperationType.copy));
    }

    /// 帖子的作者或者评论的作者均可删除评论
    if (isMyself || isMyTopic)
      commentOperationList.add(TypeBean<CommentOperationType>(name: "删除", type: CommentOperationType.delete));

    /// 非评论的发布者才可以举报
    if (!isMyself) {
      commentOperationList.add(TypeBean<CommentOperationType>(name: "举报该用户", type: CommentOperationType.report));
      commentOperationList.add(TypeBean<CommentOperationType>(name: "举报该评论", type: CommentOperationType.report));
    }

    if (commentOperationList.isNotEmpty) {
      showChoiceTypeBottomSheet(commentOperationList).then((value) {
        if (value != null)
          performOperation(commentOperationList[value].type, index, comment.id,
              userId: comment.userId, content: comment.content);
      });
    }
  }

  Future performOperation(CommentOperationType type, int index, String? id,
      {String? userId, String? content = ""}) async {
    if (type == CommentOperationType.delete) deleteComment(id, index);
    if (type == CommentOperationType.approval || type == CommentOperationType.none) {
      likeComment(id, index, type);
    }
    if (type == CommentOperationType.report) {
      NavigatorUtil.goSubmitReportPage(title: "举报评论", dataType: DataType.comment, dataId: id, userId: userId);
    }
    if (type == CommentOperationType.copy) StringUtil.copyToClipboard(content ?? "");
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }
}
