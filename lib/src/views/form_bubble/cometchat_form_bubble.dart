import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:kaliro_cometchat_uikit_shared/src/utils/action_element_utils.dart';
import 'package:kaliro_cometchat_uikit_shared/src/views/button_element/cometchat_button_element.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A widget for displaying a chat form bubble for category [MessageCategoryConstants.interactive] and type [MessageTypeConstants.form] .
///
/// This widget can be used to display a chat form bubble in a CometChat conversation.
/// It provides various customization options for the appearance and behavior of the form.
class CometChatFormBubble extends StatefulWidget {
  const CometChatFormBubble(
      {super.key,
      this.title,
      this.formBubbleStyle,
      required this.formMessage,
      this.theme,
      this.onSubmitTap,
      this.loggedInUser,
      this.quickViewStyle});

  /// The [formBubbleStyle] property allows you to customize the style of the form bubble.
  final FormBubbleStyle? formBubbleStyle;

  /// The [title] is an optional title for the form.
  final String? title;

  /// The [formMessage] is a required parameter that contains the message to be displayed in the form bubble.
  final FormMessage formMessage;

  /// The [theme] property allows to apply a custom CometChat theme to the form bubble.
  final CometChatTheme? theme;

  /// The [onSubmitTap] property is a callback function that is called when the user submits the form.
  /// It receives a map of form data as an argument.
  final Function(Map<String, dynamic>)? onSubmitTap;

  /// The [loggedInUser] property represents the currently logged-in user.
  final User? loggedInUser;

  /// The [quickViewStyle] property represents the currently logged-in user.
  final QuickViewStyle? quickViewStyle;

  @override
  State<CometChatFormBubble> createState() => _CometChatFormBubbleState();
}

class _CometChatFormBubbleState extends State<CometChatFormBubble> {
  bool isGoalAchieved = false;
  late CometChatTheme theme;
  Map<String, bool?> interactionMap = {};
  List<String> mandatoryElementList = [];
  bool isValidating = false;
  late TextStyle buttonTextStyle;
  late ButtonElementStyle buttonElementStyle;
  late ButtonElementStyle submitButtonElementStyle;
  late SingleSelectStyle singleSelectStyle;
  late DropDownElementStyle dropDownElementStyle;
  late CheckBoxElementStyle checkBoxElementStyle;
  late RadioButtonElementStyle radioButtonElementStyle;
  late TextInputElementStyle textInputStyle;
  late TextStyle labelStyle;
  bool? isSentByMe = false;

  @override
  void initState() {
    theme = widget.theme ?? cometChatTheme;
    isSentByMe = false;
    _populateMap();
    _checkInteractionGoals();
    _populateResponse();
    populateStyles();
    super.initState();
  }

  double screenHeight({var context, double? mulBy}) {
    return MediaQuery.of(context).size.height * mulBy!;
  }

  double screenWidth({var context, double? mulBy}) {
    return MediaQuery.of(context).size.width * mulBy!;
  }

