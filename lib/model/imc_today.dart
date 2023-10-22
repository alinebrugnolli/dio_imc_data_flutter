import 'dart:convert';

class ImcToday {
  int? id;
  DateTime dateTime = DateTime.now();
  double imc = 0.0;
  ImcToday(
    this.id,
    this.dateTime,
    this.imc,
  );

  ImcToday.empty();

  ImcToday copyWith({
    int? id,
    DateTime? dateTime,
    double? imc,
  }) {
    return ImcToday(
      id ?? this.id,
      dateTime ?? this.dateTime,
      imc ?? this.imc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'imc': imc.round(),
    };
  }

  factory ImcToday.fromMap(Map<String, dynamic> map) {
    return ImcToday(
      map['id'],
      DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      map['imc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImcToday.fromJson(String source) =>
      ImcToday.fromMap(json.decode(source));

  @override
  String toString() => 'ImcToday(id: $id, dateTime: $dateTime, imc: $imc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImcToday &&
        other.dateTime.year == dateTime.year &&
        other.dateTime.month == dateTime.month &&
        other.dateTime.day == dateTime.day;
  }

  @override
  int get hashCode => id.hashCode;
}
