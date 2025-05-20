import 'package:flutter/material.dart';

import '../../../kaliro_cometchat_uikit_shared.dart';

class DecoratedContainerStyle extends BaseStyles {
  const DecoratedContainerStyle({
    this.margin,
    this.padding,
    this.titleStyle,
    this.contentStyle,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  final TextStyle? contentStyle;

  final TextStyle? titleStyle;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  /// Merges current `AIConversationSummaryStyle` with [other]
  DecoratedContainerStyle merge(DecoratedContainerStyle? other) {
    if (other == null) return this;
    return DecoratedContainerStyle(
      contentStyle: other.contentStyle,
      titleStyle: other.titleStyle,
      padding: other.padding,
      margin: other.margin,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
    );
  }
}
