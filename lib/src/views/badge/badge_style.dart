import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[BadgeStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatBadge]
class BadgeStyle extends BaseStyles {
  const BadgeStyle({
    this.textStyle,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[textStyle] gives style to count
  final TextStyle? textStyle;
}
