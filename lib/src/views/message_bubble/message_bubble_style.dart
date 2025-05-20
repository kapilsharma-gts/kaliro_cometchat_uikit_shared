import 'package:flutter/material.dart';
import '../../../../kaliro_cometchat_uikit_shared.dart';

///[MessageBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatMessageBubble]
class MessageBubbleStyle extends BaseStyles {
  ///[MessageBubbleStyle] constructor requires [width], [height], [background], [elevation], [border], [borderRadius], [borderRadiusGeometry], [gradient] and [contentPadding] while initializing.
  const MessageBubbleStyle(
      {super.width,
      super.height,
      super.background,
      super.border,
      super.elevation,
      super.borderRadius,
      super.borderRadiusGeometry,
      super.gradient,
      this.widthFlex,
      this.contentPadding});

  ///[contentPadding] sets padding for the bubble
  final EdgeInsets? contentPadding;

  ///[widthFlex] gives flex to the message bubble
  final double? widthFlex;
}
