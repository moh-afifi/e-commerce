import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wssal/features/notifications/data/models/notification_model.dart';
class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notification})
      : super(key: key);
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final notificationDate = notification.date ?? DateTime.now();
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                DateFormat('dd/MM/yyyy').add_jm().format(notificationDate),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: AutoSizeText(
                        notification.subject ?? '',
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   height: 5,
                //   width: 5,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.red,
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
