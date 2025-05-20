import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[CometChatReactions] is a widget which is used to set the reactions
///It takes [reactionList], [theme], [alignment], [onReactionTap], [onReactionLongPress], [reactionsStyle] as a parameter
///
/// ```dart
/// CometChatReactions(
///  reactionList: reactionList,
///  theme: theme,
///  alignment: BubbleAlignment.left,
///  onReactionTap: (reaction) {
///  print("reaction tapped");
///  },
///  onReactionLongPress: (reaction) {
///  print("reaction long pressed");
///  },
///  );
class CometChatReactions extends StatefulWidget {
  const CometChatReactions(
      {super.key,
      required this.reactionList,
      this.theme,
      this.alignment,
      this.onReactionTap,
      this.onReactionLongPress,
      this.reactionsStyle});

  ///[reactionList] is a list of ReactionCount which is used to set the reactions
  final List<ReactionCount> reactionList;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[alignment] is used to set the alignment of the reactions
  final BubbleAlignment? alignment;

  ///[onReactionTap] is a callback which gets called when a reaction is pressed
  final Function(String? reaction)? onReactionTap;

  ///[onReactionLongPress] is a callback which gets called when a reaction is long pressed
  final Function(String? reaction)? onReactionLongPress;

  ///[reactionsStyle] is a parameter used to set the style for the reactions
  final ReactionsStyle? reactionsStyle;

  @override
  State<CometChatReactions> createState() => _CometChatReactionsState();
}

class _CometChatReactionsState extends State<CometChatReactions> {
  late List<ReactionCount> reactionList;
  Widget? extraReactions;
  late CometChatTheme _theme;
  @override
  void initState() {
    super.initState();
    reactionList = widget.reactionList;
    _theme = widget.theme ?? cometChatTheme;
    getExtraReactions();
  }

  @override
  void didUpdateWidget(covariant CometChatReactions oldWidget) {
    reactionList = widget.reactionList;
    getExtraReactions();

    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  void getExtraReactions() {
    if (reactionList.length > 4) {
      bool reactedByMe =
          reactionList.sublist(3).any((element) => element.reactedByMe == true);
      reactionList = reactionList.take(3).toList();
      int initialReactionsCount = widget.reactionList.length;
      int extraReactionsCount = initialReactionsCount - 3;

      if (extraReactionsCount > 1) {
        extraReactions = GestureDetector(
          onTap: () {
            if (widget.onReactionLongPress != null) {
              widget.onReactionLongPress!(ReactionConstants.allReactions);
            }
          },
          onLongPress: () {
            if (widget.onReactionLongPress != null) {
              widget.onReactionLongPress!(ReactionConstants.allReactions);
            }
          },
          child: Container(
            margin: getMargin(),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: widget.reactionsStyle?.background ??
                  Color.alphaBlend(
                      (reactedByMe
                          ? widget.reactionsStyle?.primaryBackgroundColor ??
                              _theme.palette.getPrimary().withOpacity(.1)
                          : _theme.palette.getAccent50()),
                      _theme.palette.backGroundColor.light),
              border: Border.all(
                  color: reactedByMe == true
                      ? _theme.palette.getPrimary().withOpacity(.4)
                      : _theme.palette.getBackground().withOpacity(0.14),
                  width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(22)),
            ),
            child: Text("+ $extraReactionsCount",
                style: TextStyle(
                    fontSize: _theme.typography.name.fontSize,
                    color: _theme.palette.getAccent())),
          ),
        );
        setState(() {});
      }
    } else {
      extraReactions = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...reactionList.map((reactionCount) => GestureDetector(
            onTap: () {
              if (widget.onReactionTap != null) {
                widget.onReactionTap!(reactionCount.reaction);
              }
            },
            onLongPress: () {
              if (widget.onReactionLongPress != null) {
                widget.onReactionLongPress!(reactionCount.reaction);
              }
            },
            child: Container(
              height: widget.reactionsStyle?.height,
              width: widget.reactionsStyle?.width,
              alignment: Alignment.center,
              margin: widget.reactionsStyle?.margin ?? getMargin(),
              padding: widget.reactionsStyle?.padding ??
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  color: widget.reactionsStyle?.background ??
                      Color.alphaBlend(
                          (reactionCount.reactedByMe == true
                              ? widget.reactionsStyle?.primaryBackgroundColor ??
                                  _theme.palette.getPrimary().withOpacity(.1)
                              : _theme.palette.getAccent50()),
                          _theme.palette.backGroundColor.light),
                  border: reactionCount.reactedByMe == true
                      ? widget.reactionsStyle?.primaryBorder ??
                          Border.all(
                              color:
                                  _theme.palette.getPrimary().withOpacity(.4),
                              width: 1)
                      : (widget.reactionsStyle?.border ??
                          Border.all(
                              color: _theme.palette
                                  .getBackground()
                                  .withOpacity(0.14),
                              width: 1)),
                  borderRadius: BorderRadius.all(Radius.circular(
                      widget.reactionsStyle?.borderRadius ?? 22)),
                  gradient: widget.reactionsStyle?.gradient),
              child: RichText(
                text: TextSpan(
                  text: reactionCount.reaction,
                  style: TextStyle(fontSize: _theme.typography.name.fontSize)
                      .merge(widget.reactionsStyle?.reactionTextStyle),
                  children: <TextSpan>[
                    TextSpan(
                        text: " ${reactionCount.count}",
                        style: TextStyle(
                                fontSize: _theme.typography.name.fontSize,
                                color: _theme.palette.getAccent())
                            .merge(
                                widget.reactionsStyle?.reactionCountTextStyle)),
                  ],
                ),
              ),
            ),
          )),
      if (extraReactions != null) extraReactions!
    ]);
  }

  EdgeInsets getMargin() {
    double leftAlignment = 0;
    if (widget.alignment == BubbleAlignment.right) {
      leftAlignment = 2;
    }

    double rightAlignment = 0;
    if (widget.alignment == BubbleAlignment.left) {
      rightAlignment = 2;
    }
    return EdgeInsets.only(left: leftAlignment, right: rightAlignment);
  }
}
