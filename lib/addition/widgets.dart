// ignore_for_file: prefer_const_constructors, unnecessary_new, non_constant_identifier_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defultText({text, color, double? size, weight, align, maxlines}) {
  return Text(
    text ?? '',
    style: GoogleFonts.alexandria(
        color: color ??= Colors.white,
        fontSize: size ?? 10,
        fontWeight: weight ??= FontWeight.normal,),
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        maxLines: maxlines,
  );
}

Widget defultInput({placeholder, controller, password}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(12)),
    child: TextField(
      controller: controller,
      obscureText: password ??= false,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration.collapsed(
        hintText: placeholder,
        hintStyle: GoogleFonts.alexandria(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}


Widget defultButton({text, width, size, onclick}) {
  return MaterialButton(
    minWidth: width,
    color: Color(0xff005062),
    padding: EdgeInsets.symmetric(vertical: 14),
    elevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Text(
      text,
      style: GoogleFonts.alexandria(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.w500
      ),
    ),
    onPressed: onclick ??= (){},
  );
}