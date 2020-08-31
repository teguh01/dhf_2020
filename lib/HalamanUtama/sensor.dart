class Album {
  final String lahan;

  Album({this.lahan});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      lahan: json['m2m:cin']['con'],
    );
  }
}