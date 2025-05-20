import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

/// [SuggestionListItem] is a modal class used to define the structure of the list item
/// used in the suggestions list.
///
/// ```dart
/// SuggestionListItem(
///  title: 'John Doe',
///  subtitle: 'john.doe@cometchat',
///  avatarStyle: AvatarStyle(
///  width: 30,
///  height: 30,
///  borderRadius: 15,
///  ),
///  avatarUrl: 'https://ui-avatars.com/api/?name=John+Doe',
///  avatarName: 'John Doe',
///  onTap: () {
///  print('John Doe tapped');
///  },
///  );
class SuggestionListItem {
  SuggestionListItem({
    required this.id,
    this.title,
    this.subtitle,
    this.avatarStyle,
    this.avatarUrl,
    this.avatarName,
    this.onTap,
  });

  final String id;

  /// [title] is a [String] value that defines the title of the list item.
  final String? title;

  /// [subtitle] is a [String] value that defines the subtitle of the list item.
  final String? subtitle;

  /// [avatarStyle] is an [AvatarStyle] object that defines the style of the avatar.
  final AvatarStyle? avatarStyle;

  /// [avatarUrl] is a [String] value that defines the URL of the avatar.
  final String? avatarUrl;

  /// [avatarName] is a [String] value that defines the name of the avatar.
  final String? avatarName;

  /// [onTap] is a [Function] that defines the action to be performed when the list item is tapped.
  final Function? onTap;

  @override
  bool operator ==(other) => other is SuggestionListItem && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