  populateStyles() {
    final TextStyle defaultButtonTextStyle = TextStyle(
        fontSize: theme.typography.title2.fontSize,
        fontWeight: theme.typography.title2.fontWeight,
        fontFamily: theme.typography.title2.fontFamily,
        color: theme.palette.getSecondary());

    final TextStyle textStyle2 = TextStyle(
        fontSize: theme.typography.text2.fontSize,
        fontWeight: theme.typography.text2.fontWeight,
        color: theme.palette.getAccent(),
        fontFamily: theme.typography.text2.fontFamily);

    final TextStyle textStyle3 = TextStyle(
        fontSize: theme.typography.subtitle2.fontSize,
        fontWeight: theme.typography.subtitle2.fontWeight,
        color: theme.palette.getAccent400(),
        fontFamily: theme.typography.subtitle2.fontFamily);

    final TextStyle textStyle4 = TextStyle(
        fontSize: theme.typography.subtitle2.fontSize,
        fontWeight: theme.typography.subtitle2.fontWeight,
        fontFamily: theme.typography.subtitle2.fontFamily,
        color: theme.palette.getAccent200());

    final TextStyle textStyle5 = TextStyle(
        fontSize: theme.typography.subtitle1.fontSize,
        fontWeight: theme.typography.subtitle1.fontWeight,
        fontFamily: theme.typography.subtitle1.fontFamily,
        color: theme.palette.getAccent());

    final TextStyle textStyle6 = TextStyle(
      fontSize: theme.typography.subtitle1.fontSize,
      fontWeight: theme.typography.subtitle1.fontWeight,
      fontFamily: theme.typography.subtitle1.fontFamily,
      color: theme.palette.getAccent(),
    );

    final ButtonElementStyle defaultButtonStyle = ButtonElementStyle(
      height: 35,
      borderRadius: 6,
      buttonTextStyle: defaultButtonTextStyle,
    );

    final SingleSelectStyle defaultSingleSelectStyle = SingleSelectStyle(
      height: 35,
      borderRadius: 6,
      selectedOptionBackground: theme.palette.getBackground(),
      selectedOptionTextStyle: textStyle2,
      optionTextStyle: textStyle3,
    );

    final DropDownElementStyle defaultDropDownStyle = DropDownElementStyle(
        height: 35,
        borderRadius: 6,
        hintTextStyle: textStyle4,
        optionTextStyle: textStyle5,
        background: theme.palette.getBackground(),
        labelStyle: textStyle6);

    final CheckBoxElementStyle defaultCheckBoxElementStyle = CheckBoxElementStyle(
        borderRadius: 6,
        optionTextStyle: textStyle5,
        background: theme.palette.getBackground(),
        labelStyle: textStyle6);

    final RadioButtonElementStyle defaultRadioElementStyle = RadioButtonElementStyle(
      borderRadius: 6,
      optionTextStyle: textStyle5,
      background: theme.palette.getBackground(),
      labelStyle: textStyle6,
    );

    final TextInputElementStyle defaultTextInputStyle = TextInputElementStyle(
      borderRadius: 6,
      height: 35,
      background: theme.palette.getBackground(),
      labelStyle: textStyle6,
      textStyle: textStyle6,
      hintTextStyle: textStyle3,
    );

    buttonElementStyle = widget.formBubbleStyle?.buttonStyle?.merge(defaultButtonStyle) ?? defaultButtonStyle;

    submitButtonElementStyle =
        widget.formBubbleStyle?.submitButtonStyle?.merge(defaultButtonStyle) ?? defaultButtonStyle;

    singleSelectStyle =
        widget.formBubbleStyle?.singleSelectStyle?.merge(defaultSingleSelectStyle) ?? defaultSingleSelectStyle;

    dropDownElementStyle = widget.formBubbleStyle?.dropDownStyle?.merge(defaultDropDownStyle) ?? defaultDropDownStyle;

    textInputStyle = widget.formBubbleStyle?.textInputStyle?.merge(defaultTextInputStyle) ?? defaultTextInputStyle;

    checkBoxElementStyle = defaultCheckBoxElementStyle;

    radioButtonElementStyle = defaultRadioElementStyle;

    labelStyle = textStyle6.merge(widget.formBubbleStyle?.labelStyle);
  }

  //populates the
  _populateMap() {
    if (widget.formMessage.interactions != null) {
      for (var element in widget.formMessage.interactions!) {
        interactionMap[element.elementId] = true;
      }
    }
  }

  _checkInteractionGoals() {
    if (widget.formMessage.interactionGoal != null) {
      bool goalAchieved = false;
      if (goalAchieved != isGoalAchieved) {
        isGoalAchieved = goalAchieved;
      }
    }
  }

  _populateResponse() {}

  Map<String, dynamic>? createResponse() {
    Map<String, dynamic> response = {};

    return response;
  }

  bool validateFields() {
    isValidating = true;

    isValidating = false;
    return true;
  }

