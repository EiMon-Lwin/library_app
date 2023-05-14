import 'package:flutter/material.dart';
import 'package:library_app/utils/extension.dart';
import 'package:provider/provider.dart';

import '../blocs/shelf_page_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/shelf_vos/shelf_vo.dart';
import '../widgets/easy_Text_widget.dart';

class FloatingActionButtonItemView extends StatelessWidget {
  const FloatingActionButtonItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (context
            .getShelfPageBlocInstance()
            .getGlobalKey
            .currentState
            ?.validate() ??
            false) {
          context.getShelfPageBlocInstance().saveNewShelfVOList();
          context.navigateBack(context);
        }
      },
      color: kButtonLightBlueAccentColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.done,
            color: kDetailsWhiteColor,
          ),
          SizedBox(
            width: kSP5x,
          ),
          EasyTextWidget(
            text: kSaveText,
            textColor: kDetailsWhiteColor,
          )
        ],
      ),
    );
  }
}

class ShelfNameAndBookCountView extends StatelessWidget {
  const ShelfNameAndBookCountView({
    super.key,
    required this.shelfVO,
  });

  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(top: kSP20x),
            width: kShelfNameTitleWidth200x,
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
        const SizedBox(height: kSP10x,)
      ],
    );
  }
}
