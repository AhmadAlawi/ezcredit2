class EmploymentModel {
  String? employmentStatus;
  String? employer;
  String? currency;
  int? income;
  int? salary;

  EmploymentModel(
      {this.employmentStatus,
      this.employer,
      this.currency,
      this.income,
      this.salary});

  EmploymentModel.fromJson(Map<String, dynamic> json) {
    employmentStatus = json['employment_status'];
    employer = json['employer'];
    currency = json['currency'];
    income = json['income'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employment_status'] = employmentStatus;
    data['employer'] = employer;
    data['currency'] = currency;
    data['income'] = income;
    data['salary'] = salary;
    return data;
  }
}
