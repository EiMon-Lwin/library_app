import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/your_shelf_view_page.dart';
import 'package:library_app/utils/extension.dart';
import 'package:provider/provider.dart';

import '../blocs/shelf_page_bloc.dart';
import '../blocs/your_shelf_page_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/shelf_vos/shelf_vo.dart';
import '../utils/images_assets.dart';
import 'shelf_page.dart';
import '../widgets/easy_Text_widget.dart';

class YourShelfPage extends StatelessWidget {
  const YourShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YourShelfPageBloc(),
      child: Consumer<YourShelfPageBloc>(
        builder: (context, value, child) => Scaffold(
          floatingActionButton: SizedBox(
            width: kFloatingActionButtonWidth150x,
            child: FloatingActionButton(
              backgroundColor: kButtonLightBlueAccentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      kFloatingActionButtonRadiusCircular25x)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => ShelfPageBloc(),
                    child: Consumer<ShelfPageBloc>(
                      builder: (context, bloc, child) => Form(
                        key: bloc.getGlobalKey,
                        child: const AlertDialogWidget(),
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.edit,
                    color: kDetailsWhiteColor,
                  ),
                  SizedBox(
                    width: kSP5x,
                  ),
                  EasyTextWidget(
                    text: kAddToNewText,
                    textColor: kDetailsWhiteColor,
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Selector<YourShelfPageBloc, List<ShelfVO>>(
              selector: (_, bloc) => bloc.getShelfList ?? [],
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return Center(child: Image.asset(kNoDataImageAssets));
                }

                return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => ShelfItemView(
                          shelfVO: value[index],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: kSP1x,
                        ),
                    itemCount: value.length);
              }),
        ),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const EasyTextWidget(
        text: kNewShelfText,
      ),
      content: SizedBox(
        height: kShowDialogBoxHeight150x,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller:
                  context.getShelfPageBlocInstance().getTextEditingController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return kValidateText;
                }

                return null;
              },
              decoration: const InputDecoration(hintText: kHintText),
            ),
            const SizedBox(
              height: kSP20x,
            ),
            const MaterialButtonWidget()
          ],
        ),
      ),
    );
  }
}

class ShelfItemView extends StatelessWidget {
  const ShelfItemView({super.key, required this.shelfVO});

  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kDetailsBackgroundColor,
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: (shelfVO.shelfBooks?.isEmpty ?? false)
              ? kDefaultImageLink
              : shelfVO.shelfBooks?.first.bookImage ?? kDefaultImageLink,
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.all(kSP20x),
            width: kShelfImageWidth90x,
            height: kShelfImageHeight60x,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kImageBorderCircular8x),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: kSP20x),
                width: kShelfNameBoxWidth100x,
                height: kBookTitleHeight65x,
                child: EasyTextWidget(
                  text: shelfVO.shelfName ?? " ",
                  fontWeight: kFontWeightBold,
                )),
            EasyTextWidget(
              text: (shelfVO.shelfBooks?.isEmpty ?? false)
                  ? kEmptyText
                  : "${shelfVO.shelfBooks?.length} book"
                      .addS(shelfVO.shelfBooks?.length ?? 0),
              textColor: kTabBarBlackColor,
            ),
          ],
        ),
        const SizedBox(
          width: kSP60x,
        ),
        GestureDetector(
            onTap: () {
              context.navigateToNextScreen(
                  context,
                  YourShelfViewPage(
                    shelfVO: shelfVO,
                  ));
            },
            child: const Icon(Icons.arrow_forward_ios_rounded))
      ]),
    );
  }
}
