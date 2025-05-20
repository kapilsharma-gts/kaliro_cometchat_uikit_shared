import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///creates a widget that gives group action bubble
class CometChatGroupActionBubble extends StatelessWidget {
  const CometChatGroupActionBubble(
      {super.key,
      this.message,
      required this.text,
      this.style = const GroupActionBubbleStyle(),
      this.leadingIcon,
      this.theme});

  ///[message] action message object
  final String? message;

  ///[text] if message object is not passed then text should be passed
  final String? text;

  ///[style] group action bubble styling properties
  final GroupActionBubbleStyle style;

  final Widget? leadingIcon;

  final CometChatTheme? theme;

  @override
  Widget build(BuildContext context) {
    CometChatTheme theme = this.theme ?? cometChatTheme;
    String? text = this.text;
    if (text == null) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }

    return Container(
      height: style.height ?? 24,
      width: style.width,
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      decoration: BoxDecoration(
          color: //Colors.transparent,
              style.gradient == null
                  ? style.background ?? theme.palette.getBackground()
                  : null,
          border: style.border ??
              Border.all(
                color: theme.palette.getAccent200(),
              ),
          borderRadius: BorderRadius.circular(style.borderRadius ?? 11),
          gradient: style.gradient),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) leadingIcon!,
          Flexible(
            child: Text(
              text.replaceAll('', '\u{200B}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: style.textStyle ??
                  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: theme.palette.getAccent600()),
            ),
          ),
        ],
      ),
    );
  }
}
