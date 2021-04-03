import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_template/res/my_theme.dart';
import 'package:my_flutter_template/utils/my_utils.dart';
import 'package:my_flutter_template/view/loading_widget.dart';
import 'package:my_flutter_template/view/my_app_bar.dart';
import 'package:photo_view/photo_view.dart';

class KDIX_ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  const KDIX_ImageDetailPage(this.imageUrl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bg_page,
      body: Stack(
        children: [
          Center(
            child: PhotoView(
              loadingBuilder: (context, progress) {
                return Center(child: LoadingWidget());
              },
              errorBuilder: (context, object, stackTrace) {
                MyUtils.showToast(msg: "Image load failed");

                return Container(
                  color: MyTheme.bg_default_img,
                  child: Center(child: Image.asset(MyUtils.getImage("l_image_loading_bg"), width: double.infinity, fit: BoxFit.fitWidth)),
                );
              },
              imageProvider: imageUrl.startsWith("http") ? CachedNetworkImageProvider(imageUrl) : AssetImage(MyUtils.getImage(imageUrl)),
            ),
          ),
          MyAppBar(
            leftWidget: Icon(Icons.close, color: Colors.white, size: 36),
            onLeftTap: () => MyUtils.popPage(context),
          ),
        ],
      ),
    );
  }
}
