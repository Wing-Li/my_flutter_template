import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:my_flutter_template/page/base_state.dart';
import 'package:my_flutter_template/page/message/message_controller.dart';
import 'package:my_flutter_template/page/web/my_webview_page.dart';
import 'package:my_flutter_template/res/my_styles.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

@JS()
external getMyAddress();

class MessagePage extends StatefulWidget {
  final String title;

  const MessagePage({Key? key, this.title = ""}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends BaseState<MessagePage> {
  MessageController controller = Get.put(MessageController());

  @override
  void initState() {
    super.initState();

    if (widget.title == "首页") {
      controller.randomYiyan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildColumn(),
    );
  }

  buildColumn() {
    if (widget.title == "首页") {
      return buildHome();
    } else if (widget.title == "信息") {
      return buildMine();
    } else {
      return Text(widget.title, style: MyTextStyles.textWhite(16));
    }
  }

  void toastMsg(String msg) {
    print("address: $msg");
    MyUtils.showToast(msg);
  }

  Widget buildMine() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              // 给 JS 提供一个方法
              js.context["toastMsg"] = toastMsg;

              // 调用 JS 方法
              var personInfo = js.context.callMethod('getPersonInfo');
              print("getAddress is $personInfo");
            },
            child: Text("js2PersonInfo"),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              // 调用Js的方法
              try {
                var promise = getMyAddress();
                var result = await promiseToFuture(promise); // 第三个坑
                print("getAddress is $result");
              } catch (e) {
                print("getDeviceInfo错误信息是 $e");
              }
            },
            child: Text("getMyAddress"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget buildMy() {
  //   return Container(
  //     child: InAppWebView(
  //       initialUrlRequest: URLRequest(url: Uri.tryParse('https://sugars.zone/')),
  //       onWebViewCreated: (controller) async {
  //         // register a JavaScript handler with name "myHandlerName"
  //         // controller.addJavaScriptHandler(
  //         //     handlerName: 'handleFreeMint',
  //         //     callback: (args) {
  //         //       // print arguments coming from the JavaScript side!
  //         //       print(args);
  //         //
  //         //       // return data to the JavaScript side!
  //         //       return {'bar': 'bar_value', 'baz': 'baz_value'};
  //         //     });
  //
  //         await controller.addWebMessageListener(WebMessageListener(
  //           jsObjectName: "handleFreeMint",
  //           onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {
  //             MyUtils.log("message: $message");
  //             MyUtils.log("sourceOrigin: $sourceOrigin");
  //             // do something about message, sourceOrigin and isMainFrame.
  //             replyProxy.postMessage("Got it!");
  //           },
  //         ));
  //       },
  //       onLoadStop: (controller, url) async {
  //         var result = await controller.evaluateJavascript(source: "foo + bar");
  //         print(result); // 51
  //       },
  //     ),
  //   );
  // }

  Widget buildHome() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(flex: 2),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Text("每日一言", style: MyTextStyles.textWhite(20, isBold: true)),
              SizedBox(height: 10),
              SizedBox(
                width: 0.7.sw,
                child: Obx(
                  () => Text(
                    controller.yiyan.value,
                    style: MyTextStyles.textWhite(16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 0.6.sw,
                child: Obx(
                  () => Text(
                    "———— ${controller.from.value}",
                    style: MyTextStyles.textWhite(16),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        RoundButton(
          "随机",
          width: 0.4.sw,
          () => controller.randomYiyan(),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
