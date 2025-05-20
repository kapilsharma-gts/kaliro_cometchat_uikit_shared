import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[ReactionsStyle] is a class which is used to set the style for the reactions
///It takes [reactionTextStyle], [reactionCountTextStyle], [width], [height], [background], [gradient], [border], [borderRadius] as a parameter
///
/// ```dart
/// ReactionsStyle(
/// reactionTextStyle: TextStyle(color: Colors.white),
/// reactionCountTextStyle: TextStyle(color: Colors.white),
/// background: Colors.blue,
/// );
class ReactionsStyle extends BaseStyles {
  ReactionsStyle(
      {this.reactionTextStyle,
      this.reactionCountTextStyle,
      this.primaryBackgroundColor,
      this.primaryBorder,
      this.margin,
      this.padding,
      super.width,
      super.height,
      super.background,
      super.gradient,
      super.border,
      super.borderRadius});

  ///[reactionTextStyle] is the  text style applied to reactions
  TextStyle? reactionTextStyle;

  ///[reactionCountTextStyle] is the  text style applied to reaction count
  TextStyle? reactionCountTextStyle;

  ///[primaryBackgroundColor] is the  background color applied to selected reaction
  Color? primaryBackgroundColor;

  ///[primaryBorder] is the  border style applied to selected reaction
  BoxBorder? primaryBorder;

  ///[margin] can be used to apply margin around each reaction
  EdgeInsets? margin;

  ///[padding] can be used to apply padding inside each reaction
  EdgeInsets? padding;

  ReactionsStyle copyWith(
      {TextStyle? reactionTextStyle,
      TextStyle? reactionCountTextStyle,
      double? width,
      double? height,
      Color? background,
      Gradient? gradient,
      BoxBorder? border,
      double? borderRadius,
      Color? primaryBackgroundColor,
      BoxBorder? primaryBorder,
      EdgeInsets? margin,
      EdgeInsets? padding}) {
    return ReactionsStyle(
        reactionTextStyle: reactionTextStyle ?? this.reactionTextStyle,
        reactionCountTextStyle:
            reactionCountTextStyle ?? this.reactionCountTextStyle,
        width: width ?? this.width,
        height: height ?? this.height,
        background: background ?? this.background,
        gradient: gradient ?? this.gradient,
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        primaryBackgroundColor:
            primaryBackgroundColor ?? this.primaryBackgroundColor,
        primaryBorder: primaryBorder ?? this.primaryBorder,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding);
  }

  ReactionsStyle merge(ReactionsStyle? style) {
    if (style == null) return this;
    return copyWith(
        reactionTextStyle: style.reactionTextStyle,
        reactionCountTextStyle: style.reactionCountTextStyle,
        width: style.width,
        height: style.height,
        background: style.background,
        gradient: style.gradient,
        border: style.border,
        borderRadius: style.borderRadius,
        primaryBorder: style.primaryBorder,
        primaryBackgroundColor: style.primaryBackgroundColor,
        margin: style.margin,
        padding: style.padding);
  }
}
