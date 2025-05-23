import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///Listener class for [CometChatConversations]
mixin CometChatConversationEventListener implements UIEventHandler {
  ///[ccConversationDeleted] is used to inform the listeners
  ///when the logged-in user deletes a conversation
  void ccConversationDeleted(Conversation conversation) {}
}
