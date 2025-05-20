import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[DeletedBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatDeleteMessageBubble]
class DeletedBubbleStyle extends BaseStyles {
  const DeletedBubbleStyle({
    this.textStyle,
    this.borderColor,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[textStyle] delete message bubble text style
  final TextStyle? textStyle;

  ///[borderColor] border color of bubble
  final Color? borderColor;
}
