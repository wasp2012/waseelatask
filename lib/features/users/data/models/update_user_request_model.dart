class UpdateUserRequestModel {
  final String name;
  final String job;

  UpdateUserRequestModel({required this.name, required this.job});

  Map<String, dynamic> toJson() {
    return {'name': name, 'job': job};
  }
}
