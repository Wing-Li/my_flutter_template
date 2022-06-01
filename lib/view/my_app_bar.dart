import 'package:flutter/material.dart';
import 'package:my_flutter_template/res/my_theme.dart';

class MyAppBar extends StatefulWidget {
  final Widget? leftWidget;
  final Function? onLeftTap;
  final Widget? titleWidget;
  final Widget? rightWidget;
  final Function? onRightTap;
  final double iconWidth;
  final bool isShowStatusBar;
  final Color bgColor;

  const MyAppBar({
    Key? key,
    this.leftWidget,
    this.onLeftTap,
    this.titleWidget,
    this.rightWidget,
    this.onRightTap,
    this.iconWidth = 40,
    this.isShowStatusBar = true,
    this.bgColor = MyTheme.white,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isShowStatusBar ? MyTheme.status_bar_height + 44 : 44,
      padding: EdgeInsets.only(top: widget.isShowStatusBar ? MyTheme.status_bar_height : 0),
      color: widget.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左
          SizedBox(width: 16),
          _leftWidget(),
          // 中
          Expanded(
            child: Center(
              child: widget.titleWidget == null ? SizedBox() : widget.titleWidget,
            ),
          ),
          // 右
          _rightWidget(),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  _leftWidget() {
    return GestureDetector(
      child: widget.leftWidget != null ? widget.leftWidget : Container(width: widget.iconWidth),
      onTap: () {
        if (widget.onLeftTap != null) widget.onLeftTap!();
      },
    );
  }

  _rightWidget() {
    return GestureDetector(
      child: widget.rightWidget != null ? widget.rightWidget : Container(width: widget.iconWidth),
      onTap: () {
        if (widget.onRightTap != null) widget.onRightTap!();
      },
    );
  }
}
