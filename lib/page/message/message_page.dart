import 'package:flutter/material.dart';
import 'package:my_flutter_template/res/my_styles.dart';

class MessagePage extends StatefulWidget {
  final String title;

  const MessagePage({Key key, this.title}) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title, style: MyTextStyles.textWhite(16)),
    );
  }
}
