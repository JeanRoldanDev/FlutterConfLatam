class EventData {
  EventData({required this.event, required this.value});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'] as String,
      value: json['value'] != null ? int.parse(json['value'].toString()) : 0,
    );
  }

  final String event;
  final int value;
}
