import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart' as cc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [CometChatReactionList] is a StatefulWidget that displays the list of reactions
/// for a particular message. It requires [reactionRequestBuilder] to fetch the
/// reactions of a particular message. It also requires [messageObject] to fetch
/// the reactions of a particular message. It also requires [onTap] to perform
/// some action on click of a particular reaction.
///
/// ```dart
/// CometChatReactionList(
///   reactionRequestBuilder: ReactionsRequestBuilder(), // Get reactions using a builder
///   errorStateText: "Error fetching reactions", // Set error text
///   emptyStateText: "No reactions yet", // Set empty state text
///   messageObject: messageObject, // Set the message object
///   onTap: (reaction, message) => print("Tapped reaction: $reaction"), // Handle tap on reaction
/// );
///```
class CometChatReactionList extends StatefulWidget {
  const CometChatReactionList({
    super.key,
    this.reactionRequestBuilder,
    this.errorStateView,
    this.errorStateText,
    this.loadingStateView,
    this.emptyStateView,
    this.emptyStateText,
    this.loadingIcon,
    this.avatarStyle,
    this.onTap,
    this.reactionListStyle,
    this.selectedReaction,
    this.listItemStyle,
    this.messageObject,
    this.theme,
  });

  ///[reactionRequestBuilder] is a parameter used to fetch the reactions of a particular message
  final ReactionsRequestBuilder? reactionRequestBuilder;

  ///[errorStateView] is a parameter used to show the error state view in case of any error
  final WidgetBuilder? errorStateView;

  ///[errorStateText] is a parameter used to show the error state text in case of any error
  final String? errorStateText;

  ///[loadingStateView] is a parameter used to show the loading state view in case of  loading
  final WidgetBuilder? loadingStateView;

  ///[emptyStateText] text to be displayed when the list is empty
  final String? emptyStateText;

  ///[emptyStateView] returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[loadingIcon] is a parameter used to show the loading icon in case of loading
  final Widget? loadingIcon;

  ///[avatarStyle] is a parameter used to set the style for avatar
  final AvatarStyle? avatarStyle;

  ///[onTap] is a parameter used to perform some action on click of a particular reaction
  final Function(Reaction, BaseMessage)? onTap;

  ///[reactionListStyle] is a parameter used to set the style for the reaction list
  final ReactionListStyle? reactionListStyle;

  ///[selectedReaction] is a parameter used to set the selected reaction
  final String? selectedReaction;

  ///[listItemStyle] is a parameter used to set the style for the list item
  final ListItemStyle? listItemStyle;

  ///[messageObject] is a parameter used to set the message object for which the reactions are to be fetched
  final BaseMessage? messageObject;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  @override
  State<CometChatReactionList> createState() => _CometChatReactionListState();
}

class _CometChatReactionListState extends State<CometChatReactionList> {
  late CometChatTheme _theme;
  late CometChatReactionListController reactionListController;
  late String _currentDateTime;

