class ActivityCalendar {
  final String eventId;
  final String activityItem;
  final String? relatedEventId;

  ActivityCalendar({
    required this.eventId,
    required this.activityItem,
    this.relatedEventId,
  });
}
