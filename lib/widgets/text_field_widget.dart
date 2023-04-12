import 'package:flutter/material.dart';
import 'package:library_app/utils/extension.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../pages/search_page.dart';
import '../utils/images_assets.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key, required this.icon, required this.text})
      : super(key: key);
  Icon icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: (){
       context.navigateToNextScreen(context, const SearchPage());
      },
      decoration: InputDecoration(
        suffixIcon: Container(
          padding: const EdgeInsets.only(right: kSP5x),
          width: kCircularImageHeight45x,
          height: kCircularImageHeight45x,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: kRadiusCircular15x,
            backgroundImage: AssetImage(kCatImageAssets),
          ),
        ),
        prefixIcon: icon,
        hintText: text,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: kTabBarBlackColor),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: kTabBarBlackColor)),
      ),
    );
  }
}
