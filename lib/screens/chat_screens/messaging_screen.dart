import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/screens/chat_screens/chat_screen.dart';
import 'package:damh_flutter/services/firestore_services.dart';
import 'package:damh_flutter/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "Tin nhắn của tôi".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Chưa có tin nhắn nào!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Get.to(() => ChatScreen(), arguments: [
                                data[index]['friend_name'],
                                data[index]['toId']
                              ]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person, color: whiteColor),
                            ),
                            title: "${data[index]['friend_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
