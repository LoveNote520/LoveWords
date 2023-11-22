import 'package:cses_saas/cses_saas.dart';
import 'package:flutter/material.dart';

abstract class BaseNewLogic extends BaseLogic
    with GetTickerProviderStateMixin, SingleAudioWavePlayerMixin
    implements SingleImagePickerListener, VideoPickerListener, AudioPostListener, AttachmentPickerListener {
  late ResourcePickerHandler handler;

  Map<String, dynamic> params = {};

  late TextEditingController titleController;
  late TextEditingController contentController;

  FocusNode focusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  BaseNewLogic({bool isInitAudioPlayer = false, bool isSquare = false, bool isClip = true}) {
    handler = ResourcePickerHandler(
        isClip: isClip,
        singleListener: this,
        videoListener: this,
        isSquare: isSquare,
        audioListener: this,
        attachmentListener: this);

    titleController = TextEditingController()..addListener(update);
    contentController = TextEditingController()..addListener(update);

    if (isInitAudioPlayer) initAudioPlayer(this);
  }

  RxList<TagBean> tags = RxList<TagBean>([]);

  void removeTag(int index) {
    tags.removeAt(index);
    tags.refresh();
  }

  void updateTags(List<TagBean> tags) {
    this.tags.clear();
    this.tags.addAll(tags);
    this.tags.refresh();
  }

  Rx<ResourceBean?> picture = Rx<ResourceBean?>(null);

  @override
  Future singleImage(ResourceBean resource) async {
    picture.value = resource;
  }

  void deletePicture() {
    picture.value = null;
  }

  Rx<ResourceBean?> video = Rx<ResourceBean?>(null);

  void deleteVideo() {
    video.value = null;
  }

  @override
  Future singleVideo(ResourceBean video) async {
    this.video.value = video;
  }

  Rx<Map<String, dynamic>?> audioParams = Rx<Map<String, dynamic>?>(null);

  void deleteAudio() async {
    stop();
    audioParams.value = null;
    waveData.clear();
    waveData.refresh();
  }

  void addAudio(Map<String, dynamic> value) async {
    audioParams.value = value;
    initWaveData(value[Keys.URI]);
  }

  @override
  Future singleAudio(Map<String, dynamic> audioParams, String fileName, int? size) async {
    this.audioParams.value = {
      Keys.FILE: audioParams,
      Keys.TITLE: fileName,
      Keys.Content: "这是个音频文件",
      Keys.DURATION: (audioParams[Keys.DURATION] / 1000).floor(),
      Keys.SIZE: size
    };
  }

  @override
  Future attachment(ResourceBean resource, int size) async {}

  void delete() {
    picture.value = null;
    video.value = null;
  }
}
