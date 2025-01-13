import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/screens/orders_screens/orders_details.dart';
import 'package:damh_flutter/services/firestore_services.dart';
import 'package:damh_flutter/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Đơn hàng của tôi".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Chưa có đơn đặt hàng nào!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                        onPressed: () async {
                          try {
                            // Truy vấn tài liệu trong collection 'orders' có `order_by` là `currentUser!.uid`
                            var orderQuerySnapshot = await firestore
                                .collection('orders')
                                .where('order_by', isEqualTo: currentUser!.uid)
                                .get();

                            // Kiểm tra xem có kết quả không
                            if (orderQuerySnapshot.docs.isNotEmpty) {
                              // Lấy tài liệu đầu tiên trong danh sách kết quả (hoặc xử lý nhiều kết quả nếu cần)
                              var orderData = data[index].data() as Map<String, dynamic>;
                              Get.to(() => OrdersDetails(data: orderData));
                            } else {
                              print("Không tìm thấy đơn hàng nào cho người dùng hiện tại");
                              // Hiển thị thông báo nếu không có dữ liệu
                              VxToast.show(context, msg: "Không tìm thấy đơn hàng nào");
                            }
                          } catch (e) {
                            print("Lỗi khi tìm nạp đơn hàng: $e");
                            VxToast.show(context, msg: "Lỗi khi tìm nạp đơn đặt hàng");
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        )),
                  );
                });
          }
        },
      ),
    );
  }
}
