import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[AdditionalConfigurations] is a class that can be used to add additional configurations to the UI Kit
/// ```dart
/// AdditionalConfigurations(
///    textFormatters: [
///    CometChatPhoneNumberFormatter(
///    pattern: RegExp(RegexConstants.phoneNumberRegexPattern),
///    onSearch: (phoneNumber) async {
///    await launchUrl(Uri.parse(('tel:$phoneNumber')));
///    },
///    messageBubbleTextStyle: (theme, alignment,{forConversation}) {
///    return TextStyle(
///    color: Colors.pink,
///    );
///    },
///    ),
///    CometChatEmailFormatter(
///    pattern: RegExp(RegexConstants.emailRegexPattern),
///    onSearch: (email) async {
///    await launchUrl(Uri.parse(('mailto:$email')));
///    },
///    messageBubbleTextStyle: (theme, alignment,{forConversation}) {
///    return TextStyle(
///    color: Colors.red,
///    );
///    },
///    ),
///    ],
///    );
///    ```
class AdditionalConfigurations {
  AdditionalConfigurations({this.textFormatters});

  ///[textFormatters] is a list of [CometChatTextFormatter] that can be used to format text
  final List<CometChatTextFormatter>? textFormatters;
}
