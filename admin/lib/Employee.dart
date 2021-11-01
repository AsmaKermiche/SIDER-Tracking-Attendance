class Employee {
  String matricule;

  Employee({
    required this.matricule,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      matricule: json['matricule'].toString(),
    );
  }
}

