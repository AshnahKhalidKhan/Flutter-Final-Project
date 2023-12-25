class User 
{
  final String id;
  final String name;
  final String email;
  final String role; //admin, GDSC member, GDSC lead
  final String? campus;
  final bool? approved;

  User
  (
    {
      required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.campus,
      required this.approved
    }
  );
}