  Map<String, dynamic> getCompleteData() {
    Map<String, dynamic> localData = {};
    if (widget.loggedInUser != null) {}

    return localData;
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
      child: SingleChildScrollView(
        child: isGoalAchieved == true
            ? Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 65 / 100),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: theme.palette.getSecondary(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CometChatQuickView(
                                theme: widget.theme,
                                title: widget.formMessage.sender?.name ?? "",
                                subtitle: widget.formMessage.title,
                                quickViewStyle: widget.quickViewStyle ??
                                    (QuickViewStyle(
                                      background: widget.quickViewStyle?.background ?? theme.palette.getBackground(),
                                      titleStyle: widget.quickViewStyle?.titleStyle ??
                                          TextStyle(
                                            fontSize: theme.typography.text2.fontSize,
                                            fontWeight: theme.typography.text2.fontWeight,
                                            fontFamily: theme.typography.text2.fontFamily,
                                            color: theme.palette.getPrimary(),
                                          ),
                                      subtitleStyle: widget.quickViewStyle?.subtitleStyle ??
                                          TextStyle(
                                            fontSize: theme.typography.subtitle2.fontSize,
                                            fontWeight: theme.typography.subtitle2.fontWeight,
                                            fontFamily: theme.typography.subtitle2.fontFamily,
                                            color: theme.palette.getAccent(),
                                          ),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.formMessage.goalCompletionText ??
                                    Translations.of(context).goalAchievedSuccessfully,
                                style: TextStyle(
                                        color: theme.palette.getAccent(),
                                        fontWeight: theme.typography.body.fontWeight,
                                        fontSize: theme.typography.body.fontSize,
                                        fontFamily: theme.typography.body.fontFamily)
                                    .merge(widget.formBubbleStyle?.goalCompletionTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: widget.formBubbleStyle?.height,
                width: widget.formBubbleStyle?.width,
                decoration: BoxDecoration(
                    color: widget.formBubbleStyle?.gradient == null
                        ? widget.formBubbleStyle?.background ?? Colors.transparent
                        : null,
                    gradient: widget.formBubbleStyle?.gradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: theme.palette.getAccent200()))),
                      child: Text(
                        widget.formMessage.title,
                        style: widget.formBubbleStyle?.titleStyle ??
                            TextStyle(
                                fontSize: theme.typography.name.fontSize,
                                fontWeight: theme.typography.name.fontWeight,
                                fontFamily: theme.typography.name.fontFamily,
                                color: theme.palette.getAccent()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: getWidget('', isSubmit: true),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget getWidget(dynamic entity, {bool isSubmit = false}) {
    switch (entity.runtimeType) {
      default:
        return const SizedBox.shrink();
    }
  }

  bool checkDisabled(dynamic element) {
    if (interactionMap[element.elementId] != null && element.disableAfterInteracted == true) {
      return true;
    } else if (isSentByMe == true && widget.formMessage.allowSenderInteraction == false) {
      return true;
    }

    return false;
  }

  Widget getLabel(String label, bool? isOptional) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: theme.typography.text1.fontSize,
              fontWeight: theme.typography.subtitle1.fontWeight,
              fontFamily: theme.typography.text1.fontFamily,
              color: theme.palette.getAccent(),
            ).merge(widget.formBubbleStyle?.titleStyle),
          ),
          if (isOptional == false) getMandatoryMark()
        ],
      ),
    );
  }

  Widget iconContainer(image) {
    return image == null
        ? Container()
        : Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              image,
              height: 20,
            ),
          );
  }

  Widget getMandatoryMark() {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Text(
        "*",
        style: TextStyle(
          fontSize: theme.typography.text1.fontSize,
          fontWeight: theme.typography.text1.fontWeight,
          fontFamily: theme.typography.text1.fontFamily,
          color: theme.palette.getAccent(),
        ).merge(widget.formBubbleStyle?.titleStyle),
      ),
    );
  }

  markInteracted(dynamic interactiveElement) async {
    // InteractiveMessageUtils.markInteracted(interactiveElement, widget.formMessage, interactionMap,
    //     onSuccess: (bool matched) {
    //   _checkInteractionGoals();
    //   setState(() {});
    // });
  }

  buttonOnClick(bool isSubmit, dynamic buttonElement) async {
    if (isSubmit == true) {
      if (validateFields() == false) {
        setState(() {});
        return;
      }
      if (widget.onSubmitTap != null) {
        widget.onSubmitTap!(getCompleteData());
        return;
      }
    }

    if ((widget.onSubmitTap == null && isSubmit == true) || (isSubmit != true)) {
      bool status = false;

      if (status == true) {
        markInteracted(buttonElement);
      }
    }
  }
}
