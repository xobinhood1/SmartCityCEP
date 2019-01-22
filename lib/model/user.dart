import 'package:cloud_firestore/cloud_firestore.dart';

enum Gender {
  MALE,
  FEMALE,
  TRANSGENDER
}

enum Persona {
  ADMIN,
  USER
}

class User {

  String userId;
  String userName;
  String userPhoneNumber;
  String userEmail;
  String userWard;
  String userZone;
  String userGeo;
  String userLangPref;
  DateTime userDob;
  String userGender;
  String userPersona;
  DateTime userCreatedOn = DateTime.now();
  DateTime userUpdatedOn;
  String userAadharId;
  String userPanId;

  User(this.userPhoneNumber, this.userId, this.userPersona);

  User.fromSnapShot(DocumentSnapshot snapshot){
    this.userId = snapshot['user_id'];
    this.userName = snapshot['user_name'];
    this.userPhoneNumber = snapshot['user_phone_number'];
    this.userEmail = snapshot['user_email'];
    this.userWard = snapshot['user_ward'];
    this.userZone = snapshot['user_zone'];
    this.userGeo = snapshot['user_geo'];
    this.userLangPref = snapshot['user_lang_pref'];
    this.userDob = snapshot['user_dob'];
    this.userGender = snapshot['user_gender'];
    this.userPersona = snapshot['user_persona'];
    this.userCreatedOn = snapshot['user_created_on'];
    this.userUpdatedOn = snapshot['user_updated_on'];
    this.userAadharId = snapshot['user_aadhar_id'];
    this.userPanId = snapshot['user_pan_id'];
  }

  User.fromJson(Map<String, dynamic> json){
    this.userId = json['user_id'];
    this.userName = json['user_name'];
    this.userPhoneNumber = json['user_phone_number'];
    this.userEmail = json['user_email'];
    this.userWard = json['user_ward'];
    this.userZone = json['user_zone'];
    this.userGeo = json['user_geo'];
    this.userLangPref = json['user_lang_pref'];
    this.userDob = json['user_dob'];
    this.userGender = json['user_gender'];
    this.userPersona = json['user_persona'];
    this.userCreatedOn = json['user_created_on'];
    this.userUpdatedOn = json['user_updated_on'];
    this.userAadharId = json['user_aadhar_id'];
    this.userPanId = json['user_pan_id'];
  }

  Map<String, dynamic> toJson() =>
  {
    'user_id': this.userId,
    'user_name': this.userName,
    'user_phone_number': this.userPhoneNumber,
    'user_email': this.userEmail,
    'user_ward': this.userWard,
    'user_zone': this.userZone,
    'user_geo': this.userGeo,
    'user_lang_pref': this.userLangPref,
    'user_dob': this.userDob,
    'user_gender': this.userGender,
    'user_persona': this.userPersona,
    'user_created_on': this.userCreatedOn,
    'user_updated_on': this.userUpdatedOn,
    'user_aadhar_id': this.userAadharId,
    'user_pan_id': this.userPanId,
  };
}

