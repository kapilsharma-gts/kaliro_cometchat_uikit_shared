import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[ImageBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatImageBubble]
class ImageBubbleStyle extends BaseStyles {
  const ImageBubbleStyle(
      {super.width,
      super.height,
      super.background,
      super.border,
      super.borderRadius,
      super.gradient,
      this.captionStyle});

  ///[captionStyle] provides styling to the caption text
  final TextStyle? captionStyle;
}
