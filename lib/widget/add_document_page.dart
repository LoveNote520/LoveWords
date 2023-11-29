import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddDocumentPage extends StatefulWidget {
  const AddDocumentPage({super.key});

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  late final QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加描述"),
        actions: [
          IconButton(
            onPressed: () {
              var json = jsonEncode(_controller.document.toDelta().toJson());
              print(json);
            },
            icon: const Text("确定",style: TextStyle(),),
          )
        ],
      ),
      body: SafeArea(
        child: QuillProvider(
          configurations: QuillConfigurations(
            controller: _controller,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: quillToolbar,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: quillEditor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  QuillEditor get quillEditor {
    return QuillEditor(
      configurations: QuillEditorConfigurations(
        placeholder: '添加任务的描述',
        readOnly: false,
        minHeight: 200,
        maxHeight: 400,
        autoFocus: false,
        expands: false,
        padding: EdgeInsets.zero,
        onTapOutside: (PointerDownEvent event, FocusNode focusNode) {
          // FocusScope.of(context).requestFocus();
          focusNode.unfocus();
        },
        customStyles: const DefaultStyles(
          h1: DefaultTextBlockStyle(
              TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              VerticalSpacing(16, 0),
              VerticalSpacing(0, 0),
              null),
          sizeSmall: TextStyle(fontSize: 9),
        ),
      ),
      scrollController: ScrollController(),
      focusNode: _focusNode,
    );
  }

  QuillToolbar get quillToolbar {
    return const QuillToolbar(
      configurations: QuillToolbarConfigurations(
        showBackgroundColorButton: false,
        showLeftAlignment: false,
        showCenterAlignment: false,
        showRightAlignment: false,
        showJustifyAlignment: false,
        showSearchButton: false,
        showSubscript: false,
        showSuperscript: false,
        showIndent: false,
        showQuote: false,
        showDividers: false,
        showDirection: false,
        showColorButton: false,
        showStrikeThrough: false,
        showUnderLineButton: false,
        showSmallButton: false,
        showItalicButton: false,
        showBoldButton: false,
        showFontSize: false,
        showFontFamily: false,
        toolbarIconAlignment: WrapAlignment.start,
      ),
      // afterButtonPressed: _focusNode.requestFocus,
    );
  }
}
