
import 'package:my_flutter_template/generated/json/base/json_convert_content.dart';
import 'package:my_flutter_template/net/data/base_call_back_data.dart';

BaseCallBackData<T> $BaseCallBackDataFromJson<T>(Map<String, dynamic> json) {
	final BaseCallBackData<T> baseCallBackData = BaseCallBackData<T>();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		baseCallBackData.code = code;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		baseCallBackData.message = message;
	}
	final T? data = jsonConvert.convert<T>(json['data']);
	if (data != null) {
		baseCallBackData.data = data;
	}
	return baseCallBackData;
}

Map<String, dynamic> $BaseCallBackDataToJson(BaseCallBackData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['message'] = entity.message;
	data['data'] = entity.data.toJson();
	return data;
}
