class ProfileDetailsResModel {
  int? status;
  Data? personalDetails;

  ProfileDetailsResModel({
    this.status,
    this.personalDetails,
  });

  factory ProfileDetailsResModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsResModel(
        status: json["status"],
        personalDetails:
            json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": personalDetails?.toJson(),
      };
}

class Data {
  String? fullName;
  String? phone;
  String? dob;
  dynamic email;
  String? gender;

  Data({
    this.fullName,
    this.phone,
    this.dob,
    this.email,
    this.gender,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["full_name"],
        phone: json["phone"],
        dob: json["dob"],
        email: json["email"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone": phone,
        "dob": dob,
        "email": email,
        "gender": gender,
      };
}
