import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/beasiswa_list_card.dart';
import 'package:flutter/material.dart';

class BeasiswaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Beasiswa Terdaftar', style: primaryTextStyle),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    // Widget belumTerdaftar() {
    //   return Expanded(
    //     child: Container(
    //       width: double.infinity,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Image.asset('assets/bookmark.png', width: 74, height: 62),
    //           SizedBox(height: 23),
    //           Text(
    //             'Belum Terdaftar Beasiswa Manapun',
    //             textAlign: TextAlign.center,
    //             style: formTextStyle.copyWith(fontSize: 16, fontWeight: medium),
    //           ),
    //           SizedBox(height: 12),
    //           Text('Ayo cari disini!', style: secondaryTextStyle),
    //           SizedBox(height: 20),
    //           Container(
    //             height: 44,
    //             child: TextButton(
    //               onPressed: () {},
    //               style: TextButton.styleFrom(
    //                 padding: EdgeInsets.symmetric(horizontal: 24),
    //                 backgroundColor: primaryColor,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //               ),
    //               child: Text(
    //                 'Cari Beasiswa',
    //                 style: primaryTextStyle.copyWith(
    //                   fontSize: 16,
    //                   fontWeight: medium,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget mainContent() {
      return Expanded(
        child: Container(
          color: backgroundColor2,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              BeasiswaListCard(),
              BeasiswaListCard(),
              BeasiswaListCard(),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        // belumTerdaftar(),
        mainContent(),
      ],
    );
  }
}
