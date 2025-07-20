class ChatModel {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      participants: List<String>.from(json['participants']),
      lastMessage: json['lastMessage'],
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
      unreadCount: json['unreadCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
