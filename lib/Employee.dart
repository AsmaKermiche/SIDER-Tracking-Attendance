class Employee {
  String matricule;
  int iddep;

  Employee({
    required this.matricule,
    required this.iddep,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        matricule: json['matricule'].toString(),
        iddep: json['iddep'],
    );
  }
}

