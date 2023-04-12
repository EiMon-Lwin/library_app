import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_page_bloc.dart';
import 'package:library_app/consts/dimes.dart';
import 'package:library_app/data/apply/library_app_apply.dart';
import 'package:library_app/data/apply/library_app_apply_impl.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/persistent/shelf_dao/shelf_dao_impl.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';

 class ShelfPage extends StatelessWidget {
   const ShelfPage({Key? key,required this.booksVO}) : super(key: key);
 final  BooksVO booksVO;

  @override
  Widget build(BuildContext context) {
    final ShelfDAOImpl _shelfDaoImpl=ShelfDAOImpl();
    var keyList=_shelfDaoImpl.getShelfVOBox().keys.toList();
    keyList.forEach((element) {
      print("-------------------->${element}");
    });
    print("EiMonLwin============>${_shelfDaoImpl.getShelfVOBox().values.toList()}");

    return ChangeNotifierProvider(
      create: (context)=> ShelfPageBloc(),


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
                        useRootNavigator: false,
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
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: EasyTextWidget(text: "Add to Shelf",fontWeight: kFontWeightBold,),
                  leading: GestureDetector(
                      onTap: (){
                        context.navigateBack(context);
                      },
                      child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,)),
                ),
                body:  Selector<ShelfPageBloc,List<ShelfVO>>(
                  selector: (_, bloc) =>bloc.getShelfList ,
                  builder: (context, value, child) =>  ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>  GestureDetector(
                          onTap: (){
                            context.getShelfPageBlocInstance().addBookToShelf(value[index], booksVO);
                            context.navigateBack(context);

                          },
                          child: Card(
                            color: kDetailsBackgroundColor,
                            child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: (value[index].shelfBooks?.isEmpty ?? false)? kDefaultImageLink:
                                    value[index].shelfBooks?.first.bookImage?? '',
                                    imageBuilder: (context, imageProvider) => Container(
                                      margin: const EdgeInsets.all(kSP20x),
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
                                          width: 80,
                                          height: kBookTitleHeight65x,
                                          child: EasyTextWidget(text: value[index].shelfName??" ",fontWeight: kFontWeightBold,)),
                                       EasyTextWidget(text: (value[index].shelfBooks?.isEmpty ?? false)? "Empty":
                                       "${value[index].shelfBooks?.length} book".addS(value[index].shelfBooks?.length ?? 0),
                                         textColor: kTabBarBlackColor,),
                                    ],
                                  )
                                ]
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 5,),
                        itemCount: value.length ),
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
    return MaterialButton(onPressed: (){
      if(context.getShelfPageBlocInstance().getGlobalKey.currentState?. validate() ?? false)
      {
        context.getShelfPageBlocInstance().saveNewShelfVOList();
        context.navigateBack(context);
      }
    },color: Colors.lightBlueAccent,child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.done,color: Colors.white,),
        SizedBox(width: 5,),
        EasyTextWidget(text: "Save",textColor: Colors.white,)

      ],
    ),);
  }
}
