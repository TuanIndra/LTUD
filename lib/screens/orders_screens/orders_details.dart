import 'package:damh_flutter/screens/orders_screens/components/order_place_details.dart';
import 'package:damh_flutter/screens/orders_screens/components/order_status.dart';
import '../../consts/consts.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Chi tiết đặt hàng".text.fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Đã đặt",
                  showDone: data['order_place']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Đã xác nhận",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "Đang giao hàng",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Đã giao hàng",
                  showDone: data['order_deliveried']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Mã đặt hàng",
                      title2: "Phương thức thanh toán"),
                  orderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['shipping_method'],
                      title1: "Ngày đặt hàng",
                      title2: "Phương thức thanh toán"
                  ),
                  orderPlaceDetails(
                      d1: "Chưa thanh toán",
                      d2: "Nơi đặt hàng",
                      title1: "Trạng thái thanh toán",
                      title2: "Tình trạng giao hàng"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Địa chỉ giao hàng".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            // "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Tổng tiền".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Đặt hàng"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}",
                        d2: "Có thể hoàn trả",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
