import 'package:flutter/material.dart';

///[AttributedText] is a class which is used to style the text
/// ```dart
/// AttributedText(
///    start: 0,
///    end: 5,
///    underlyingText: 'Hello',
///    style: TextStyle(
///    color: Colors.pink,
///    ),
///    onTap: (text) {
///    print(text);
///    },
///    );
///    ```
class AttributedText {
  AttributedText(
      {required this.start,
      required this.end,
      this.underlyingText,
      this.style,
      this.onTap});

  ///[start] is an integer value which is used to store the start index of the text
  int start;

  ///[end] is an integer value which is used to store the end index of the text
  int end;

  ///[style] is a [TextStyle] object which is used to style the text
  TextStyle? style;

  ///[underlyingText] is a [String] value which is used to store the text
  String? underlyingText;

  ///[onTap] is a function which is used to perform some action when the text is tapped
  Function(String)? onTap;

  @override
  String toString() {
    return 'AttributedText{start: $start, end: $end, underlyingText: $underlyingText, style: $style}';
  }
}
