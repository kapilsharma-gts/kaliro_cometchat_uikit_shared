import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[CometChatDeleteMessageBubble] is a widget that provides a placeholder for messages thave been deleted
///
///a [BaseMessage] is considered deleted if the value of its [deletedAt] property is not null
/// ```dart
/// CometChatDeleteMessageBubble()
/// ```
class CometChatDeleteMessageBubble extends StatelessWidget {
  const CometChatDeleteMessageBubble(
      {super.key, this.style = const DeletedBubbleStyle()});

  ///[style] contains properties that affects the appearance of this widget
  final DeletedBubbleStyle style;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: style.height ?? 20,
      // width: style.width ?? 160,
      decoration: BoxDecoration(
          border: style.border,
          borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
          color: style.gradient == null
              ? style.background ?? const Color(0xff3399FF).withOpacity(0)
              : null,
          gradient: style.gradient),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Text(
          Translations.of(context).messageIsDeleted,
          style: style.textStyle ??
              TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff141414).withOpacity(0.4)),
        ),
      )
    );
  }
}
