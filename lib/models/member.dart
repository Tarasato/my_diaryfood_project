// ignore_for_file: prefer_collection_literals, unnecessary_this

class Member {
  String? message;
  String? memid;
  String? memFullname;
  String? memEmail;
  String? memUsername;
  String? memPassword;
  String? memAge;

  Member(
      {this.message,
      this.memid,
      this.memFullname,
      this.memEmail,
      this.memUsername,
      this.memPassword,
      this.memAge});

  Member.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    memid = json['memid'];
    memFullname = json['memFullname'];
    memEmail = json['memEmail'];
    memUsername = json['memUsername'];
    memPassword = json['memPassword'];
    memAge = json['memAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['memid'] = this.memid;
    data['memFullname'] = this.memFullname;
    data['memEmail'] = this.memEmail;
    data['memUsername'] = this.memUsername;
    data['memPassword'] = this.memPassword;
    data['memAge'] = this.memAge;
    return data;
  }
}