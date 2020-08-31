class SensorAlat {
  final String lahan;

  SensorAlat({this.lahan});

  factory SensorAlat.fromJson(Map<String, dynamic> json) {
    return SensorAlat(
      lahan: json['m2m:cin']['con'],
    );
  }
}