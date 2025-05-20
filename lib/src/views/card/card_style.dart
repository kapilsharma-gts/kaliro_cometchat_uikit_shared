import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[CardStyle] is a model class for card widget. It contains the styles for the card widget.
///
/// ```dart
/// CardStyle(
/// titleStyle: TextStyle(),
/// subtitleStyle: TextStyle(),
/// width: 100,
/// height: 100,
/// background: Colors.white,
/// border: Border.all(),
/// borderRadius: BorderRadius.circular(20),
/// gradient: LinearGradient(),
/// );
/// ```
///
class CardStyle extends BaseStyles {
  const CardStyle({
    this.titleStyle,
    this.subtitleStyle,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[titleStyle] sets TextStyle for title
  final TextStyle? titleStyle;

  ///[subtitleStyle] sets TextStyle for subtitle
  final TextStyle? subtitleStyle;

  // @Override
  // public CardStyle setActiveBackground(int activeBackground) {
  //     super.setActiveBackground(activeBackground);
  //     return this;
  // }
}
