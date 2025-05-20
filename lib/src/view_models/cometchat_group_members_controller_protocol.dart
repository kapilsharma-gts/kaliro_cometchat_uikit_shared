import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

abstract class CometChatGroupMembersControllerProtocol
    extends CometChatSearchListControllerProtocol<GroupMember> {
  //default functions
  List<CometChatOption> defaultFunction(Group group, GroupMember member);
}
