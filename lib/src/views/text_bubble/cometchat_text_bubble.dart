import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[CometChatTextBubble] is a widget that gives text bubble
/// ```dart
///                 CometChatTextBubble(
///                        text: 'some text message',
///                        alignment: BubbleAlignment.left,
///                        theme: cometChatTheme,
///                        style: TextBubbleStyle(
///                            background: cometChatTheme.palette.getAccent100()),
///                      );
/// ```
class CometChatTextBubble extends StatelessWidget {
  const CometChatTextBubble({
    super.key,
    this.text,
    this.style = const TextBubbleStyle(),
    this.theme,
    this.alignment,
    this.formatters,
  });

  ///[text] if message object is not passed then text should be passed
  final String? text;

  ///[style] manages the styling of this widget
  final TextBubbleStyle style;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[alignment] of the bubble
  final BubbleAlignment? alignment;

  ///[formatters] is a list of [CometChatTextFormatter] which is used to style the text
  final List<CometChatTextFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    String? message;
    if (text != null) {
      message = text;
    }

    if (message == null) {
      return const SizedBox(height: 0, width: 0);
    }

    CometChatTheme theme = this.theme ?? cometChatTheme;

    return Container(
        height: style.height,
        width: style.width,
        decoration: BoxDecoration(
            border: style.border,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 6),
            color: style.gradient == null
                ? style.background ?? Colors.transparent
                : null,
            gradient: style.gradient),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: RichText(
            text: TextSpan(
                style: style.textStyle ??
                    TextStyle(
                        color: alignment == BubbleAlignment.right
                            ? theme.palette.backGroundColor.light
                            : theme.palette.getAccent(),
                        fontWeight: theme.typography.body.fontWeight,
                        fontSize: theme.typography.body.fontSize,
                        fontFamily: theme.typography.body.fontFamily),
                children: FormatterUtils.buildTextSpan(
                    message, formatters, theme, alignment)),
          ),
        ));
  }
}
