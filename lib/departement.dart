class Departement {
  double latitude;
  double longitude;

  Departement({
    required this.latitude,
    required this.longitude,
  });

  double getlatitude(){
    return this.latitude;
  }

  factory Departement.fromJson(Map<String, dynamic> json) {
    return Departement(
        latitude: json['latitude'],
        longitude: json['longitude']
    );
  }
}