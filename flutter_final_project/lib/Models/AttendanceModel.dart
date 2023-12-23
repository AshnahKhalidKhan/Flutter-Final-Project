class Attendance 
{
  final String eventId;
  final String attendeeId;
  final bool present;

  Attendance
  (
    {
      required this.eventId,
      required this.attendeeId,
      required this.present
    }
  );
}
