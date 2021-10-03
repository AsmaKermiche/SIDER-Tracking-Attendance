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



/*Future<void> fetchDates() async {
    var url = "http://192.168.1.10/flutter_login_signup/date.php";

    var data = {'matricule': widget.matricule};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
     List<Date>  date = items.map<Date>((json) {
        return Date.fromJson(json);
      }).toList();
      date.forEach((element) {
        if(!listValues.contains(element.date))
        listValues.add(element.date);
      });
      List<DateTime> dateTimeList =[];
      var formatter = new DateFormat('dd-MM-yyyy');

      listValues.forEach((element) {
        dateTimeList.add(formatter.parse(element));
      });
      print(dateTimeList);
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }*/

