import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/consts/colors.dart';
import 'package:library_app/consts/dimes.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';

import '../consts/strings.dart';

class YourShelfViewPage extends StatelessWidget {
  const YourShelfViewPage({Key? key,required this.shelfVO}) : super(key: key);
  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            context.navigateBack(context);
          },
            child: Icon(Icons.arrow_back_ios,color: kTabBarBlackColor,)),
        actions: [
          Icon(Icons.search,color: kTabBarBlackColor,),
          SizedBox(width: 5,),
          Icon(Icons.more_vert,color: kTabBarBlackColor,)
          
        ],
      ),
      body: SingleChildScrollView(

        child:  Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  EasyTextWidget(text: shelfVO.shelfName?? '',fontWeight: kFontWeightBold,fontSize: 20,),
                  SizedBox(height: 10,),
                  EasyTextWidget(text: "${shelfVO.shelfBooks?.length} book".addS(shelfVO.shelfBooks?.length ?? 0))
                ],
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 300,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.only(left: kSP10x),
                    width: kBookImageItemViewWidth150x,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kImageHeight230x,
                          child: CachedNetworkImage(
                            imageUrl: shelfVO.shelfBooks?[index].bookImage ??
                                kDefaultImageLink,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kImageBorderCircular8x),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ),
                        const SizedBox(
                          height: kSP5x,
                        ),
                        SizedBox(
                          height: kTitleHeight60x,
                          child: EasyTextWidget(
                              text: shelfVO.shelfBooks?[index].title ?? ''),
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 5,),
                  itemCount: shelfVO.shelfBooks?.length?? 0),
            )

          ],
        ),
      ),

    );
  }
}
