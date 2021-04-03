import 'dart:io';
import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_flutter_template/common/config.dart';
import 'package:my_flutter_template/my_app.dart';
import 'package:my_flutter_template/res/my_styles.dart';
import 'package:my_flutter_template/view/loading_widget.dart';
import 'package:my_flutter_template/view/my_page_fade_route_builder.dart';
import 'package:my_flutter_template/view/my_page_slide_route_builder.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUtils {
  static bool isProd() {
    return MyApp.env == ENV.PRODUCTION;
  }

  /// 判断 字符串 是否为空
  static bool isEmpty(String str) {
    return str == null || str.length <= 0;
  }

  /// 邮箱正则
  static const String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 获取当前程序的版本号
  static Future<String> getAppVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 跳转页面
  static Future<Map> startPage(BuildContext context, Widget page) async {
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// 跳转页面，带渐变动画
  static Future<Map> startPageGradient(BuildContext context, Widget page, {int duration = 500}) async {
    return await Navigator.push(context, MyPageFadeTransitionRouteBuilder(page, duration: duration));
  }

  /// 从下往上划出
  static Future<Map> startPageUpAnim(BuildContext context, Widget page, {int duration = 500}) async {
    return await Navigator.push(context, MyPageSlideTransitionRouteBuilder(page, duration: duration));
  }

  /// 跳转到起始页并关闭所有页面
  static Future<Map> startAndRemovePage(BuildContext context, Widget page) async {
    return await Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false,
    );
  }

  static void gotoAppStore() {
    // String appStoreComment = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=${Application.config[Config.APP_ID]}&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8";

    String appStoreComment;
    if (Platform.isIOS) {
      appStoreComment = "itms-apps://itunes.apple.com/app/id${MyApp.config[Config.APP_ID]}?action=write-review";
    } else if (Platform.isAndroid) {
      appStoreComment = "https://play.google.com/store/apps/details?id=${MyApp.config[Config.PACKAGE_NAME]}";
    }
    openUrl(appStoreComment);
  }

  /// 打开 Url
  static void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static exitApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static void popPage(BuildContext context, {Map map}) {
    if (map != null) {
      Navigator.of(context).pop(map);
    } else {
      Navigator.of(context).pop();
    }
  }

  static var logger = Logger();

  /// 打印 log
  static void log(dynamic object, {String method}) {
    if (!MyUtils.isProd()) {
      logger.d(object);
    }
  }

  /// 复制文字
  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    showToast(msg: '复制成功');
  }

  /// 获取剪贴板上的文字
  static String getCopyText() {
    return Clipboard.getData(Clipboard.kTextPlain)?.toString();
  }

  /// 分享
  static void shareText(String content, {String title}) {
    Share.share(content, subject: title);
  }

  /// 显示 Toast
  static void showToast({String msg, bool isLongTime = false}) {
    BotToast.showNotification(
      title: (_) => Text(msg, style: MyTextStyles.text(16), textAlign: TextAlign.center),
      duration: Duration(milliseconds: isLongTime ? 2500 : 1500),
      backgroundColor: Colors.white,
    );
  }

  ///获取本地资源图片
  static String getImage(String imageName, {String format: 'png'}) {
    return "assets/images/$imageName.$format";
  }

  //获取主题颜色
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static bool isLoadingDialog = false;

  /// 隐藏 Dialog
  static void disMissLoadingDialog(BuildContext context) {
    isLoadingDialog = false;

    Navigator.of(context).pop();
  }

  /// 显示Loading
  static void showLoading(BuildContext context, {String loadText = "loading..."}) {
    isLoadingDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return new LoadingWidget(
          outsideDismiss: false,
          loadingText: loadText,
        );
      },
    );
  }

  //Dialog 封装
  static void showAlertDialog(
      BuildContext context,
      String contentText, {
        Function confirmCallback,
        Function dismissCallback,
        String confirmText = "确定",
        String cancelText = "取消",
        String title = "提示",
        bool isShowCancel = true,
        bool isAutoClose = true,
      }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          child: AlertDialog(
            title: Text(title),
            content: Text(contentText),
            actions: <Widget>[
              Offstage(
                offstage: !isShowCancel,
                child: FlatButton(
                  child: Text(cancelText, style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    if (isAutoClose) Navigator.of(context).pop();

                    if (dismissCallback != null) {
                      dismissCallback();
                    }
                  },
                ),
              ),
              FlatButton(
                child: Text(confirmText, style: TextStyle(color: Colors.black)),
                onPressed: () {
                  if (isAutoClose) Navigator.of(context).pop();

                  if (confirmCallback != null) {
                    confirmCallback();
                  }
                },
              )
            ],
            elevation: 20, //阴影
          ),
          onWillPop: () async {
            return Future.value(isAutoClose);
          },
        );
      },
    );
  }

  static Color getRandomColor() {
    Random random = Random();
    var temp = random.nextInt(6);
    List<Color> colors = [
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.redAccent,
      Colors.purpleAccent,
      Colors.lightGreenAccent,
      Colors.deepOrangeAccent,
    ];
    return colors[temp];
  }

  ///递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

  /**
   * 比较APP版本号的大小
   * <p>
   * 1、前者大则返回一个正数
   * 2、后者大返回一个负数
   * 3、相等则返回0
   *
   * @param version1 app版本号
   * @param version2 app版本号
   * @return int
   */
  static int compareAppVersion(String version1, String version2) {
    // 注意此处为正则匹配，不能用.
    List<String> versionArray1 = version1.split("\\.");
    List<String> versionArray2 = version2.split("\\.");
    int idx = 0;
    // 取数组最小长度值
    int minLength = min(versionArray1.length, versionArray2.length);
    int diff = 0;
    // 先比较长度，再比较字符
    while (idx < minLength &&
        (diff = versionArray1[idx].length - versionArray2[idx].length) == 0 &&
        (diff = versionArray1[idx].compareTo(versionArray2[idx])) == 0) {
      ++idx;
    }
    // 如果已经分出大小，则直接返回，如果未分出大小，则再比较位数，有子版本的为大
    diff = (diff != 0) ? diff : versionArray1.length - versionArray2.length;
    return diff;
  }

  static String listToStr(List list) {
    if (list == null || list.length <= 0) return "";

    StringBuffer stringBuffer = new StringBuffer();
    list?.forEach((it) {
      stringBuffer.write(it);
      stringBuffer.write(", ");
    });
    return stringBuffer.toString();
  }

  static String enumToString(o) => o.toString().split('.').last;

  static String getPathSuffixName(String path) {
    return path.substring(path.lastIndexOf(".") + 1);
  }

  static String getPathFileName(String path) {
    return path.substring(path.lastIndexOf("/") + 1);
  }

  static int getRandomDistance() {
    return Random().nextInt(250);
  }

  static int random(int start, int end) {
    Random random = new Random();
    return random.nextInt(end) % (end - start + 1) + start;
  }
}
