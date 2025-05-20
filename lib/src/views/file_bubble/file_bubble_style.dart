import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[FileBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatFileBubble]
class FileBubbleStyle extends BaseStyles {
  const FileBubbleStyle(
      {this.titleStyle,
      this.subtitleStyle,
      super.width,
      super.height,
      super.background,
      super.border,
      super.borderRadius,
      super.gradient,
      this.downloadIconTint});

  ///[titleStyle] file name text style
  final TextStyle? titleStyle;

  ///[subtitleStyle] subtitle text style
  final TextStyle? subtitleStyle;

  ///[downloadIconTint] video play pause icon
  final Color? downloadIconTint;
}
