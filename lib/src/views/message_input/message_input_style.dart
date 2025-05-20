import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[MessageInputStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatMessageInput]
class MessageInputStyle extends BaseStyles {
  const MessageInputStyle({
    this.textStyle,
    this.placeholderTextStyle,
    this.dividerTint,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[textStyle]
  final TextStyle? textStyle;

  ///[placeholderTextStyle] hint text style
  final TextStyle? placeholderTextStyle;

  ///[dividerTint] provides color to the divider sepeating input field and bottom bar
  final Color? dividerTint;
}
