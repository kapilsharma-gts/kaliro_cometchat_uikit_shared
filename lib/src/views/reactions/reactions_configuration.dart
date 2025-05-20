import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[ReactionsConfiguration] is a class which is used to set the configuration for the reactions
///It takes [theme], [onReactionTap], [onReactionLongPress], [reactionsStyle] as a parameter
///
/// ```dart
/// ReactionsConfiguration(
/// reactionList: reactionList,
/// theme: theme,
/// onReactionTap: (reaction) {
/// print("reaction pressed");
/// },
/// );
class ReactionsConfiguration {
  ReactionsConfiguration(
      {this.theme,
      this.onReactionTap,
      this.onReactionLongPress,
      this.reactionsStyle});

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[onReactionTap] is a callback which gets called when a reaction is pressed
  final Function(String? reaction)? onReactionTap;

  ///[onReactionLongPress] is a callback which gets called when a reaction is long pressed
  final Function(String? reaction)? onReactionLongPress;

  ///[reactionsStyle] is a parameter used to set the style for the reactions
  final ReactionsStyle? reactionsStyle;
}
