import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[ReactionListStyle] is a class which is used to set the style for the reaction list
///It takes [loadingIconTint], [emptyTextStyle], [errorTextStyle], [subtitleTextStyle], [width], [height], [background], [gradient], [border], [borderRadius] as a parameter
///
/// ```dart
/// ReactionListStyle(
/// loadingIconTint: Colors.white,
/// emptyTextStyle: TextStyle(color: Colors.white),
/// errorTextStyle: TextStyle(color: Colors.white),
/// subtitleTextStyle: TextStyle(color: Colors.white),
/// background: Colors.blue,
/// );
class ReactionListStyle extends BaseStyles {
  ReactionListStyle(
      {this.loadingIconTint,
      this.emptyTextStyle,
      this.errorTextStyle,
      this.subtitleTextStyle,
      this.allReactionsTextStyle,
      super.width,
      super.height,
      super.background,
      super.gradient,
      super.border,
      super.borderRadius});

  ///[loadingIconTint] provides color to loading icon
  final Color? loadingIconTint;

  ///[emptyTextStyle] provides styling for text to indicate reaction list is empty
  final TextStyle? emptyTextStyle;

  ///[errorTextStyle] provides styling for text to indicate some error has occurred while fetching the reaction list
  final TextStyle? errorTextStyle;

  ///[subtitleTextStyle] provides styling to the text in the subtitle
  final TextStyle? subtitleTextStyle;

  ///[allReactionsTextStyle] provides styling to the text "All" shown for the all reactions tab
  final TextStyle? allReactionsTextStyle;
}
