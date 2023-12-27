class Attendance 
{
  final String id;
  final String eventId;
  final String attendeeId;
  final bool present;

  Attendance
  (
    {
      required this.id,
      required this.eventId,
      required this.attendeeId,
      required this.present
    }
  );
}
