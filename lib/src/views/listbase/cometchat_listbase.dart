import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[CometChatListBase] is a top level container widget
///used internally by components like [CometChatUsers], [CometChatGroups], [CometChatConversations], [CometChatGroupMembers]
/// ```dart
///   CometChatListBase(
///        title: "title",
///        container: Container(),
///        style: ListBaseStyle(),
///    );
/// ```
class CometChatListBase extends StatelessWidget {
  /// Creates a widget that that gives CometChat ListBase UI
  const CometChatListBase(
      {super.key,
      this.style = const ListBaseStyle(),
      this.backIcon,
      required this.title,
      this.hideSearch = false,
      this.searchBoxIcon,
      required this.container,
      this.showBackButton = false,
      this.onSearch,
      this.menuOptions,
      this.placeholder,
      this.searchText,
      this.theme,
      this.onBack,
      this.hideAppBar = false});

  ///[style] styling properties
  final ListBaseStyle style;

  ///[showBackButton] show back button
  final bool? showBackButton;

  ///[placeholder] hint text to be shown in search box
  final String? placeholder;

  ///[backIcon] back button icon
  final Widget? backIcon;

  ///[title] title string
  final String title;

  ///[hideSearch] show the search box
  final bool? hideSearch;

  ///[searchBoxIcon] search box prefix icon
  final Widget? searchBoxIcon;

  ///[container] listview of users
  final Widget container;

  ///[menuOptions] list of widgets options to be shown
  final List<Widget>? menuOptions;

  ///[onSearch] onSearch callback
  final void Function(String val)? onSearch;

  ///[searchText] initial text to be searched
  final String? searchText;

  ///[onBack] callback triggered on closing a screen
  final VoidCallback? onBack;

  ///[theme] to specify custom theme
  final CometChatTheme? theme;

  ///[theme] to specify custom theme
  final bool? hideAppBar;

  /// returns back button to be shown in appbar
  Widget? getBackButton(context, CometChatTheme theme) {
    Widget? backButton;
    if (showBackButton != null && showBackButton == true) {
      backButton = IconButton(
          onPressed: onBack ??
              () {
                Navigator.pop(context);
              },
          color: style.backIconTint,
          icon: backIcon ??
              Image.asset(
                AssetConstants.back,
                package: UIConstants.packageName,
                color: style.backIconTint ?? theme.palette.getPrimary(),
              ));
    }
    return backButton;
  }

  @override
  Widget build(BuildContext context) {
    CometChatTheme theme = this.theme ?? cometChatTheme;

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: style.gradient,
            border: style.border,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 0)),
        child: Scaffold(
          //appbar with back button and menu options

          appBar: hideAppBar == true
              ? null
              : AppBar(
                  elevation: 0,
                  toolbarHeight: 56,
                  title: Text(
                    title,
                    style: style.titleStyle ??
                        TextStyle(
                            fontWeight: theme.typography.title1.fontWeight,
                            fontSize: theme.typography.title1.fontSize,
                            color: theme.palette.getAccent()),
                  ),
                  backgroundColor: style.gradient != null
                      ? Colors.transparent
                      : style.background ?? theme.palette.getBackground(),
                  //  backgroundColor: style.background ?? _theme.palette.getBackground(),
                  leading: getBackButton(context, theme),
                  automaticallyImplyLeading: showBackButton ?? false,
                  actions: menuOptions ?? [],
                ),

          backgroundColor: style.gradient != null
              ? Colors.transparent
              : style.background ?? theme.palette.getBackground(),
          body: Padding(
            padding:
                style.padding ?? const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              height: style.height,
              width: style.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-----------------------------------
                  //----------show search box----------
                  if (hideSearch == false)
                    SizedBox(
                      height: 42,
                      child: Center(
                        child: TextField(
                          //--------------------------------------
                          //----------on search callback----------
                          controller: TextEditingController(text: searchText),
                          onChanged: onSearch,
                          keyboardAppearance:
                              theme.palette.mode == PaletteThemeModes.light
                                  ? Brightness.light
                                  : Brightness.dark,
                          style: style.searchTextStyle ??
                              TextStyle(
                                  color: theme.palette.getAccent(),
                                  fontSize: theme.typography.body.fontSize,
                                  fontWeight: theme.typography.body.fontWeight),

                          //-----------------------------------------
                          //----------search box decoration----------
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              hintText: placeholder ??
                                  Translations.of(context).search,
                              prefixIcon: searchBoxIcon ??
                                  Icon(
                                    Icons.search,
                                    color: style.searchIconTint ??
                                        theme.palette.getAccent600(),
                                  ),
                              prefixIconColor: style.searchIconTint,
                              hintStyle:
                                  // style.searchTextStyle ??
                                  style.searchPlaceholderStyle ??
                                      TextStyle(
                                          color: theme.palette.getAccent600(),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),

                              //-------------------------------------
                              //----------search box border----------
                              focusedBorder: OutlineInputBorder(
                                  borderSide: style.searchBorderColor == null
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: style.searchBorderColor!,
                                          width: style.searchBorderWidth ?? 1),
                                  borderRadius: BorderRadius.circular(
                                      style.searchBoxRadius ?? 28)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: style.searchBorderColor == null
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: style.searchBorderColor!,
                                          width: style.searchBorderWidth ?? 1),
                                  borderRadius: BorderRadius.circular(
                                      style.searchBoxRadius ?? 28)),
                              border: OutlineInputBorder(
                                  borderSide: style.searchBorderColor == null
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: style.searchBorderColor!,
                                          width: style.searchBorderWidth ?? 1),
                                  borderRadius: BorderRadius.circular(
                                      style.searchBoxRadius ?? 28)),

                              //-----------------------------------------
                              //----------search box fill color----------
                              fillColor: style.searchBoxBackground ?? theme.palette.getAccent100(),
                              filled: true),
                        ),
                      ),
                    ),

                  //--------------------------------
                  //----------showing list----------
                  Expanded(child: container)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
