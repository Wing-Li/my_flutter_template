import 'package:get/get.dart';
import 'package:my_flutter_template/net/api/data_api.dart';
import 'package:my_flutter_template/net/data/yiyan_enity.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

class MessageController extends GetxController {
  final yiyan = "".obs;
  final from = "".obs;

  randomYiyan() async {
    MyUtils.showLoading();
    YiyanData? data = await dataApi.randomYiYan();
    MyUtils.disMissLoadingDialog();

    yiyan.value = data?.content ?? "";
    from.value = data?.origin ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }
}
