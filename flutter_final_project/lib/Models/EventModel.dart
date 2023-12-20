class Event {
  final String eventId;
  final String eventName;
  final String date;
  final String venue;
  final String description;
  final List<String> hashtags;
  final String registrationFormLink;
  final String streamingLink;
  final String whatsappGroupLink;
  final String createdBy;
  final List<String> participants;

  Event({
    required this.eventId,
    required this.eventName,
    required this.date,
    required this.venue,
    required this.description,
    required this.hashtags,
    required this.registrationFormLink,
    required this.streamingLink,
    required this.whatsappGroupLink,
    required this.createdBy,
    required this.participants,
  });
}
