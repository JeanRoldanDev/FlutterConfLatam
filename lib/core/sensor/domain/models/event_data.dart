import 'package:equatable/equatable.dart';

class EventData extends Equatable {
  const EventData({required this.event, required this.value});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: json['event'] as String,
      value: json['value'] != null ? int.parse(json['value'].toString()) : 0,
    );
  }

  final String event;
  final int value;

  @override
  List<Object> get props => [event, value];
}
