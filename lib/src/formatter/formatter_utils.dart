import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///[FormatterUtils] is an utility class which is used to style the text in the message bubble and the conversation subtitle
class FormatterUtils {
  ///[buildTextSpan] is a method which is used to style the text in the message bubble and the conversation subtitle
  ///It takes [text], [formatters], [theme], [alignment] and [forConversation] as a parameter
  ///[text] is a string which needs to be styled
  ///[formatters] is a list of [CometChatTextFormatter] which is used to style the text
  ///[theme] is a object of [CometChatTheme] which is used to style the text
  ///[alignment] is a object of [BubbleAlignment] which is used to style the text
  ///[forConversation] is a boolean which is used to style the text in the conversation subtitle
  static List<TextSpan> buildTextSpan(
      String text,
      List<CometChatTextFormatter>? formatters,
      CometChatTheme? theme,
      BubbleAlignment? alignment,
      {bool forConversation = false}) {
    List<TextSpan> textSpan = [];
    List<AttributedText> attributedTexts = [];
    for (CometChatTextFormatter formatter in formatters ?? []) {
      attributedTexts = formatter.getAttributedText(
          text, theme ?? cometChatTheme, alignment,
          existingAttributes: attributedTexts,
          forConversation: forConversation);
    }

    int start = 0;

    for (AttributedText attributedText in attributedTexts) {
      textSpan.add(TextSpan(
        text: text.substring(start, attributedText.start),
        style: TextStyle(
          color: alignment == BubbleAlignment.right
              ? theme!.palette.backGroundColor.light
              : forConversation
                  ? theme!.palette.getAccent600()
                  : theme!.palette.getAccent(),
          fontWeight: theme.typography.body.fontWeight,
          fontSize: forConversation
              ? theme.typography.subtitle1.fontSize
              : theme.typography.body.fontSize,
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
              color: alignment == BubbleAlignment.right
                  ? theme.palette.backGroundColor.light
                  : theme.palette.getAccent(),
              fontWeight: theme.typography.body.fontWeight,
              fontSize: forConversation
                  ? theme.typography.subtitle1.fontSize
                  : theme.typography.body.fontSize,
              fontFamily: theme.typography.body.fontFamily,
            ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            if (!forConversation && attributedText.onTap != null) {
              attributedText.onTap!(
                  text.substring(attributedText.start, attributedText.end));
            }
          },
      ));
      start = attributedText.end;
    }

    textSpan.add(TextSpan(
      text: text.substring(start),
      style: TextStyle(
        color: alignment == BubbleAlignment.right
            ? theme!.palette.backGroundColor.light
            : forConversation
                ? theme!.palette.getAccent600()
                : theme!.palette.getAccent(),
        fontWeight: theme.typography.body.fontWeight,
        fontSize: forConversation
            ? theme.typography.subtitle1.fontSize
            : theme.typography.body.fontSize,
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
