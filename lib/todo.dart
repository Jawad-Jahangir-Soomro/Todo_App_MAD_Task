class Todo {
  Todo({
    required this.name,
    required this.completed,
    this.date,
    this.time,
  });

  String name;
  bool completed;
  String? date;  // Optional date field
  String? time;  // Optional time field
}
