import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

class GroupActionBubbleStyle extends BaseStyles {
  const GroupActionBubbleStyle({
    this.textStyle,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[textStyle] text style of group action message
  final TextStyle? textStyle;
}
