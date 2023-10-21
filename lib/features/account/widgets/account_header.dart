// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wssal/core/providers/user_provider.dart';
//
// class AccountHeader extends StatelessWidget {
//   const AccountHeader({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final user = context.read<UserProvider>().userModel;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: ListTile(
//         leading: SizedBox(
//           width: 65,
//           height: 65,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: NetworkImage(user?.imageUrl ?? ''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         title: Text(
//           user?.name ?? '',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(
//           user?.userId ?? '',
//           style: const TextStyle(
//             color: Color(0xff7C7C7C),
//             fontWeight: FontWeight.normal,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
