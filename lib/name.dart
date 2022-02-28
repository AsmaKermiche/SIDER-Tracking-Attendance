class Name {
  String name = "";

  Name({
    required this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      name: json['name'].toString(),
    );
  }
}

