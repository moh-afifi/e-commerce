import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/app_button.dart';
import 'package:wssal/features/orders/data/models/orders_model.dart';
import 'package:wssal/features/orders/providers/orders_provider.dart';

import '../../../core/utils/color_utils.dart';
import '../screens/invoice_details_screen.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.invoice}) : super(key: key);
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    const blackStyle = TextStyle(
      fontSize: 12,
      color: Colors.black,
    );
    const greyStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        collapsedIconColor: AppColors.secondColor,
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        initiallyExpanded: true,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
        expandedAlignment: Alignment.center,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "حالة الطلب: ${invoice.status ?? ''}",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text("رقم الطلب: ${invoice.orderNo ?? ''}", style: greyStyle),
            Text(
                "تاريخ الطلب: "
                "${invoice.createdAt.day}/${invoice.createdAt.month}/${invoice.createdAt.year}",
                style: greyStyle),
          ],
        ),
        children: [
          const Divider(
            color: Colors.grey,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تكلفة الطلب: " '${invoice.totalAmount ?? ''} جنيه',
                  style: blackStyle,
                ),
                const SizedBox(height: 5),
                Text(
                  "عنوان التوصيل: " '${invoice.address ?? ''} ',
                  style: blackStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 110,
              child: Timeline.tileBuilder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                theme: TimelineThemeData(
                  direction: Axis.horizontal,
                  connectorTheme: const ConnectorThemeData(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  indicatorTheme: const IndicatorThemeData(
                    size: 15.0,
                    color: AppColors.primaryColor,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  contentsAlign: ContentsAlign.basic,
                  itemCount: textList.length,
                  connectionDirection: ConnectionDirection.before,
                  itemExtent: 75,
                  connectorBuilder: (_, index, type) {
                    return const SolidLineConnector(
                      color: Colors.grey,
                    );
                  },
                  indicatorBuilder: (_, index) {
                    return OutlinedDotIndicator(
                      borderWidth: 1.0,
                      size: 20,
                      color: AppColors.primaryColor,
                      backgroundColor:
                          textList.indexWhere((s) => s == invoice.status) >=
                                  index
                              ? AppColors.primaryColor
                              : Colors.white,
                    );
                  },
                  contentsBuilder: (context, index) {
                    return const SizedBox.shrink();
                  },
                  oppositeContentsBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        textList[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (invoice.status == 'تم التسليم' && invoice.invoiceLink !=null)
              AppButton(
                label: 'تحميل الفاتورة',
                shrink: true,
                margin: const EdgeInsets.only(bottom: 10),
                backgroundColor: AppColors.primaryColor,
                fontSize: 10,
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(invoice.invoiceLink ?? ''),
                      mode: LaunchMode.externalApplication)) {
                    // ignore: use_build_context_synchronously
                    AppUtils.showSnackBar(
                        context: context, message: "لا يمكن تحميل الملف");
                  }
                },
              ),
              AppButton(
                label: 'تفاصيل الفاتورة',
                shrink: true,
                margin: const EdgeInsets.only(bottom: 10),
                backgroundColor: Colors.teal,
                fontSize: 10,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceDetailsScreen(
                      invoiceId: invoice.orderNo ?? '',
                    ),
                  ),
                ),
              ),
              if (invoice.status == 'تم الاستلام')
                AppButton(
                  label: 'إلغاء الطلب',
                  shrink: true,
                  margin: const EdgeInsets.only(bottom: 10),
                  backgroundColor: Colors.red,
                  fontSize: 10,
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.question,
                      desc: 'هل تريد حذف الطلب؟',
                      btnCancelOnPress: () {},
                      btnCancelText: 'إلغاء',
                      btnOkOnPress: () {
                        context
                            .read<OrdersProvider>()
                            .cancelOrders(orderId: invoice.orderNo ?? '-1');
                      },
                      btnOkText: 'موافق',
                    ).show();
                  },
                )
            ],
          )
        ],
      ),
    );
  }
}

List<String> textList = [
  'تم الاستلام',
  'جاري التجهيز',
  'فى الطريق',
  'تم التسليم',
];
