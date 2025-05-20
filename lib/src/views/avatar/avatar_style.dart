import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[AvatarStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatAvatar]
class AvatarStyle extends BaseStyles {
  const AvatarStyle({
    this.outerViewWidth,
    this.outerViewBackgroundColor,
    this.outerViewSpacing,
    this.nameTextStyle,
    this.outerBorderRadius,
    this.outerViewBorder,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[outerBorderRadius] of outer container
  final double? outerBorderRadius;

  ///[outerViewBorder] style the outer Container border
  final BoxBorder? outerViewBorder;

  ///[outerViewWidth] outer view With
  final double? outerViewWidth;

  ///[outerViewBackgroundColor] outer Container background Color
  final Color? outerViewBackgroundColor;

  ///[outerViewSpacing] Spacing between the image and the outer border
  final double? outerViewSpacing;

  ///[nameTextStyle] font style is applied to the fallback name which is visible if an image url has not been provided
  final TextStyle? nameTextStyle;
}
