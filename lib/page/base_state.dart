import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_template/res/my_styles.dart';
import 'package:my_flutter_template/res/my_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  bool isPageVisible = true;
  bool isDispose = false;
  bool isVip = false;
  bool isVipSeeLikeMe = false;

  @override
  void initState() {
    isDispose = false;
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    isDispose = true;
    WidgetsBinding.instance.removeObserver(this);
    mRefreshController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    isPageVisible = !isPageVisible;
    if (isPageVisible) {
      //onResume
      onResumed();
    } else {
      //onStop
      onStop();
    }
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.inactive:
        onStop();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void onResumed() {}

  void onPaused() {}

  void onStop() {}

  // =================================== ↓ 下拉刷新与上拉加载 ↓ ==========================================
  RefreshController mRefreshController = RefreshController(initialRefresh: false);

  //end 3. 需子类重写
  // 3. 需子类重写
  void dataClear() {}

  // 2. 需子类重写
  Future<int> fetchData() async {
    return 0;
  }

  void onRefreshData() async {
    dataClear();
    var resultSize = await fetchData();

    mRefreshController.resetNoData();
    setState(() {
      mRefreshController.refreshCompleted();
    });
  }

  void _onLoadingData() async {
    var resultSize = await fetchData();

    if (resultSize == 0) {
      mRefreshController.loadNoData();
    } else if (resultSize < 0) {
      mRefreshController.loadFailed();
    } else {
      mRefreshController.loadComplete();
    }
  }

  // start 0. 先在 main 设置全局配置
  // 1. 先写 ListView
  Widget RefresherView(
    Widget child, {
    bool enablePullUpMoreLoad = true,
    bool enablePullDownRefresh = true,
  }) {
    return SmartRefresher(
      enablePullDown: enablePullDownRefresh,
      enablePullUp: enablePullUpMoreLoad,
      controller: mRefreshController,
      onRefresh: onRefreshData,
      onLoading: _onLoadingData,
      child: child,
      footer: ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
    );
  }

  // =================================== ↑ 下拉刷新与上拉加载 ↑ ==========================================

  // =================================== ↓ 常用自定义组件 ↓ ==========================================

  Widget RoundButton(
    String text,
    Function()? onTap, {
    Color? backgroundColor,
    Color? textColor,
    bool isFullWidth = true,
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: ButtonTheme(
        height: 52,
        minWidth: isFullWidth ? double.infinity : 0,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: backgroundColor == null ? MyTheme.main : backgroundColor,
          // elevation: 1,
          highlightElevation: 0,
          disabledElevation: 0,
          onPressed: onTap,
          child: Text(
            text,
            style: MyTextStyles.base(
              size: 16,
              color: textColor == null ? MyTheme.white : textColor,
              isFontWeightBold: true,
              isBold: false,
            ),
          ),
        ),
      ),
    );
  }

// =================================== ↑ 常用自定义组件 ↑ ==========================================
}
