import 'package:flutter/material.dart';
import 'package:my_flutter_template/res/my_styles.dart';
import 'package:my_flutter_template/res/my_theme.dart';

/// 输入框
Widget inputTextEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction? textInputAction,
  String? hintText,
  double? height = 44,
  EdgeInsetsGeometry? padding,
  bool isPassword = false,
  double marginTop = 0,
  bool autofocus = false,
  double fontSize = 16.0,
  int? minLines = 1,
  int? maxLines = 1,
  int? maxLength,
  FocusNode? focusNode,
  bool readOnly = false,
  TextAlign textAlign = TextAlign.right,
  Color borderColor = MyTheme.transparent,
  BorderRadiusGeometry? borderRadius,
  Color? bgColor = MyTheme.bg_page_gray,
  StrutStyle? strutStyle,
  void Function(String)? onChanged,
}) {
  return Container(
    height: height,
    margin: EdgeInsets.only(top: marginTop),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius ?? BorderRadius.circular(6),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: MyTextStyles.text(fontSize, color: MyTheme.text_block_gray_deep),
        contentPadding: padding ?? const EdgeInsets.fromLTRB(16, 2, 6, 10),
        border: InputBorder.none,
        counterText: "",
      ),
      style: TextStyle(
        color: MyTheme.block,
        fontFamily: "Avenger",
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ),
      strutStyle: strutStyle ?? const StrutStyle(forceStrutHeight: true, height: 1),
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      autocorrect: false,
      // 自动纠正
      obscureText: isPassword,
      // 隐藏输入内容, 密码框
      onChanged: onChanged,
    ),
  );
}

