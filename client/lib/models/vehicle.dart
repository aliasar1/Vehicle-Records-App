class Vehicle {
  final String id;
  final String name;
  final String variant;

  Vehicle({
    required this.id,
    required this.name,
    required this.variant,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      name: json['name'],
      variant: json['variant'],
    );
  }
}
