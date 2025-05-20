import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[TextBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatTextBubble]
class TextBubbleStyle extends BaseStyles {
  const TextBubbleStyle({
    this.textStyle,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[textStyle] provides style to text
  final TextStyle? textStyle;
}
