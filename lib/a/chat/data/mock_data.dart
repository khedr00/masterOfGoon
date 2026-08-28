import '../models/chat_user.dart';
import '../models/chat_message.dart';
import '../models/conversation.dart';

enum UserType { employee, salesManager, generalManager, support }

class MockChatData {
  static List<Conversation> getConversations(UserType userType) {
    switch (userType) {
      case UserType.employee:
        return _getEmployeeConversations();
      case UserType.salesManager:
        return _getSalesManagerConversations();
      case UserType.generalManager:
        return _getGeneralManagerConversations();
      case UserType.support:
        return _getSupportConversations();
    }
  }

  static List<Conversation> _getSupportConversations() {
    final generalManager = ChatUser(
      id: 'gm1',
      name: 'General Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: true,
      role: 'GENERAL_MANAGER',
    );

    final salesManager = ChatUser(
      id: 'sm1',
      name: 'Sales Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: true,
      role: 'SALES_MANAGER',
    );

    final now = DateTime.now();

    return [
      Conversation(
        id: 'support_conv_gm',
        user: generalManager,
        lastMessage: ChatMessage(
          id: 'support_gm_msg_2',
          senderId: 'support_me',
          text: 'I will follow up on the open complaints.',
          timestamp: now.subtract(const Duration(minutes: 3)),
          isMe: true,
        ),
        messages: [
          ChatMessage(
            id: 'support_gm_msg_1',
            senderId: generalManager.id,
            text: 'Please keep me updated on urgent complaints.',
            timestamp: now.subtract(const Duration(minutes: 8)),
            isMe: false,
          ),
          ChatMessage(
            id: 'support_gm_msg_2',
            senderId: 'support_me',
            text: 'I will follow up on the open complaints.',
            timestamp: now.subtract(const Duration(minutes: 3)),
            isMe: true,
          ),
        ],
        members: [
          ChatUser(
            id: 'support_me',
            name: 'Support',
            avatar: 'assets/images/profilePhoto-icon.png',
            role: 'SUPPORT',
          ),
          generalManager,
        ],
        type: 'INTERNAL_GROUP',
      ),
      Conversation(
        id: 'support_conv_sm',
        user: salesManager,
        lastMessage: ChatMessage(
          id: 'support_sm_msg_1',
          senderId: salesManager.id,
          text: 'Send me any complaint that needs a sales action.',
          timestamp: now.subtract(const Duration(minutes: 15)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'support_sm_msg_1',
            senderId: salesManager.id,
            text: 'Send me any complaint that needs a sales action.',
            timestamp: now.subtract(const Duration(minutes: 15)),
            isMe: false,
          ),
        ],
        members: [
          ChatUser(
            id: 'support_me',
            name: 'Support',
            avatar: 'assets/images/profilePhoto-icon.png',
            role: 'SUPPORT',
          ),
          salesManager,
        ],
        type: 'INTERNAL_GROUP',
      ),
    ];
  }

