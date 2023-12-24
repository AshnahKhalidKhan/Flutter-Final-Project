class Note 
{
  final String eventId;
  final String message;
  final String senderId;
  final DateTime timestamp;

  Note
  (
    {
      required this.eventId,
      required this.message,
      required this.senderId,
      required this.timestamp,
    }
  );
}
