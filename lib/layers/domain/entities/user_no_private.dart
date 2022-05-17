class UserNoPrivate {
  final String name;
  final int id;

  UserNoPrivate({required this.name, required this.id});

  @override
  String toString() => 'name: $name, id: $id';
}
