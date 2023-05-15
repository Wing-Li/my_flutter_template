import 'dart:convert';

import 'package:my_flutter_template/generated/json/base/json_field.dart';
import 'package:my_flutter_template/generated/json/base_call_back_data.g.dart';

///
/// Android Studio 的 FlutterJsonBeanFactory 插件生成
///
@JsonSerializable()
class BaseCallBackData<T> {
	late int code;
	late String message;
	late T data;

	BaseCallBackData();

	factory BaseCallBackData.fromJson(Map<String, dynamic> json) => $BaseCallBackDataFromJson<T>(json);

	Map<String, dynamic> toJson() => $BaseCallBackDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
