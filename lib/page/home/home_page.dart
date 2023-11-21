import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_template/event/home_set_tab_event.dart';
import 'package:my_flutter_template/page/base_state.dart';
import 'package:my_flutter_template/page/me/me_page.dart';
import 'package:my_flutter_template/page/message/message_page.dart';
import 'package:my_flutter_template/res/my_theme.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

import '../../my_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  List<Widget> pages = [
    MessagePage(title: "广场"),
    MessagePage(title: "列表"),
    MessagePage(title: "首页"),
    MessagePage(title: "信息"),
    MePage(),
  ];
  int currentIndex = 2;
  PageController _pageController = new PageController(initialPage: 2);
  bool isShowUnRead = false;

  @override
  void initState() {
    super.initState();

    _initListener();
  }

  _initListener() {
    MyApp.eventBus.on<HomeSetTabEvent>().listen((event) {
      _setTab(event.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    MyTheme.status_bar_height = MediaQuery.of(context).padding.top;
    MyTheme.bottom_bar_height = MediaQuery.of(context).padding.bottom;
    MyTheme.screen_width = MyUtils.getScreenWidth(context);
    double bottomHeight = MyTheme.bottom_bar_height > 5 ? 10 : 0;

    return Scaffold(
      backgroundColor: MyTheme.bg_page,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 64,
            child: PageView(
              physics: NeverScrollableScrollPhysics(), //禁止滑动
              controller: _pageController,
              children: pages,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 82.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(MyUtils.getImage("tab_bg")), fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(color: MyTheme.bg_tab, height: MyTheme.bottom_bar_height),
                      ),
                      Positioned(
                        top: 4,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: MyTheme.transparent,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: _bottomItem(0)),
                              Expanded(child: _bottomItem(1)),
                              Expanded(child: _bottomItem(2)),
                              Expanded(
                                child: Center(
                                  child: Stack(
                                    children: [
                                      _bottomItem(3),
                                      Positioned(
                                        top: 8,
                                        right: 0,
                                        child: isShowUnRead ? ClipOval(child: Container(color: MyTheme.red, width: 8, height: 8)) : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: _bottomItem(4)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(color: MyTheme.bg_tab, height: bottomHeight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem(int index) {
    String tabImageName = "";
    switch (index) {
      case 0:
        tabImageName = currentIndex == index ? "l_global_icon_discover_pressed" : "l_global_icon_discover";
        break;
      case 1:
        tabImageName = currentIndex == index ? "l_global_icon_wholike_pressed" : "l_global_icon_wholike";
        break;
      case 2:
        tabImageName = currentIndex == index ? "l_global_icon_take" : "l_global_icon_take";
        break;
      case 3:
        tabImageName = currentIndex == index ? "l_global_icon_chat_pressed" : "l_global_icon_chat";
        break;
      case 4:
        tabImageName = currentIndex == index ? "l_global_icon_me_pressed" : "l_global_icon_me";
        break;
    }

    double iconW = index == 2 ? 60 : 40;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: iconW,
        margin: EdgeInsets.only(bottom: index == 2 ? 16 : 0),
        alignment: index == 2 ? Alignment.topCenter : Alignment.center,
        child: Image.asset(MyUtils.getImage(tabImageName), height: iconW, fit: BoxFit.fitHeight),
      ),
      onTap: () {
        _setTab(index);
      },
    );
  }

  _setTab(int index) {
    if (currentIndex != index) {
      _gotoPage(index);
      setState(() {
        currentIndex = index;
      });
    }
  }

  _gotoPage(int page) {
    if (_pageController != null) _pageController.jumpToPage(page);
  }
}
