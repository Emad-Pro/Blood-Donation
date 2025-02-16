class UserPointModel {
  final String uId;
  final int point;

  UserPointModel({required this.uId, required this.point});

  factory UserPointModel.fromJson(Map<String, dynamic> json) {
    return UserPointModel(
      uId: json['uId'],
      point: json['point'],
    );
  }
}
