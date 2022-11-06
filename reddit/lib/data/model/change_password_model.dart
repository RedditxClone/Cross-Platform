class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;

  ChangePasswordModel({this.oldPassword, this.newPassword});

  /// Map settings comming from web services to the model.
  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  /// Map settings from model to Json to be sent to web services.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}
