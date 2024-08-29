enum ActionsEvents {
  recordInstruction,
}

class Event {
  Event({
    required this.name,
    this.params,
  });

  final String name;
  final Map<String, Object>? params;
}
