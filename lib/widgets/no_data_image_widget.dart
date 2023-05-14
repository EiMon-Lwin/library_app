
import 'package:flutter/cupertino.dart';

import '../utils/images_assets.dart';

class NoDataImageWidget extends StatelessWidget {
  const NoDataImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(kNoDataImageAssets,width: 200,height: 200,));
  }
}
