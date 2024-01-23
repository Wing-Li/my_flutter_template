import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'dart:js' as js;
import 'package:my_flutter_template/utils/my_utils.dart';

@JS()
external getMyAddress();

class WebJs {
  void toastMsg(String msg) {
    print("address: $msg");
    MyUtils.showToast(msg);
  }

  getPersonInfo() {
    // 给 JS 提供一个方法
    js.context["toastMsg"] = toastMsg;

    // 调用 JS 方法
    var personInfo = js.context.callMethod('getPersonInfo');
    print("getAddress is $personInfo");
  }

  getMyAddress() async {
    // 调用Js的方法
    try {
      var promise = getMyAddress();
      var result = await promiseToFuture(promise); // 第三个坑
      print("getAddress is $result");
    } catch (e) {
      print("getDeviceInfo错误信息是 $e");
    }
  }
}
