// ignore_for_file: prefer_collection_literals, unnecessary_this

class Member {
  String? message;
  String? memId;
  String? memFullname;
  String? memEmail;
  String? memUsername;
  String? memPassword;
  String? memAge;
  String? memImage;

  Member(
      {this.message,
      this.memId,
      this.memFullname,
      this.memEmail,
      this.memUsername,
      this.memPassword,
      this.memAge,
      this.memImage});

  Member.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    memId = json['memId'];
    memFullname = json['memFullname'];
    memEmail = json['memEmail'];
    memUsername = json['memUsername'];
    memPassword = json['memPassword'];
    memAge = json['memAge'];
    memImage = json['memImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['memId'] = this.memId;
    data['memFullname'] = this.memFullname;
    data['memEmail'] = this.memEmail;
    data['memUsername'] = this.memUsername;
    data['memPassword'] = this.memPassword;
    data['memAge'] = this.memAge;
    data['memImage'] = this.memImage;
    return data;
  }
}
