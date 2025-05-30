import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart' as cc;

///[ConversationUtils] is an Utility class that helps to
///the last message for any conversation and also
///provides the default action to execute on a conversation
class ConversationUtils {
  static List<CometChatOption>? getDefaultOptions(
      Conversation conversation,
      CometChatConversationsControllerProtocol controller,
      BuildContext context,
      CometChatTheme? theme) {
    return [
      CometChatOption(
          id: ConversationOptionConstants.delete,
          icon: AssetConstants.delete,
          packageName: UIConstants.packageName,
          backgroundColor: Colors.red,
          onClick: () {
            controller.deleteConversation(conversation);
          })
    ];
  }

  static String getLastCustomMessage(
      Conversation conversation, BuildContext context) {
    CustomMessage customMessage = conversation.lastMessage as CustomMessage;
    String messageType = customMessage.type;
    String subtitle = '';

    switch (messageType) {
      default:
        subtitle = messageType;
        break;
    }
    return subtitle;
  }

  static String getLastMessage(
      Conversation conversation, BuildContext context) {
    BaseMessage message = conversation.lastMessage!;
    String messageType = message.type;
    String subtitle;

    switch (messageType) {
      case MessageTypeConstants.text:
        subtitle = (message as TextMessage).text;
        if (message.mentionedUsers.isNotEmpty) {
          subtitle = CometChatMentionsFormatter.getTextWithMentions(
              message.text, message.mentionedUsers);
        }

        break;
      case MessageTypeConstants.image:
        subtitle = Translations.of(context).messageImage;
        break;
      case MessageTypeConstants.video:
        subtitle = Translations.of(context).messageVideo;
        break;
      case MessageTypeConstants.file:
        subtitle = Translations.of(context).messageFile;
        break;
      case MessageTypeConstants.audio:
        subtitle = Translations.of(context).messageAudio;
        break;
      default:
        subtitle = messageType;
    }
    return subtitle;
  }

  static String getLastInteractiveMessage(
      Conversation conversation, BuildContext context) {
    BaseMessage message = conversation.lastMessage!;
    String messageType = message.type;
    String subtitle;
    switch (messageType) {
      case MessageTypeConstants.form:
        subtitle = Translations.of(context).formMessage;
        break;
      case MessageTypeConstants.card:
        subtitle = Translations.of(context).cardMessage;
        break;
      case MessageTypeConstants.scheduler:
        SchedulerMessage schedulerMessage =
            SchedulerMessage.fromInteractiveMessage(
                message as InteractiveMessage);
        String meetingMessage =
            SchedulerUtils.getSchedulerTitle(schedulerMessage, context);
        subtitle = "🗓️ $meetingMessage";
        break;
      default:
        subtitle = messageType;
    }
    return subtitle;
  }

  static String getLastActionMessage(
      Conversation conversation, BuildContext context) {
    BaseMessage message = conversation.lastMessage!;
    String subtitle = '';

    if (message.type == MessageTypeConstants.groupActions) {
      cc.Action actionMessage = message as cc.Action;
      subtitle = actionMessage.message as String;
    } else {
      subtitle = message.type as String;
    }

    return subtitle;
  }

  static String getLastCallMessage(
      Conversation conversation, BuildContext context) {
    Call call = conversation.lastMessage as Call;
    User? conversationWithUser;
    Group? conversationWithGroup;

    if (conversation.conversationWith is User) {
      conversationWithUser = conversation.conversationWith as User;
    } else if (conversation.conversationWith is Group) {
      conversationWithGroup = conversation.conversationWith as Group;
    }

    String subtitle = call.type;
    Group? callInitiatorGroup;
    User? callInitiatorUser;
    if (call.callInitiator is User) {
      callInitiatorUser = call.callInitiator as User;
    } else {
      callInitiatorGroup = call.callInitiator as Group;
    }

    if (call.callStatus == CallStatusConstants.ongoing) {
      subtitle = Translations.of(context).ongoingCall;
    } else if (call.callStatus == CallStatusConstants.ended ||
        call.callStatus == CallStatusConstants.initiated) {
      if ((callInitiatorUser != null &&
              conversationWithUser != null &&
              callInitiatorUser.uid == conversationWithUser.uid) ||
          (callInitiatorGroup != null &&
              conversationWithGroup != null &&
              callInitiatorGroup.guid == conversationWithGroup.guid)) {
        if (call.type == MessageTypeConstants.audio) {
          subtitle = Translations.of(context).incomingAudioCall;
        } else {
          subtitle = Translations.of(context).incomingVideoCall;
        }
      } else {
        if (call.type == MessageTypeConstants.audio) {
          subtitle = Translations.of(context).outgoingAudioCall;
        } else {
          subtitle = Translations.of(context).outgoingVdeoCall;
        }
      }
    } else if (call.callStatus == CallStatusConstants.cancelled ||
        call.callStatus == CallStatusConstants.unanswered ||
        call.callStatus == CallStatusConstants.rejected ||
        call.callStatus == CallStatusConstants.busy) {
      if ((callInitiatorUser != null &&
              conversationWithUser != null &&
              callInitiatorUser.uid == conversationWithUser.uid) ||
          (callInitiatorGroup != null &&
              conversationWithGroup != null &&
              callInitiatorGroup.guid == conversationWithGroup.guid)) {
        if (call.type == MessageTypeConstants.audio) {
          subtitle = Translations.of(context).missedVoiceCall;
        } else {
          subtitle = Translations.of(context).missedVideoCall;
        }
      } else {
        if (call.type == MessageTypeConstants.audio) {
          subtitle = Translations.of(context).unansweredAudioCall;
        } else {
          subtitle = Translations.of(context).unansweredVideoCall;
        }
      }
    }
    return subtitle;
  }

  static String getLastConversationMessage(
      Conversation conversation, BuildContext context) {
    String? messageCategory = conversation.lastMessage?.category;
    String subtitle;
    switch (messageCategory) {
      case MessageCategoryConstants.message:
        subtitle = getLastMessage(conversation, context);
        break;
      case MessageCategoryConstants.custom:
        subtitle = getLastCustomMessage(conversation, context);
        break;
      case MessageCategoryConstants.action:
        subtitle = getLastActionMessage(conversation, context);
        break;
      case MessageCategoryConstants.call:
        subtitle = getLastCallMessage(conversation, context);
        break;
      case MessageCategoryConstants.interactive:
        subtitle = getLastInteractiveMessage(conversation, context);
        break;
      default:
        subtitle = conversation.lastMessage!.type;
        break;
    }

    return subtitle;
  }
}
