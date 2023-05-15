import 'dart:convert';

import 'package:my_flutter_template/generated/json/base/json_field.dart';
import 'package:my_flutter_template/generated/json/user_data.g.dart';

@JsonSerializable()
class UserData {
	late int id;
	late String userName;
	late String password;
	late String nickName;
	late String icon;
	late int gender;
	late String introduction;
	late String birthday;
	late String phone;
	late String email;
	late String province;
	late String city;
	late int vipGrade;
	late int closeDate;
	late List<dynamic> friends;
	dynamic vipLimitDate;
	late String createTime;
	late String updateTime;

	UserData();

	factory UserData.fromJson(Map<String, dynamic> json) => $UserDataFromJson(json);

	Map<String, dynamic> toJson() => $UserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}