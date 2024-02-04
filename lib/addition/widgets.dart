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

TextField textField({hint, password, controller, type, onChanged, maxLines}) {
  return TextField(
    controller: controller,
    cursorColor: Colors.white,
    keyboardType: type ?? TextInputType.text,
    maxLines: maxLines ?? 1,
    textInputAction:
        maxLines == null ? TextInputAction.go : TextInputAction.newline,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: Colors.white.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.2, color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      hintText: hint,
      hintStyle: GoogleFonts.alexandria(color: Colors.white.withOpacity(0.5), fontSize: 15),
    ),
    obscureText: password == true ? true : false,
    style: GoogleFonts.alexandria(fontSize: 15, color: Colors.white, height: 1.8),
    onChanged: onChanged,
  );
}

Widget dropDown({
  required String value,
  required List<String> items,
  onChanged,
}) {
  return DropdownButtonFormField(
    value: value,
    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
    dropdownColor: Color(0xff007088),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.2,
          color: Colors.white.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: GoogleFonts.alexandria(
        color: Colors.white.withOpacity(0.5),
        fontSize: 15,
      ),
    ),
    isExpanded: true,
    items: items.map((String item) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: GoogleFonts.alexandria(
            fontSize: 15,
            color: Colors.white,
            height: 1.8,
          ),
        ),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
