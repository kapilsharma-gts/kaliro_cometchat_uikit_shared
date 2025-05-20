import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[AudioBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatAudioBubble]
class AudioBubbleStyle extends BaseStyles {
  const AudioBubbleStyle({
    this.titleStyle,
    this.subtitleStyle,
    this.playIconTint,
    this.pauseIconTint,
    super.width,
    super.height,
    super.background,
    super.border,
    super.borderRadius,
    super.gradient,
  });

  ///[titleStyle] file name text style
  final TextStyle? titleStyle;

  ///[subtitleStyle] subtitle text style
  final TextStyle? subtitleStyle;

  ///[playIconTint] provides color to the video play icon
  final Color? playIconTint;

  ///[pauseIconTint] provides color to the video play icon
  final Color? pauseIconTint;
}
