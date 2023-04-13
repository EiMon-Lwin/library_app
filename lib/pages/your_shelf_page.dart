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

class YourShelfPage extends StatelessWidget
{
  const YourShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> YourShelfPageBloc(),


      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(

            backgroundColor: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            onPressed: (){

              showDialog(context: context,
                builder: (context) =>
                    ChangeNotifierProvider(
                      create: (context) => ShelfPageBloc(),
                      child: Consumer<ShelfPageBloc>(
                        builder: (context, bloc, child) =>  Form(
                          key: bloc.getGlobalKey,
                          child: AlertDialog(
                            title: const Text("New Shelf"),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: context.getShelfPageBlocInstance().getTextEditingController,
                                    validator: (text){
                                      if(text == null || text.isEmpty){
                                        return "Shelf's name shouldn't Empty";
                                      }

                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "New Shelf Name"
                                    ),

                                  ),
                                  const SizedBox(height: 20,),
                                  MaterialButtonWidget()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            }, child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.edit,color: Colors.white,),
              SizedBox(width: 5,),
              EasyTextWidget(text: "Add to new",textColor: Colors.white,)
            ],
          ),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body:  Selector<YourShelfPageBloc,List<ShelfVO>>(
          selector: (_, bloc) =>bloc.getShelfList ?? [] ,
          builder: (context, value, child) => (value.isEmpty  ?? false || value==null )? Center(child: Image.asset(kNoDataImageAssets)): ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
              // GestureDetector(
              //   onTap: (){
              //     context.getShelfPageBlocInstance().addBookToShelf(value[index], booksVO);
              //
              //
              //   },
              //
              //  child:
            Card(
                  color: kDetailsBackgroundColor,
                  child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:  (value[index].shelfBooks?.isEmpty?? false )?
                          kDefaultImageLink : value[index].shelfBooks?.first.bookImage?? kDefaultImageLink,
                          imageBuilder: (context, imageProvider) => Container(
                            margin:  const EdgeInsets.all(kSP20x),
                            width: 90,
                            height: 60,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                                padding: const EdgeInsets.only(top: kSP20x),
                                width: 100,
                                height: kBookTitleHeight65x,
                                child: EasyTextWidget(text: value[index].shelfName??" ",fontWeight: kFontWeightBold,)),
                            EasyTextWidget(text: (value[index].shelfBooks?.isEmpty ?? false ) ?
                                "#########Empty":
                            //"Empty":
                                "${value[index].shelfBooks?.length} book".addS(value[index].shelfBooks?.length ?? 0)
                              ,textColor: kTabBarBlackColor,),
                          ],
                        ),
                        SizedBox(width: 60,),
                        GestureDetector(
                          onTap: (){
                            context.navigateToNextScreen(context, YourShelfViewPage(shelfVO: value [index],));
                          },
                            child: Icon(Icons.arrow_forward_ios_rounded))
                      ]
                  ),
                ),
            // ),
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: value.length ),
        ),
      ),

    );
  }
}
