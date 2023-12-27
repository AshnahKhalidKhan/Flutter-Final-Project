class Discussion 
{
  final String eventId;
  final DateTime timestamp;
  final String senderId;
  final String message;

  Discussion
  (
    {
      required this.eventId,
      required this.timestamp,
      required this.senderId,
      required this.message,
    }
  );
}
