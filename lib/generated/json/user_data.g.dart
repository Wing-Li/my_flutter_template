
import 'package:my_flutter_template/generated/json/base/json_convert_content.dart';
import 'package:my_flutter_template/net/data/user_data.dart';

UserData $UserDataFromJson(Map<String, dynamic> json) {
	final UserData userData = UserData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userData.id = id;
	}
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		userData.userName = userName;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userData.password = password;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		userData.nickName = nickName;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		userData.icon = icon;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		userData.gender = gender;
	}
	final String? introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		userData.introduction = introduction;
	}
	final String? birthday = jsonConvert.convert<String>(json['birthday']);
	if (birthday != null) {
		userData.birthday = birthday;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		userData.phone = phone;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userData.email = email;
	}
	final String? province = jsonConvert.convert<String>(json['province']);
	if (province != null) {
		userData.province = province;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		userData.city = city;
	}
	final int? vipGrade = jsonConvert.convert<int>(json['vipGrade']);
	if (vipGrade != null) {
		userData.vipGrade = vipGrade;
	}
	final int? closeDate = jsonConvert.convert<int>(json['closeDate']);
	if (closeDate != null) {
		userData.closeDate = closeDate;
	}
	final List<dynamic>? friends = jsonConvert.convertListNotNull<dynamic>(json['friends']);
	if (friends != null) {
		userData.friends = friends;
	}
	final dynamic vipLimitDate = jsonConvert.convert<dynamic>(json['vipLimitDate']);
	if (vipLimitDate != null) {
		userData.vipLimitDate = vipLimitDate;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		userData.createTime = createTime;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		userData.updateTime = updateTime;
	}
	return userData;
}

Map<String, dynamic> $UserDataToJson(UserData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['userName'] = entity.userName;
	data['password'] = entity.password;
	data['nickName'] = entity.nickName;
	data['icon'] = entity.icon;
	data['gender'] = entity.gender;
	data['introduction'] = entity.introduction;
	data['birthday'] = entity.birthday;
	data['phone'] = entity.phone;
	data['email'] = entity.email;
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['vipGrade'] = entity.vipGrade;
	data['closeDate'] = entity.closeDate;
	data['friends'] =  entity.friends;
	data['vipLimitDate'] = entity.vipLimitDate;
	data['createTime'] = entity.createTime;
	data['updateTime'] = entity.updateTime;
	return data;
}