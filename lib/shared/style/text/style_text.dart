
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';

Widget textAppBar(String text) {
  return Align(
    alignment: Alignment.center,
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: SizeConfig.safeBlockHorizontal! * 6,
      ),
    ),
  );
}

Widget textNamePlace(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: SizeConfig.safeBlockHorizontal! * 3.5,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    ),
  );
}Widget subTextNamePlace(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: SizeConfig.safeBlockHorizontal! * 3.1,

          color: Colors.black38
        ),
      ),
    ),
  );
}
//
// Widget textLocationCharacter(String text) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 1, top: 5, bottom: 5),
//     child: Align(
//       alignment: Alignment.bottomLeft,
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: GoogleFonts.inter(
//           fontSize: SizeConfig.safeBlockHorizontal! * 3.2,
//         ),
//       ),
//     ),
//   );
// }
//
// Widget textInfoCharacter(String text) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 1, top: 1, bottom: 5),
//     child: Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: GoogleFonts.inter(
//           fontSize: SizeConfig.safeBlockHorizontal! * 4,
//         ),
//       ),
//     ),
//   );
// }
//
// Widget textTitle(String text) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
//     child: Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: GoogleFonts.inter(
//           fontSize: SizeConfig.safeBlockHorizontal! * 6,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }

Widget textInfoDetails(String text) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          fontSize: SizeConfig.safeBlockHorizontal! * 5,
          color: Colors.black
        ),
      ),
    ),
  );
}
