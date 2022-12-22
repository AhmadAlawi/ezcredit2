class CarLeaseModel {
  String? vehicleModel;
  String? vehicleBrand;
  String? vehicleColor;
  String? vehicleYear;
  String? condition;
  String? estimatedPrice;
  String? vehicleLicence;
  String? vinNo;
  String? plateNo;

  CarLeaseModel({
    this.vehicleModel,
    this.vehicleBrand,
    this.vehicleColor,
    this.vehicleYear,
    this.condition,
    this.estimatedPrice,
    this.vehicleLicence,
    this.vinNo,
    this.plateNo,
  });

  CarLeaseModel.fromJson(Map<String, dynamic> json) {
    vehicleModel = json['vehiclemodel'];
    vehicleBrand = json['vehiclebrand'];
    vehicleColor = json['vehiclecolor'];
    vehicleYear = json['vehicleyear'];
    condition = json['condition'];
    estimatedPrice = json['estprice'];
    vehicleLicence = json['vehiclelicence'];
    vinNo = json['vinno'];
    plateNo = json['plateno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehiclemodel'] = vehicleModel;
    data['vehiclebrand'] = vehicleBrand;
    data['vehiclecolor'] = vehicleColor;
    data['vehicleyear'] = vehicleYear;
    data['condition'] = condition;
    data['estprice'] = estimatedPrice;
    data['vehiclelicence'] = vehicleLicence;
    data['vinno'] = vinNo;
    data['plateno'] = plateNo;

    return data;
  }
}
