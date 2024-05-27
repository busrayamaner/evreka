class ContainerModel {
  final int fullness;
  final DateTime lastReceivedDate;
  final double latitude;
  final double longitude;

  ContainerModel({
    required this.fullness,
    required this.lastReceivedDate,
    required this.latitude,
    required this.longitude,
  });

  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      fullness: json['fullness'] ?? 0,
      lastReceivedDate: json['lastReceivedDate'].toDate(),
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullness': fullness,
      'lastReceivedDate': lastReceivedDate,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
