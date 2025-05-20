import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';
import '../../utils/action_element_utils.dart';

///[CometChatCardBubble] creates the card view for [InteractiveMessage] with type [MessageTypeConstants.card] by default
///
///used by default  when the category and type of [MediaMessage] is message and [MessageTypeConstants.image] respectively
/// ```dart
///             CometChatCardBubble(
///                  theme: cometChatTheme,
///                  imageUrl:
///                      'image url',
///                  style: const CardBubbleStyle(
///                    borderRadius: 8,
///                  ),
///                );
/// ```
class CometChatCardBubble extends StatefulWidget {
  const CometChatCardBubble(
      {super.key, this.cardBubbleStyle, required this.cardMessage, this.theme, this.onActionTap, this.loggedInUser});

  ///[cardBubbleStyle] sets the style for the card
  final CardBubbleStyle? cardBubbleStyle;

  ///[cardMessage] sets the message object for the card
  final CardMessage cardMessage;

  ///[theme] sets the theme for the card
  final CometChatTheme? theme;

  ///[onActionTap] overrides the on tap functionality
  final Function(dynamic interactiveElement)? onActionTap;

  ///[loggedInUser] pass logged in user to bubble
  final User? loggedInUser;

  @override
  State<CometChatCardBubble> createState() => _CometChatCardState();
}

class _CometChatCardState extends State<CometChatCardBubble> {
  late CometChatTheme theme;
  Map<String, bool?> interactionMap = {};
  bool isSentByMe = false;
  late ButtonElementStyle defaultButtonStyle;

  @override
  void initState() {
    theme = widget.theme ?? cometChatTheme;
    _populateMap();
    populateStyles();
    isSentByMe = false;
    super.initState();
  }

  //populates the
  _populateMap() {
    if (widget.cardMessage.interactions != null) {
      for (var element in widget.cardMessage.interactions!) {
        interactionMap[element.elementId] = true;
      }
    }
  }

  populateStyles() {
    TextStyle defaultButtonTextStyle = TextStyle(
        fontSize: theme.typography.title2.fontSize,
        fontWeight: theme.typography.title2.fontWeight,
        fontFamily: theme.typography.title2.fontFamily,
        color: theme.palette.getPrimary());

    defaultButtonStyle = ButtonElementStyle(
      height: 35,
      borderRadius: 6,
      buttonTextStyle: defaultButtonTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.palette.getBackground(),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(
          color: theme.palette.getSecondary(),
          width: 4,
        ),
      ),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 65 / 100),
      //color: theme.palette.getBackground(),
      child: Column(
        children: [
          if (widget.cardMessage.imageUrl != null && widget.cardMessage.imageUrl?.trim() != '')
            CometChatImageBubble(
              style: ImageBubbleStyle(
                width: MediaQuery.of(context).size.width * 65 / 100,
              ),
              theme: theme,
              imageUrl: widget.cardMessage.imageUrl!,
            ),
          if (widget.cardMessage.text.trim() != '')
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                widget.cardMessage.text,
                style: TextStyle(
                        fontWeight: theme.typography.subtitle1.fontWeight,
                        fontSize: theme.typography.subtitle1.fontSize,
                        fontFamily: theme.typography.subtitle1.fontFamily,
                        color: theme.palette.getAccent())
                    .merge(widget.cardBubbleStyle?.textStyle),
              ),
            ),
        ],
      ),
    );
  }

  Widget showActions(dynamic interactiveElement) {
    switch (interactiveElement.runtimeType) {
      default:
        return const SizedBox.shrink();
    }
  }

  markInteracted(dynamic interactiveElement) async {
    // await InteractiveMessageUtils.markInteracted(
    //     interactiveElement, widget.cardMessage, interactionMap,
    //     onSuccess: (bool matched) {
    //   if (mounted) {
    //     setState(() {});
    //   } else {}
    // });
  }
}