  @override
  void initState() {
    _theme = widget.theme ?? cometChatTheme;
    _currentDateTime = DateTime.now().millisecondsSinceEpoch.toString();
    reactionListController = CometChatReactionListController(
        messageId: widget.messageObject!.id,
        reactionsRequestBuilder: widget.reactionRequestBuilder,
        selectedReaction:
            widget.selectedReaction ?? ReactionConstants.allReactions,
        messageObject: widget.messageObject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.75,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: widget.reactionListStyle?.background ??
                  _theme.palette.getBackground(),
              gradient: widget.reactionListStyle?.gradient,
              border: widget.reactionListStyle?.border,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                      widget.reactionListStyle?.borderRadius ?? 16))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xff141414).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              //---reactions---
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: _getList(context, _theme),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getList(BuildContext context, CometChatTheme theme) {
    return GetBuilder<CometChatReactionListController>(
        tag: "default_tag_for_reactionList_$_currentDateTime",
        init: reactionListController,
        builder: (CometChatReactionListController value) {
          value.context = context;
          if (value.hasError == true) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _showError(value, context, theme));

            if (widget.errorStateView != null) {
              return widget.errorStateView!(context);
            }

            return _getLoadingIndicator(context, theme);
          } else if (value.isLoading == true &&
              (value.messageReactions.isEmpty)) {
            return _getLoadingIndicator(context, theme);
          } else if (value.messageReactions.isEmpty) {
            //----------- empty list widget-----------
            return _getNoReactionsIndicator(context, theme);
          } else {
            return SizedBox(
              width: widget.reactionListStyle?.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 64,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => value.updateSelectedReaction(
                                  ReactionConstants.allReactions),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: value.isSelectedReaction(
                                          ReactionConstants.allReactions)
                                      ? theme.palette.getAccent50()
                                      : null,
                                  border: Border.all(
                                      color: theme.palette
                                          .getBackground()
                                          .withOpacity(0.14),
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(22)),
                                ),
                                child: Text(
                                    "${cc.Translations.of(context).all} ${value.getReactionCount(ReactionConstants.allReactions)}",
                                    style: TextStyle(
                                            fontSize:
                                                theme.typography.name.fontSize,
                                            color: theme.palette.getAccent400())
                                        .merge(widget.reactionListStyle
                                            ?.allReactionsTextStyle)),
                              ),
                            ),
                            ...value.messageReactions.keys.map((reaction) =>
                                GestureDetector(
                                  onTap: () =>
                                      value.updateSelectedReaction(reaction),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 5),
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: value.isSelectedReaction(reaction)
                                          ? theme.palette.getAccent50()
                                          : null,
                                      border: Border.all(
                                          color: theme.palette
                                              .getBackground()
                                              .withOpacity(0.14),
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: reaction,
                                        style: TextStyle(
                                            fontSize:
                                                theme.typography.name.fontSize),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  " ${value.getReactionCount(reaction)}",
                                              style: TextStyle(
                                                  fontSize: theme
                                                      .typography.name.fontSize,
                                                  color: theme.palette
                                                      .getAccent400())),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  getReactedUsers(value),
                ],
              ),
            );
          }
        });
  }

  Widget getReactedUsers(CometChatReactionListController value) {
    List<Reaction> reactions = value.getReactionData();

    return SizedBox(
      height: widget.reactionListStyle?.height ??
          MediaQuery.of(context).size.height * .58,
      child: ListView.separated(
        itemCount:
            value.canFetchReactions() ? reactions.length + 1 : reactions.length,
        itemBuilder: (context, index) {
          if (index >= reactions.length) {
            value.fetchReactions(value.selectedReaction);
            return Container(
              height: 150,
              alignment: Alignment.center,
              child: widget.loadingIcon ??
                  Image.asset(
                    AssetConstants.spinner,
                    package: UIConstants.packageName,
                    color: widget.reactionListStyle?.loadingIconTint ??
                        _theme.palette.getAccent600(),
                  ),
            );
          }

          return GestureDetector(
            onTap: () {
              value.onReactionTap(reactions[index]);
            },
            child: getReactionListItem(reactions[index], value),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index >= reactions.length - 1) {
            return const SizedBox();
          }
          return Divider(
            height: 1,
            thickness: 1,
            color: _theme.palette.getAccent100(),
          );
        },
      ),
    );
  }

  Widget getReactionListItem(
      Reaction reaction, CometChatReactionListController value) {
    return CometChatListItem(
      avatarURL: reaction.reactedBy?.avatar,
      avatarName: reaction.reactedBy?.name,
      title: value.getReactionListItemTitle(reaction),
      subtitleView: getReactionItemSubtitle(reaction, value),
      tailView: Text(
        reaction.reaction ?? "",
        style: const TextStyle(fontSize: 34),
      ),
      style: ListItemStyle(
        titleStyle: TextStyle(fontSize: _theme.typography.body.fontSize),
      ),
      avatarStyle: const AvatarStyle(height: 48, width: 48),
    );
  }

  Widget? getReactionItemSubtitle(
      Reaction reaction, CometChatReactionListController value) {
    return value.isReactedByMe(reaction.reactedBy!)
        ? Text(
            cc.Translations.of(context).tapToRemove,
            style: TextStyle(
                    fontSize: _theme.typography.subtitle1.fontSize,
                    fontWeight: _theme.typography.subtitle1.fontWeight,
                    fontFamily: _theme.typography.subtitle1.fontFamily,
                    color: _theme.palette.getAccent600())
                .merge(widget.reactionListStyle?.subtitleTextStyle),
          )
        : null;
  }

  Widget _getLoadingIndicator(BuildContext context, CometChatTheme theme) {
    if (widget.loadingStateView != null) {
      return Center(child: widget.loadingStateView!(context));
    } else {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: widget.loadingIcon ??
            Image.asset(
              AssetConstants.spinner,
              package: UIConstants.packageName,
              color: widget.reactionListStyle?.loadingIconTint ??
                  theme.palette.getAccent600(),
            ),
      );
    }
  }

  Widget _getNoReactionsIndicator(BuildContext context, CometChatTheme theme) {
    if (widget.emptyStateView != null) {
      return Center(child: widget.emptyStateView!(context));
    } else {
      return Container(
        height: 300,
        alignment: Alignment.center,
        child: Text(
          widget.emptyStateText ?? cc.Translations.of(context).noReactionsFound,
          style: widget.reactionListStyle?.emptyTextStyle ??
              TextStyle(
                  fontSize: theme.typography.title1.fontSize,
                  fontWeight: theme.typography.title1.fontWeight,
                  color: theme.palette.getAccent400()),
        ),
      );
    }
  }

  _showError(CometChatReactionListController controller, BuildContext context,
      CometChatTheme theme) {
    String error;
    if (controller.error != null && controller.error is CometChatException) {
      error = Utils.getErrorTranslatedText(
          context, (controller.error as CometChatException).code);
    } else {
      error = cc.Translations.of(context).noGroupsFound;
    }
    if (widget.errorStateView != null) {}
    _showErrorDialog(error, context, theme, controller);
  }

  _showErrorDialog(String errorText, BuildContext context, CometChatTheme theme,
      CometChatReactionListController controller) {
    showCometChatConfirmDialog(
        context: context,
        messageText: Text(
          widget.errorStateText ?? errorText,
          style: widget.reactionListStyle?.errorTextStyle ??
              TextStyle(
                  fontSize: theme.typography.title2.fontSize,
                  fontWeight: theme.typography.title2.fontWeight,
                  color: theme.palette.getAccent(),
                  fontFamily: theme.typography.title2.fontFamily),
        ),
        confirmButtonText: cc.Translations.of(context).tryGain,
        cancelButtonText: cc.Translations.of(context).cancelCapital,
        style: ConfirmDialogStyle(
            backgroundColor: theme.palette.mode == PaletteThemeModes.light
                ? theme.palette.getBackground()
                : Color.alphaBlend(theme.palette.getAccent200(),
                    theme.palette.getBackground()),
            shadowColor: theme.palette.getAccent300(),
            confirmButtonTextStyle: TextStyle(
                fontSize: theme.typography.text2.fontSize,
                fontWeight: theme.typography.text2.fontWeight,
                color: theme.palette.getPrimary()),
            cancelButtonTextStyle: TextStyle(
                fontSize: theme.typography.text2.fontSize,
                fontWeight: theme.typography.text2.fontWeight,
                color: theme.palette.getPrimary())),
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () {
          Navigator.pop(context);
          controller.fetchReactions(controller.selectedReaction);
        });
  }
}
