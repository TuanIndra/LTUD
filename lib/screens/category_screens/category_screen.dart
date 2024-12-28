import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/consts/lists.dart';
import 'package:damh_flutter/screens/category_screens/categories_detail.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImage[index],
                    height: 100,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                  10.heightBox,
                  categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make().onTap((){
                    Get.to(()=>CategoriesDetail(title: categoriesList[index]));
                  }),
                ],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make();
            }),
      ),
    ));
  }
}