  static List<Conversation> _getEmployeeConversations() {
    final generalManager = ChatUser(
      id: 'gm1',
      name: 'General Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: true,
    );

    final salesManager = ChatUser(
      id: 'sm1',
      name: 'Sales Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: false,
    );

    final announcements = ChatUser(
      id: 'announcements',
      name: 'Announcements Channel',
      avatar: 'assets/images/Chat.png',
      isActive: true,
    );

    return [
      Conversation(
        id: 'conv_gm',
        user: generalManager,
        lastMessage: ChatMessage(
          id: 'msg1',
          senderId: 'gm1',
          text: 'Please check the latest property updates.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'msg1',
            senderId: 'gm1',
            text: 'Please check the latest property updates.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            isMe: false,
          ),
          ChatMessage(
            id: 'msg2',
            senderId: 'me',
            text: 'I will review them shortly.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
            isMe: true,
          ),
        ],
      ),
      Conversation(
        id: 'conv_sm',
        user: salesManager,
        lastMessage: ChatMessage(
          id: 'msg3',
          senderId: 'sm1',
          text: 'Meeting at 3 PM today.',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'msg3',
            senderId: 'sm1',
            text: 'Meeting at 3 PM today.',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            isMe: false,
          ),
        ],
      ),
      Conversation(
        id: 'conv_announcements',
        user: announcements,
        lastMessage: ChatMessage(
          id: 'msg4',
          senderId: 'announcements',
          text: 'New property listing available in Downtown area.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'msg4',
            senderId: 'announcements',
            text: 'New property listing available in Downtown area.',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            isMe: false,
          ),
          ChatMessage(
            id: 'msg5',
            senderId: 'announcements',
            text: 'Please review the details.',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            isMe: false,
          ),
        ],
      ),
    ];
  }

  static List<Conversation> _getSalesManagerConversations() {
    final generalManager = ChatUser(
      id: 'gm1',
      name: 'General Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: true,
    );

    final employees = [
      ChatUser(
        id: 'emp1',
        name: 'John Doe',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: true,
      ),
      ChatUser(
        id: 'emp2',
        name: 'Jane Smith',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: false,
      ),
      ChatUser(
        id: 'emp3',
        name: 'Mike Johnson',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: true,
      ),
    ];

    final announcements = ChatUser(
      id: 'announcements',
      name: 'Announcements Channel',
      avatar: 'assets/images/Chat.png',
      isActive: true,
    );

    final conversations = <Conversation>[];

    conversations.add(Conversation(
      id: 'conv_gm',
      user: generalManager,
      lastMessage: ChatMessage(
        id: 'msg1',
        senderId: 'gm1',
        text: 'Sales report needed by end of day.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        isMe: false,
      ),
      messages: [
        ChatMessage(
          id: 'msg1',
          senderId: 'gm1',
          text: 'Sales report needed by end of day.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          isMe: false,
        ),
        ChatMessage(
          id: 'msg2',
          senderId: 'me',
          text: 'I will prepare it.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isMe: true,
        ),
      ],
    ));

    for (var i = 0; i < employees.length; i++) {
      final emp = employees[i];
      conversations.add(Conversation(
        id: 'conv_emp_$i',
        user: emp,
        lastMessage: ChatMessage(
          id: 'msg_${i}_1',
          senderId: emp.id,
          text: 'Hi, I have a question about the property.',
          timestamp: DateTime.now().subtract(Duration(hours: i + 1)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'msg_${i}_1',
            senderId: emp.id,
            text: 'Hi, I have a question about the property.',
            timestamp: DateTime.now().subtract(Duration(hours: i + 1)),
            isMe: false,
          ),
        ],
      ));
    }

    conversations.add(Conversation(
      id: 'conv_announcements',
      user: announcements,
      lastMessage: ChatMessage(
        id: 'msg_ann',
        senderId: 'announcements',
        text: 'New sales targets for this quarter.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isMe: false,
      ),
      messages: [
        ChatMessage(
          id: 'msg_ann',
          senderId: 'announcements',
          text: 'New sales targets for this quarter.',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          isMe: false,
        ),
      ],
    ));

    return conversations;
  }

  static List<Conversation> _getGeneralManagerConversations() {
    final salesManager = ChatUser(
      id: 'sm1',
      name: 'Sales Manager',
      avatar: 'assets/images/profilePhoto-icon.png',
      isActive: true,
    );

    final employees = [
      ChatUser(
        id: 'emp1',
        name: 'John Doe',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: true,
      ),
      ChatUser(
        id: 'emp2',
        name: 'Jane Smith',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: false,
      ),
      ChatUser(
        id: 'emp3',
        name: 'Mike Johnson',
        avatar: 'assets/images/profilePhoto-icon.png',
        isActive: true,
      ),
    ];

    final announcements = ChatUser(
      id: 'announcements',
      name: 'Announcements Channel',
      avatar: 'assets/images/Chat.png',
      isActive: true,
    );

    final conversations = <Conversation>[];

    conversations.add(Conversation(
      id: 'conv_sm',
      user: salesManager,
      lastMessage: ChatMessage(
        id: 'msg1',
        senderId: 'sm1',
        text: 'Monthly report is ready for review.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isMe: false,
      ),
      messages: [
        ChatMessage(
          id: 'msg1',
          senderId: 'sm1',
          text: 'Monthly report is ready for review.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          isMe: false,
        ),
        ChatMessage(
          id: 'msg2',
          senderId: 'me',
          text: 'Thank you, I will review it.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          isMe: true,
        ),
      ],
    ));

    for (var i = 0; i < employees.length; i++) {
      final emp = employees[i];
      conversations.add(Conversation(
        id: 'conv_emp_$i',
        user: emp,
        lastMessage: ChatMessage(
          id: 'msg_${i}_1',
          senderId: emp.id,
          text: 'Good morning!',
          timestamp: DateTime.now().subtract(Duration(hours: i + 2)),
          isMe: false,
        ),
        messages: [
          ChatMessage(
            id: 'msg_${i}_1',
            senderId: emp.id,
            text: 'Good morning!',
            timestamp: DateTime.now().subtract(Duration(hours: i + 2)),
            isMe: false,
          ),
        ],
      ));
    }

    conversations.add(Conversation(
      id: 'conv_announcements',
      user: announcements,
      lastMessage: ChatMessage(
        id: 'msg_ann',
        senderId: 'announcements',
        text: 'Company meeting scheduled for Friday.',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isMe: false,
      ),
      messages: [
        ChatMessage(
          id: 'msg_ann',
          senderId: 'announcements',
          text: 'Company meeting scheduled for Friday.',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          isMe: false,
        ),
      ],
    ));

    return conversations;
  }
}
