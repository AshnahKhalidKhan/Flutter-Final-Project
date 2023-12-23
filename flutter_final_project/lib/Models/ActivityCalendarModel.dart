class ActivityCalendar 
{
  final String id;
  final String name;
  final String campus;
  final DateTime date;
  final Duration startTime;
  final Duration endTime;
  final String venue;
  final String? registrationLink;
  final String? streamingLink;

  ActivityCalendar
  (
    {
      required this.id,
      required this.name,
      required this.campus,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.venue,
      required this.registrationLink,
      required this.streamingLink
    }
  );
}
