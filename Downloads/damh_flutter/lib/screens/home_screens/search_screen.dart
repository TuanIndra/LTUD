import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/screens/category_screens/item_details.dart';
import 'package:damh_flutter/services/firestore_services.dart';
import 'package:damh_flutter/widgets/loading_indicator.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "Không tìm thấy sản phẩm nào".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filltered = data
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300),
                  children: filltered
                      .mapIndexed((index, currentValue) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(filltered[index]['p_imgs'][0],
                                  height: 200, width: 200, fit: BoxFit.cover),
                              const Spacer(),
                              10.heightBox,
                              "${filltered[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filltered[index]['p_price']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .outerShadowMd
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .padding(const EdgeInsets.all(8))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(
                                  title: "${filltered[index]['p_name']}",
                                  data: filltered[index],
                                ));
                          }))
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
