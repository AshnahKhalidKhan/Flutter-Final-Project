class Draft {
  final String eventId;
  final String draftType;
  final String content;
  final DateTime? scheduledTime;
  final List<String> attachments;

  Draft({
    required this.eventId,
    required this.draftType,
    required this.content,
    this.scheduledTime,
    required this.attachments,
  });
}
