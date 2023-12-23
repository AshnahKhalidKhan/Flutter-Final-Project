class Registration 
{
  final String eventId;
  final String attendeeId;
  final String attendeeName;
  final String attendeeEmail;
  final int attendeePhoneNumber; //Add to WhatsApp Group
  final String? attendeeCNIC;

  Registration
  (
    {
      required this.eventId,
      required this.attendeeId,
      required this.attendeeName,
      required this.attendeeEmail,
      required this.attendeePhoneNumber,
      required this.attendeeCNIC
    }
  );
}
