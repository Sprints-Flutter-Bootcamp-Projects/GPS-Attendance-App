enum UserRole {
  user('user'),
  moderator('moderator'),
  admin('admin');

  final String value;
  const UserRole(this.value);

  factory UserRole.fromString(String value) {
    return values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.user,
    );
  }
  bool get isAdmin => this == admin;
  bool get isModerator => this == moderator;
  bool get isUser => this == user;
}
