import 'package:flutter/material.dart';
import 'package:my_flutter_template/page/base_state.dart';
import 'package:my_flutter_template/res/my_styles.dart';
import 'package:my_flutter_template/res/my_theme.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends BaseState<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bg_page,
      body: Center(
        child: Text("Me", style: MyTextStyles.textWhite(16)),
      ),
    );
  }
}
