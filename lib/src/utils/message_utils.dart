import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class MessageUtils {
  static Widget getMessageBubble({
    required BaseMessage message,
    CometChatMessageTemplate? template,
    required BubbleAlignment bubbleAlignment,
    required CometChatTheme theme,
    required BuildContext context,
  }) {
    if (template?.bubbleView != null) {
      return template?.bubbleView!(message, context, BubbleAlignment.left) ??
          const SizedBox();
    }
    Color backgroundColor = _getBubbleBackgroundColor(message, template, theme);
    Widget? contentView;

    contentView = _getSuitableContentView(
        message, theme, context, backgroundColor, template, bubbleAlignment);

    return Column(
      children: [
        Row(
          mainAxisAlignment: bubbleAlignment == BubbleAlignment.left
              ? MainAxisAlignment.start
              : bubbleAlignment == BubbleAlignment.center
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
          children: [
            CometChatMessageBubble(
              style: MessageBubbleStyle(background: backgroundColor),
              headerView: const SizedBox(),
              alignment: bubbleAlignment,
              contentView: contentView,
              footerView: const SizedBox(),
              leadingView: const SizedBox(),
              bottomView: const SizedBox(),
            )
          ],
        ),
      ],
    );
  }

  static Color _getBubbleBackgroundColor(
    BaseMessage messageObject,
    CometChatMessageTemplate? template,
    CometChatTheme theme,
  ) {
    if (messageObject.deletedAt != null) {
      return theme.palette.getPrimary().withOpacity(0);
    } else if (messageObject.type == MessageTypeConstants.text) {
      if (ChatAlignment.standard == ChatAlignment.leftAligned) {
        return theme.palette.getAccent100();
      } else {
        return theme.palette.getPrimary();
      }
    } else if (messageObject.category == MessageCategoryConstants.custom) {
      return Colors.transparent;
    } else {
      return theme.palette.getAccent100();
    }
  }

  static Widget? _getSuitableContentView(
      BaseMessage messageObject,
      CometChatTheme theme,
      BuildContext context,
      Color background,
      CometChatMessageTemplate? template,
      BubbleAlignment alignment) {
    if (template?.contentView != null) {
      return template?.contentView!(
        messageObject,
        context,
        alignment,
      );
    } else {
      return const SizedBox();
    }
  }
}
