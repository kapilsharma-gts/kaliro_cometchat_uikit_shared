import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///[CometChatEmailFormatter] is a class which is used to style the email text
/// ```dart
/// CometChatEmailFormatter(
///    pattern: RegExp(RegexConstants.emailRegexPattern),
///    onSearch: (email) async {
///    await launchUrl(Uri.parse(('mailto:$email')));
///    },
///    messageBubbleTextStyle: (theme, alignment,{forConversation}) {
///    return TextStyle(
///    color: Colors.pink,
///    );
///    },
///    );
///    ```
class CometChatEmailFormatter extends CometChatTextFormatter {
  CometChatEmailFormatter({
    String? trackingCharacter,
    RegExp? pattern,
    super.showLoadingIndicator,
    super.onSearch,
    super.messageBubbleTextStyle,
    super.messageInputTextStyle,
    super.theme,
    super.message,
    super.composerId,
    super.suggestionListEventSink,
    super.previousTextEventSink,
    super.user,
    super.group,
  }) : super(
          trackingCharacter: null,
          pattern: pattern ?? RegExp(RegexConstants.emailRegexPattern),
        ) {
    pattern ??= RegExp(RegexConstants.emailRegexPattern);
  }

  @override
  void init() {
    pattern ??= RegExp(RegexConstants.emailRegexPattern);
  }

  @override
  void handlePreMessageSend(BuildContext context, BaseMessage baseMessage) {}

  @override
  TextStyle getMessageInputTextStyle(CometChatTheme theme) {
    // TODO: implement messageInputTextStyle
    throw UnimplementedError();
  }

  @override
  void onScrollToBottom(TextEditingController textEditingController) {
    // TODO: implement onScrollToBottom
  }

  @override
  TextStyle getMessageBubbleTextStyle(
      CometChatTheme theme, BubbleAlignment? alignment,
      {bool forConversation = false}) {
    if (messageBubbleTextStyle != null) {
      return messageBubbleTextStyle!(theme, alignment,
          forConversation: forConversation);
    } else {
      return TextStyle(
          color: alignment == BubbleAlignment.right
              ? theme.palette.getTertiary()
              : theme.palette.getPrimary(),
          fontWeight: theme.typography.body.fontWeight,
          fontSize: theme.typography.body.fontSize,
          fontFamily: theme.typography.body.fontFamily,
          decoration: TextDecoration.underline);
    }
  }

  @override
  void onChange(
      TextEditingController textEditingController, String previousText) {
    // TODO: implement onChange
  }

  @override
  List<AttributedText> getAttributedText(
      String text, CometChatTheme theme, BubbleAlignment? alignment,
      {List<AttributedText>? existingAttributes,
      Function(String)? onTap,
      bool forConversation = false}) {
    return super.getAttributedText(text, theme, alignment,
        existingAttributes: existingAttributes,
        onTap: onTap ??
            (text) async {
              if (pattern != null && pattern!.hasMatch(text)) {
                await launchUrl(Uri.parse(('mailto:$text')));
              }
            },
        forConversation: forConversation);
  }
}
