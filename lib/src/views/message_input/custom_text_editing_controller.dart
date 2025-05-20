import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController {
  late CometChatTheme theme;

  List<CometChatTextFormatter>? formatters;
  CustomTextEditingController({
    super.text,
    CometChatTheme? theme,
    this.formatters,
  }) {
    this.theme = theme ?? cometChatTheme;
    formatters;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    if (formatters == null || formatters!.isEmpty) {
      return super.buildTextSpan(
          context: context, style: style!, withComposing: withComposing);
    } else {
      return TextSpan(
          style: style, children: buildSpan(context, style, withComposing));
    }
  }

  List<TextSpan> buildSpan(
      BuildContext context, TextStyle? style, bool withComposing) {
    List<TextSpan> textSpan = [];
    List<AttributedText> attributedTexts = [];
    for (CometChatTextFormatter formatter in formatters ?? []) {
      attributedTexts = formatter.buildInputFieldText(
          text: text,
          style: style,
          existingAttributes: attributedTexts,
          context: context,
          withComposing: withComposing,
          theme: theme);
    }

    int start = 0;

    for (AttributedText attributedText in attributedTexts) {
      textSpan.add(TextSpan(
        text: text.substring(start, attributedText.start),
        style: TextStyle(
          color: theme.palette.getAccent(),
          fontWeight: theme.typography.body.fontWeight,
          fontSize: theme.typography.body.fontSize,
          fontFamily: theme.typography.body.fontFamily,
        ),
        // recognizer: TapGestureRecognizer()
        //   ..onTap = () async {
        //     await onTapUrl(letter);
        //   },
      ));

      textSpan.add(TextSpan(
        text: attributedText.underlyingText ??
            text.substring(attributedText.start, attributedText.end),
        style: attributedText.style ??
            TextStyle(
              color: theme.palette.getAccent(),
              fontWeight: theme.typography.body.fontWeight,
              fontSize: theme.typography.body.fontSize,
              fontFamily: theme.typography.body.fontFamily,
            ),
        // recognizer: TapGestureRecognizer()
        //   ..onTap = () async {
        //     await onTapUrl(letter);
        //   },
      ));
      start = attributedText.end;
    }

    textSpan.add(TextSpan(
      text: text.substring(start),
      style: TextStyle(
        color: theme.palette.getAccent(),
        fontWeight: theme.typography.body.fontWeight,
        fontSize: theme.typography.body.fontSize,
        fontFamily: theme.typography.body.fontFamily,
      ),
      // recognizer: TapGestureRecognizer()
      //   ..onTap = () async {
      //     await onTapUrl(text.substring(start));
      //   },
    ));

    return textSpan;
  }
}
