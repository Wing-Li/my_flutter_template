import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_template/page/home/home_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'my_app.dart';
import 'utils/sp_util.dart';

void main() async {
  await _init();

  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyAppPage());

  // 顶部状态栏字体颜色，白色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

Future<Null> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil? spUtil = await SpUtil.getInstance();
  if (spUtil != null) MyApp.sp = spUtil;
}

class MyAppPage extends StatelessWidget {
  Widget initWidget = HomePage();

  MyAppPage() {
    init();
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      //1.调用BotToastInit
      builder: BotToastInit(),
      //2.注册路由观察者
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        textTheme: TextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: initWidget,
    );
  }

// /// 上拉加载与下拉刷新，全局配置子树下的SmartRefresher
// refreshConfiguration(MaterialApp materialApp) {
//   return RefreshConfiguration(
//     headerBuilder: () => WaterDropMaterialHeader(),
//     // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
//     footerBuilder: () => ClassicFooter(),
//     // 配置默认底部指示器
//     headerTriggerDistance: 80.0,
//     // 头部触发刷新的越界距离
//     maxOverScrollExtent: 100,
//     //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
//     maxUnderScrollExtent: 50,
//     // 底部最大可以拖动的范围
//     enableScrollWhenRefreshCompleted: true,
//     //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
//     enableLoadingWhenFailed: true,
//     //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
//     hideFooterWhenNotFull: true,
//     // Viewport不满一屏时,禁用上拉加载更多功能
//     enableBallisticLoad: true,
//     // 可以通过惯性滑动触发加载更多
//     child: materialApp,
//   );
// }
}
