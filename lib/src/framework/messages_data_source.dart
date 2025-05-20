import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart' as cc;

///[MessagesDataSource] is a Utility class that provides
///default templates to construct message bubbles and also provides
///the default set of options available for each message bubble
class MessagesDataSource implements DataSource {
  CometChatMessageOption getEditOption(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.editMessage,
        title: Translations.of(context).edit,
        icon: AssetConstants.edit,
        packageName: UIConstants.packageName);
  }

  CometChatMessageOption getDeleteOption(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.deleteMessage,
        title: Translations.of(context).delete,
        icon: AssetConstants.delete,
        titleStyle: const TextStyle(
          color: Colors.red,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        iconTint: Colors.red,
        packageName: UIConstants.packageName);
  }

  // CometChatMessageOption getReplyOption(BuildContext context) {
  //   return CometChatMessageOption(
  //       id: MessageOptionConstants.replyMessage,
  //       title: Translations.of(context).reply,
  //       icon: AssetConstants.reply,
  //       packageName: UIConstants.packageName);
  // }

  CometChatMessageOption getReplyInThreadOption(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.replyInThreadMessage,
        title: Translations.of(context).reply,
        icon: AssetConstants.thread,
        packageName: UIConstants.packageName);
  }

  CometChatMessageOption getShareOption(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.shareMessage,
        title: Translations.of(context).share,
        icon: AssetConstants.share,
        packageName: UIConstants.packageName);
  }

  CometChatMessageOption getCopyOption(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.copyMessage,
        title: Translations.of(context).copy,
        icon: AssetConstants.copy,
        packageName: UIConstants.packageName);
  }

  CometChatMessageOption getMessageInfo(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.messageInformation,
        title: Translations.of(context).info,
        icon: AssetConstants.info,
        packageName: UIConstants.packageName);
  }

  // CometChatMessageOption getForwardOption(BuildContext context) {
  //   return CometChatMessageOption(
  //       id: MessageOptionConstants.forwardMessage,
  //       title: Translations.of(context).forward,
  //       icon: AssetConstants.forward,
  //       packageName: UIConstants.packageName);
  // }

  CometChatMessageOption getSendMessagePrivately(BuildContext context) {
    return CometChatMessageOption(
        id: MessageOptionConstants.sendMessagePrivately,
        title: Translations.of(context).messagePrivately,
        icon: AssetConstants.replyPrivately,
        packageName: UIConstants.packageName);
  }

  bool isSentByMe(User loggedInUser, BaseMessage message) {
    return loggedInUser.uid == message.sender?.uid;
  }

  @override
  List<CometChatMessageOption> getTextMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.replyInThreadMessage)) {
      messageOptionList.add(getReplyInThreadOption(context));
    }
    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.shareMessage)) {
      messageOptionList.add(getShareOption(context));
    }

    messageOptionList.add(getCopyOption(context));

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.editMessage)) {
      messageOptionList.add(getEditOption(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.messageInformation)) {
      messageOptionList.add(getMessageInfo(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.deleteMessage)) {
      messageOptionList.add(getDeleteOption(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.sendMessagePrivately)) {
      messageOptionList.add(getSendMessagePrivately(context));
    }
    return messageOptionList;
  }

  @override
  List<CometChatMessageOption> getImageMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];
    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));
    // messageOptionList.add(getForwardOption(context));
    return messageOptionList;
  }

  @override
  List<CometChatMessageOption> getVideoMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];
    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));
    // messageOptionList.add(getForwardOption(context));
    return messageOptionList;
  }

  @override
  List<CometChatMessageOption> getAudioMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];
    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));
    // messageOptionList.add(getForwardOption(context));
    return messageOptionList;
  }

  @override
  List<CometChatMessageOption> getFileMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];
    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));
    // messageOptionList.add(getForwardOption(context));
    return messageOptionList;
  }

  @override
  Widget getDeleteMessageBubble(BaseMessage messageObject, CometChatTheme theme) {
    return CometChatDeleteMessageBubble(
      style: DeletedBubbleStyle(
        textStyle: TextStyle(
            color: theme.palette.getAccent400(),
            fontSize: theme.typography.text1.fontSize,
            fontWeight: theme.typography.body.fontWeight),
        borderColor: theme.palette.getAccent200(),
      ),
    );
  }

  Widget getGroupActionBubble(BaseMessage messageObject, CometChatTheme theme) {
    cc.Action actionMessage = messageObject as cc.Action;
    return CometChatGroupActionBubble(
      text: actionMessage.message,
      style: GroupActionBubbleStyle(
          textStyle: TextStyle(
              fontSize: theme.typography.subtitle2.fontSize,
              fontWeight: theme.typography.subtitle2.fontWeight,
              color: theme.palette.getAccent600())),
      theme: theme,
    );
  }

  @override
  Widget getBottomView(BaseMessage message, BuildContext context, BubbleAlignment alignment) {
    return const SizedBox();
  }

  @override
  CometChatMessageTemplate getTextMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
      // name: MessageTypeConstants.text,
      type: MessageTypeConstants.text,
      category: MessageCategoryConstants.message,
      contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
          {AdditionalConfigurations? additionalConfigurations}) {
        TextMessage textMessage = message as TextMessage;
        if (message.deletedAt != null) {
          return getDeleteMessageBubble(message, theme);
        }

        return CometChatUIKit.getDataSource().getTextMessageContentView(textMessage, context, alignment, theme,
            additionalConfigurations: additionalConfigurations);
      },
      options: CometChatUIKit.getDataSource().getMessageOptions,
      bottomView: CometChatUIKit.getDataSource().getBottomView,
    );
  }

  @override
  Widget getTextMessageContentView(
      TextMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme,
      {AdditionalConfigurations? additionalConfigurations}) {
    return CometChatUIKit.getDataSource().getTextMessageBubble(message.text, message, context, alignment, theme, null,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget getFormMessageContentView(
      FormMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getFormMessageBubble(message: message, theme: theme);
  }

  @override
  CometChatMessageTemplate getAudioMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.audio,
        category: MessageCategoryConstants.message,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          MediaMessage audioMessage = message as MediaMessage;
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }

          return CometChatUIKit.getDataSource().getAudioMessageContentView(audioMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  CometChatMessageTemplate getVideoMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.video,
        category: MessageCategoryConstants.message,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }

          return CometChatUIKit.getDataSource()
              .getVideoMessageContentView(message as MediaMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  CometChatMessageTemplate getImageMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.image,
        category: MessageCategoryConstants.message,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }

          return CometChatUIKit.getDataSource()
              .getImageMessageContentView(message as MediaMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  CometChatMessageTemplate getGroupActionTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.groupActions,
        category: MessageCategoryConstants.action,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          return getGroupActionBubble(message, theme);
        });
  }

  CometChatMessageTemplate getDefaultMessageActionsTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
      type: MessageTypeConstants.message,
      category: MessageCategoryConstants.action,
    );
  }

  @override
  CometChatMessageTemplate getFileMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.file,
        category: MessageCategoryConstants.message,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }

          return CometChatUIKit.getDataSource()
              .getFileMessageContentView(message as MediaMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  CometChatMessageTemplate getFormMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        // name: MessageTypeConstants.text,
        type: MessageTypeConstants.form,
        category: MessageCategoryConstants.interactive,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }
          FormMessage formMessage = message as FormMessage;
          return CometChatUIKit.getDataSource().getFormMessageContentView(formMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getFormMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  CometChatMessageTemplate getSchedulerMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        type: MessageTypeConstants.scheduler,
        category: MessageCategoryConstants.interactive,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }
          SchedulerMessage meetingMessage = message as SchedulerMessage;
          return CometChatUIKit.getDataSource()
              .getSchedulerMessageContentView(meetingMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getSchedulerMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  List<CometChatMessageTemplate> getAllMessageTemplates({CometChatTheme? theme}) {
    CometChatTheme theme0 = theme ?? cometChatTheme;
    return [
      CometChatUIKit.getDataSource().getTextMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getImageMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getVideoMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getAudioMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getFileMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getGroupActionTemplate(theme0),
      CometChatUIKit.getDataSource().getFormMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getCardMessageTemplate(theme0),
      CometChatUIKit.getDataSource().getSchedulerMessageTemplate(theme0),
    ];
  }

  @override
  CometChatMessageTemplate? getMessageTemplate(
      {required String messageType, required String messageCategory, CometChatTheme? theme}) {
    CometChatTheme theme0 = theme ?? cometChatTheme;

    CometChatMessageTemplate? template;
    if (messageCategory != MessageCategoryConstants.call) {
      if (messageCategory == MessageCategoryConstants.interactive) {
        switch (messageType) {
          case MessageTypeConstants.card:
            template = CometChatUIKit.getDataSource().getCardMessageTemplate(theme0);
            break;
          case MessageTypeConstants.form:
            template = CometChatUIKit.getDataSource().getFormMessageTemplate(theme0);
            break;
        }
      } else {
        switch (messageType) {
          case MessageTypeConstants.text:
            template = CometChatUIKit.getDataSource().getTextMessageTemplate(theme0);
            break;
          case MessageTypeConstants.image:
            template = CometChatUIKit.getDataSource().getImageMessageTemplate(theme0);
            break;
          case MessageTypeConstants.video:
            template = CometChatUIKit.getDataSource().getVideoMessageTemplate(theme0);
            break;
          case MessageTypeConstants.groupActions:
            template = CometChatUIKit.getDataSource().getGroupActionTemplate(theme0);
            break;
          case MessageTypeConstants.file:
            template = CometChatUIKit.getDataSource().getFileMessageTemplate(theme0);
            break;
          case MessageTypeConstants.audio:
            template = CometChatUIKit.getDataSource().getAudioMessageTemplate(theme0);
            break;
        }
      }
    }

    return template;
  }

  @override
  List<CometChatMessageOption> getMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> optionList = [];

    if (messageObject.category == MessageCategoryConstants.message) {
      switch (messageObject.type) {
        case MessageTypeConstants.text:
          optionList =
              CometChatUIKit.getDataSource().getTextMessageOptions(loggedInUser, messageObject, context, group);
          break;
        case MessageTypeConstants.image:
          optionList =
              CometChatUIKit.getDataSource().getImageMessageOptions(loggedInUser, messageObject, context, group);
          break;
        case MessageTypeConstants.video:
          optionList =
              CometChatUIKit.getDataSource().getVideoMessageOptions(loggedInUser, messageObject, context, group);
          break;
        case MessageTypeConstants.groupActions:
          optionList = [];
          break;
        case MessageTypeConstants.file:
          optionList =
              CometChatUIKit.getDataSource().getFileMessageOptions(loggedInUser, messageObject, context, group);
          break;
        case MessageTypeConstants.audio:
          optionList =
              CometChatUIKit.getDataSource().getAudioMessageOptions(loggedInUser, messageObject, context, group);
          break;
      }
    } else if (messageObject.category == MessageCategoryConstants.custom) {
      optionList = CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group);
    }
    return optionList;
  }

  bool _validateOption(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group, String optionId) {
    if (MessageOptionConstants.replyInThreadMessage == optionId && messageObject.parentMessageId == 0) {
      return true;
    }

    if (MessageOptionConstants.shareMessage == optionId &&
        (messageObject is TextMessage || messageObject is MediaMessage)) {
      return true;
    }

    if (MessageOptionConstants.copyMessage == optionId && messageObject is TextMessage) {
      return true;
    }

    bool isSendMyMeOption = isSentByMe(loggedInUser, messageObject);

    if (MessageOptionConstants.messageInformation == optionId && isSendMyMeOption) {
      return true;
    }

    bool memberIsNotParticipant =
        (group != null) && ((group.owner == loggedInUser.uid) || (group.scope != GroupMemberScope.participant));

    if (MessageOptionConstants.deleteMessage == optionId &&
        (isSendMyMeOption == true || memberIsNotParticipant == true)) {
      return true;
    }

    if (MessageOptionConstants.editMessage == optionId &&
        (isSendMyMeOption == true || memberIsNotParticipant == true)) {
      return true;
    }

    if (MessageOptionConstants.copyMessage == optionId && messageObject is TextMessage) {
      return true;
    }

    if (MessageOptionConstants.sendMessagePrivately == optionId &&
        group != null &&
        loggedInUser.uid != messageObject.sender?.uid) {
      return true;
    }

    return false;
  }

  @override
  List<CometChatMessageOption> getCommonOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.replyInThreadMessage)) {
      messageOptionList.add(getReplyInThreadOption(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.shareMessage)) {
      messageOptionList.add(getShareOption(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.messageInformation)) {
      messageOptionList.add(getMessageInfo(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.deleteMessage)) {
      messageOptionList.add(getDeleteOption(context));
    }

    if (_validateOption(loggedInUser, messageObject, context, group, MessageOptionConstants.sendMessagePrivately)) {
      messageOptionList.add(getSendMessagePrivately(context));
    }

    return messageOptionList;
  }

  @override
  String getMessageTypeToSubtitle(String messageType, BuildContext context) {
    String subtitle = messageType;
    switch (messageType) {
      case MessageTypeConstants.text:
        subtitle = Translations.of(context).text;
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
        break;
    }
    return subtitle;
  }

  // @override
  // List<CometChatMessageComposerAction> getAttachmentOptions(
  //     CometChatTheme theme, BuildContext context,
  //     {User? user, Group? group}) {
  //   List<CometChatMessageComposerAction> actions = [
  //     CometChatMessageComposerAction(
  //       id: MessageTypeConstants.takePhoto,
  //       title: Translations.of(context).take_photo,
  //       iconUrl: AssetConstants.photoLibrary,
  //       iconUrlPackageName: UIConstants.packageName,
  //       titleStyle: TextStyle(
  //           color: theme.palette.getAccent(),
  //           fontSize: theme.typography.subtitle1.fontSize,
  //           fontWeight: theme.typography.subtitle1.fontWeight),
  //       iconTint: theme.palette.getAccent700(),
  //     ),
  //     CometChatMessageComposerAction(
  //       id: MessageTypeConstants.photoAndVideo,
  //       title: Translations.of(context).photo_and_video_library,
  //       iconUrl: AssetConstants.photoLibrary,
  //       iconUrlPackageName: UIConstants.packageName,
  //       titleStyle: TextStyle(
  //           color: theme.palette.getAccent(),
  //           fontSize: theme.typography.subtitle1.fontSize,
  //           fontWeight: theme.typography.subtitle1.fontWeight),
  //       iconTint: theme.palette.getAccent700(),
  //     ),
  //     CometChatMessageComposerAction(
  //       id: MessageTypeConstants.file,
  //       title: Translations.of(context).file,
  //       iconUrl: AssetConstants.audio,
  //       iconUrlPackageName: UIConstants.packageName,
  //       titleStyle: TextStyle(
  //           color: theme.palette.getAccent(),
  //           fontSize: theme.typography.subtitle1.fontSize,
  //           fontWeight: theme.typography.subtitle1.fontWeight),
  //       iconTint: theme.palette.getAccent700(),
  //     ),
  //     CometChatMessageComposerAction(
  //       id: MessageTypeConstants.audio,
  //       title: Translations.of(context).audio,
  //       iconUrl: AssetConstants.attachmentFile,
  //       iconUrlPackageName: UIConstants.packageName,
  //       titleStyle: TextStyle(
  //           color: theme.palette.getAccent(),
  //           fontSize: theme.typography.subtitle1.fontSize,
  //           fontWeight: theme.typography.subtitle1.fontWeight),
  //       iconTint: theme.palette.getAccent700(),
  //     )
  //   ];

  //   return actions;
  // }

  @override
  List<String> getAllMessageTypes() {
    return [
      CometChatMessageType.text,
      CometChatMessageType.image,
      CometChatMessageType.audio,
      CometChatMessageType.video,
      CometChatMessageType.file,
      MessageTypeConstants.groupActions,
      MessageTypeConstants.form,
      MessageTypeConstants.card,
      MessageTypeConstants.scheduler
    ];
  }

  String addList() {
    return "<Message Utils>";
  }

  @override
  List<String> getAllMessageCategories() {
    return [CometChatMessageCategory.message, CometChatMessageCategory.action, CometChatMessageCategory.interactive];
  }

  @override
  Widget getAuxiliaryOptions(
      User? user, Group? group, BuildContext context, Map<String, dynamic>? id, CometChatTheme? theme) {
    return const SizedBox();
  }

  @override
  String getId() {
    return "messageUtils";
  }

  @override
  Widget getAudioMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getAudioMessageBubble(
        message.attachment?.fileUrl, message.attachment?.fileName, null, message, context, theme);
  }

  @override
  Widget getFileMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getFileMessageBubble(message.attachment?.fileUrl,
        message.attachment?.fileMimeType, message.attachment?.fileName, message.id, null, message, theme);
  }

  @override
  Widget getImageMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getImageMessageBubble(message.attachment?.fileUrl,
        AssetConstants.imagePlaceholder, message.caption, null, message, null, context, theme);
  }

  @override
  Widget getVideoMessageBubble(String? videoUrl, String? thumbnailUrl, MediaMessage message, Function()? onClick,
      BuildContext context, CometChatTheme theme, VideoBubbleStyle? style) {
    return CometChatVideoBubble(
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      style: style,
    );
  }

  @override
  Widget getVideoMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource()
        .getVideoMessageBubble(message.attachment?.fileUrl, null, message, null, context, theme, null);
  }

  CometChatMessageComposerAction takePhotoOption(CometChatTheme theme, BuildContext context) {
    return CometChatMessageComposerAction(
      id: MessageTypeConstants.takePhoto,
      title: Translations.of(context).takePhoto,
      iconUrl: AssetConstants.photoLibrary,
      iconUrlPackageName: UIConstants.packageName,
      titleStyle: TextStyle(
          color: theme.palette.getAccent(),
          fontSize: theme.typography.subtitle1.fontSize,
          fontWeight: theme.typography.subtitle1.fontWeight),
      iconTint: theme.palette.getAccent700(),
    );
  }

  CometChatMessageComposerAction photoAndVideoLibraryOption(CometChatTheme theme, BuildContext context) {
    return CometChatMessageComposerAction(
      id: MessageTypeConstants.photoAndVideo,
      title: Translations.of(context).photoAndVideoLibrary,
      iconUrl: AssetConstants.photoLibrary,
      iconUrlPackageName: UIConstants.packageName,
      titleStyle: TextStyle(
          color: theme.palette.getAccent(),
          fontSize: theme.typography.subtitle1.fontSize,
          fontWeight: theme.typography.subtitle1.fontWeight),
      iconTint: theme.palette.getAccent700(),
    );
  }

  CometChatMessageComposerAction audioAttachmentOption(CometChatTheme theme, BuildContext context) {
    return CometChatMessageComposerAction(
      id: MessageTypeConstants.audio,
      title: Translations.of(context).audio,
      iconUrl: AssetConstants.audio,
      iconUrlPackageName: UIConstants.packageName,
      titleStyle: TextStyle(
          color: theme.palette.getAccent(),
          fontSize: theme.typography.subtitle1.fontSize,
          fontWeight: theme.typography.subtitle1.fontWeight),
      iconTint: theme.palette.getAccent700(),
    );
  }

  CometChatMessageComposerAction fileAttachmentOption(CometChatTheme theme, BuildContext context) {
    return CometChatMessageComposerAction(
      id: MessageTypeConstants.file,
      title: Translations.of(context).file,
      iconUrl: AssetConstants.attachmentFile,
      iconUrlPackageName: UIConstants.packageName,
      titleStyle: TextStyle(
          color: theme.palette.getAccent(),
          fontSize: theme.typography.subtitle1.fontSize,
          fontWeight: theme.typography.subtitle1.fontWeight),
      iconTint: theme.palette.getAccent700(),
    );
  }

  @override
  List<CometChatMessageComposerAction> getAttachmentOptions(
      CometChatTheme theme, BuildContext context, Map<String, dynamic>? id) {
    List<CometChatMessageComposerAction> actions = [
      takePhotoOption(theme, context),
      photoAndVideoLibraryOption(theme, context),
      audioAttachmentOption(theme, context),
      fileAttachmentOption(theme, context)
    ];

    return actions;
  }

  @override
  Widget getTextMessageBubble(String messageText, TextMessage message, BuildContext context, BubbleAlignment alignment,
      CometChatTheme theme, TextBubbleStyle? style,
      {AdditionalConfigurations? additionalConfigurations}) {
    return CometChatTextBubble(
      text: messageText,
      alignment: alignment,
      theme: theme,
      formatters: additionalConfigurations?.textFormatters,
      style: style ??
          TextBubbleStyle(
            background: style?.background,
            border: style?.border,
            borderRadius: style?.borderRadius,
            gradient: style?.gradient,
            height: style?.height,
            width: style?.width,
            textStyle: TextStyle(
                    color: alignment == BubbleAlignment.right ? Colors.white : theme.palette.getAccent(),
                    fontWeight: theme.typography.body.fontWeight,
                    fontSize: theme.typography.body.fontSize,
                    fontFamily: theme.typography.body.fontFamily)
                .merge(style?.textStyle),
          ),
    );
  }

  @override
  Widget getAudioMessageBubble(String? audioUrl, String? title, AudioBubbleStyle? style, MediaMessage message,
      BuildContext context, CometChatTheme theme) {
    return CometChatAudioBubble(
      style: AudioBubbleStyle(
          background: style?.background,
          border: style?.border,
          borderRadius: style?.borderRadius,
          gradient: style?.gradient,
          height: style?.height,
          width: style?.width,
          pauseIconTint: style?.pauseIconTint,
          playIconTint: style?.playIconTint,
          titleStyle: TextStyle(
                  fontSize: theme.typography.name.fontSize,
                  fontWeight: theme.typography.name.fontWeight,
                  fontFamily: theme.typography.name.fontFamily,
                  color: theme.palette.getAccent())
              .merge(style?.titleStyle),
          subtitleStyle: TextStyle(
                  fontSize: theme.typography.subtitle2.fontSize,
                  fontWeight: theme.typography.subtitle2.fontWeight,
                  fontFamily: theme.typography.subtitle2.fontFamily,
                  color: theme.palette.getAccent600())
              .merge(style?.subtitleStyle)),
      audioUrl: audioUrl,
      title: title,
      key: UniqueKey(),
    );
  }

  @override
  Widget getFileMessageBubble(String? fileUrl, String? fileMimeType, String? title, int? id, FileBubbleStyle? style,
      MediaMessage message, CometChatTheme theme) {
    return CometChatFileBubble(
      key: UniqueKey(),
      fileUrl: fileUrl,
      fileMimeType: fileMimeType,
      style: FileBubbleStyle(
        background: style?.background,
        border: style?.border,
        borderRadius: style?.borderRadius,
        downloadIconTint: style?.downloadIconTint,
        gradient: style?.gradient,
        height: style?.height,
        width: style?.width,
        titleStyle: TextStyle(
                fontSize: theme.typography.name.fontSize,
                fontWeight: theme.typography.name.fontWeight,
                fontFamily: theme.typography.name.fontFamily,
                color: theme.palette.getAccent())
            .merge(style?.titleStyle),
        subtitleStyle: TextStyle(
                fontSize: theme.typography.subtitle2.fontSize,
                fontWeight: theme.typography.subtitle2.fontWeight,
                fontFamily: theme.typography.subtitle2.fontFamily,
                color: theme.palette.getAccent600())
            .merge(style?.subtitleStyle),
      ),
      title: title ?? "",
      id: id,
      theme: theme,
    );
  }

  @override
  Widget getImageMessageBubble(String? imageUrl, String? placeholderImage, String? caption, ImageBubbleStyle? style,
      MediaMessage message, Function()? onClick, BuildContext context, CometChatTheme theme) {
    return CometChatImageBubble(
      key: UniqueKey(),
      imageUrl: imageUrl,
      placeholderImage: placeholderImage,
      caption: caption,
      theme: theme,
      style: style ?? const ImageBubbleStyle(),
      onClick: onClick,
    );
  }

  @override
  Widget getFormMessageBubble({
    String? title,
    FormBubbleStyle? formBubbleStyle,
    required FormMessage message,
    required CometChatTheme theme,
  }) {
    return CometChatFormBubble(
        key: ValueKey(message.muid), formMessage: message, loggedInUser: CometChatUIKit.loggedInUser, theme: theme);
  }

  @override
  String getLastConversationMessage(Conversation conversation, BuildContext context) {
    return ConversationUtils.getLastConversationMessage(conversation, context);
  }

  @override
  Widget getConversationSubtitle(
      Conversation conversation, BuildContext context, CometChatTheme theme, TextStyle? subtitleStyle,
      {AdditionalConfigurations? additionalConfigurations}) {
    TextStyle subtitleStyle0 = subtitleStyle ??
        TextStyle(
            color: theme.palette.getAccent600(),
            fontSize: theme.typography.subtitle1.fontSize,
            fontWeight: theme.typography.subtitle1.fontWeight,
            fontFamily: theme.typography.subtitle1.fontFamily);

    BaseMessage? lastMessage = conversation.lastMessage;
    String? messageCategory = lastMessage?.category;

    if (messageCategory == null || lastMessage == null) {
      return Text(
        "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: subtitleStyle0,
      );
    } else if (lastMessage.deletedBy != null && lastMessage.deletedBy!.trim() != '') {
      return Text(
        Translations.of(context).thisMessageDeleted,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: subtitleStyle0,
      );
    } else {
      String? prefix;
      if (conversation.conversationWith is Group) {
        if (lastMessage.sender?.uid != CometChatUIKit.loggedInUser?.uid) {
          prefix = "${lastMessage.sender?.name}: ";
        } else {
          prefix = "${cc.Translations.of(context).you}: ";
        }
      }

      if (additionalConfigurations != null &&
          additionalConfigurations.textFormatters != null &&
          additionalConfigurations.textFormatters!.isNotEmpty &&
          lastMessage is TextMessage) {
        String text = (lastMessage).text;

        return RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: prefix,
            style: subtitleStyle0,
            children: FormatterUtils.buildTextSpan(
                text, additionalConfigurations.textFormatters, theme, BubbleAlignment.left,
                forConversation: true),
          ),
        );
      } else {
        String? text;

        text = "${prefix ?? ""}${CometChatUIKit.getDataSource().getLastConversationMessage(conversation, context)}";

        return Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: subtitleStyle0,
        );
      }
    }
  }

  @override
  Widget? getAuxiliaryHeaderMenu(BuildContext context, User? user, Group? group, CometChatTheme? theme) {
    return null;
  }

  @override
  Widget getCardMessageBubble(
      {CardBubbleStyle? cardBubbleStyle, required CardMessage message, required CometChatTheme theme}) {
    return CometChatCardBubble(
      cardMessage: message,
      loggedInUser: CometChatUIKit.loggedInUser,
      theme: theme,
    );
  }

  @override
  CometChatMessageTemplate getCardMessageTemplate(CometChatTheme theme) {
    return CometChatMessageTemplate(
        // name: MessageTypeConstants.text,
        type: MessageTypeConstants.card,
        category: MessageCategoryConstants.interactive,
        contentView: (BaseMessage message, BuildContext context, BubbleAlignment alignment,
            {AdditionalConfigurations? additionalConfigurations}) {
          CardMessage cardMessage = message as CardMessage;
          if (message.deletedAt != null) {
            return getDeleteMessageBubble(message, theme);
          }
          return CometChatUIKit.getDataSource().getCardMessageContentView(cardMessage, context, alignment, theme);
        },
        options: CometChatUIKit.getDataSource().getCardMessageOptions,
        bottomView: CometChatUIKit.getDataSource().getBottomView);
  }

  @override
  Widget getCardMessageContentView(
      CardMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getCardMessageBubble(
      message: message,
      theme: theme,
    );
  }

  @override
  List<CometChatMessageOption> getFormMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];

    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));

    return messageOptionList;
  }

  @override
  List<CometChatMessageOption> getCardMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];

    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));

    return messageOptionList;
  }

  @override
  List<CometChatMessageComposerAction> getAIOptions(User? user, Group? group, CometChatTheme theme,
      BuildContext context, Map<String, dynamic>? id, AIOptionsStyle? aiOptionStyle) {
    return [];
  }

  @override
  Widget getSchedulerMessageBubble(
      {String? title, schedulerBubbleStyle, required SchedulerMessage message, required CometChatTheme theme}) {
    return CometChatSchedulerBubble(
      key: ValueKey(message.muid),
      schedulerMessage: message,
      schedulerBubbleStyle: schedulerBubbleStyle,
      theme: theme,
    );
  }

  @override
  Widget getSchedulerMessageContentView(
      SchedulerMessage message, BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return CometChatUIKit.getDataSource().getSchedulerMessageBubble(message: message, theme: theme);
  }

  @override
  List<CometChatMessageOption> getSchedulerMessageOptions(
      User loggedInUser, BaseMessage messageObject, BuildContext context, Group? group) {
    List<CometChatMessageOption> messageOptionList = [];

    messageOptionList
        .addAll(CometChatUIKit.getDataSource().getCommonOptions(loggedInUser, messageObject, context, group));

    return messageOptionList;
  }

  @override
  List<CometChatTextFormatter> getDefaultTextFormatters() {
    return [
      CometChatMentionsFormatter(),
      CometChatEmailFormatter(),
      CometChatPhoneNumberFormatter(),
      CometChatUrlFormatter(),
    ];
  }
}
