import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'common/config.dart';
import 'utils/sp_util.dart';

enum ENV {
  PRODUCTION,
  DEV,
}

class MyApp {
  /// 通过MyApp设计环境变量
  static ENV env = ENV.DEV;

  static late SpUtil sp;
  static EventBus eventBus = EventBus();
  static Logger logger = Logger();

  /// 所有获取配置的唯一入口
  static Map<String, String> get config {
    if (MyApp.env == ENV.PRODUCTION) {
      return {
        Config.APP_ID: '1555000000',
        Config.PACKAGE_NAME: 'com.lyl.test',
      };
    }
    if (MyApp.env == ENV.DEV) {
      return {
        Config.APP_ID: '',
        Config.PACKAGE_NAME: '',
      };
    }
    return {};
  }

  // static String dbPath;
  //
  /// 引入库：  path_provider: ^1.6.28
  // static Future<Null> initDBPath() async {
  //   Directory directory = await getMyAppDocumentsDirectory();
  //   MyApp.dbPath = directory.path + '/ObjectBox';
  // }

  static exitApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
