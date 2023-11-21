import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:my_flutter_template/page/base_state.dart';
import 'package:my_flutter_template/page/message/message_controller.dart';
import 'package:my_flutter_template/res/my_styles.dart';

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
    } else {
      return Text(widget.title, style: MyTextStyles.textWhite(16));
    }
  }
}
