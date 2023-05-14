import 'package:flutter/material.dart';
import 'package:library_app/consts/colors.dart';
import 'package:library_app/consts/dimes.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';
import 'package:library_app/widgets/network_image_widget.dart';

import '../consts/strings.dart';

class YourShelfViewPage extends StatelessWidget {
  const YourShelfViewPage({Key? key, required this.shelfVO}) : super(key: key);
  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: EasyTextWidget(
          text: shelfVO.shelfName ?? '',
          fontWeight: kFontWeightBold,
          fontSize: kFontSize20x,
        ),
        leading: GestureDetector(
            onTap: () {
              context.navigateBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: kTabBarBlackColor,
            )),
        actions: const [
          Icon(
            Icons.search,
            color: kTabBarBlackColor,
          ),
          SizedBox(
            width: kSP5x,
          ),
          Icon(
            Icons.more_vert,
            color: kTabBarBlackColor,
          )
        ],
      ),
      body: Column(

        children: [
          const SizedBox(height: kSP20x,),
          EasyTextWidget(
              text: "${shelfVO.shelfBooks?.length} book"
                  .addS(shelfVO.shelfBooks?.length ?? 0)),
          const SizedBox(
            height: kSP20x,
          ),
          YourShelfViewPageItemView(shelfVO: shelfVO)
        ],
      ),
    );
  }
}

class YourShelfViewPageItemView extends StatelessWidget {
  const YourShelfViewPageItemView({
    super.key,
    required this.shelfVO,
  });

  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all( kSP10x),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1/2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5
        ),
        itemCount: shelfVO.shelfBooks?.length,
        itemBuilder: (context, index) => YourShelfViewPageView(booksVO: shelfVO.shelfBooks![index]),),
    );
  }
}

class YourShelfViewPageView extends StatelessWidget {
  const YourShelfViewPageView({
    super.key,
    required this.booksVO,
  });

  final BooksVO booksVO;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NetworkImageWidget(
            imgUrl: booksVO.bookImage ?? kDefaultImageLink,
            borderRadius: kImageBorderCircular8x,
            imageWidth: kGridViewImageWidth170x,
            imageHeight: kImageHeight250x),
        const SizedBox(
          height: kSP5x,
        ),
        SizedBox(
          height: kTitleHeight60x,
          child: EasyTextWidget(
              text: booksVO.title ?? ''),
        )
      ],
    );
  }
}


