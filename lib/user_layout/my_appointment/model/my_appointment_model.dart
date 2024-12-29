class MyAppointmentModel {
  final int? id;
  final String? name;
  final String? day;
  final String? time;
  final String? unit;
  final String? status;
  final String? hospitalName;

  MyAppointmentModel(
      {this.id,
      this.name,
      this.day,
      this.time,
      this.unit,
      this.status,
      this.hospitalName});

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    return MyAppointmentModel(
        id: json['id'],
        name: json['name'].toString(),
        day: json['day'].toString(),
        time: json['time'].toString(),
        unit: json['unit'].toString(),
        status: json['status'].toString(),
        hospitalName: json['HospitalAuth']['name']);
  }
}
