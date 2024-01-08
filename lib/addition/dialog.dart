import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

showAlertDialog(BuildContext context, {title, content, onOk}) {
  Widget cancelButton = TextButton(
    child: Text(AppLocalizations.of(context)!.cancel,
        style: GoogleFonts.alexandria()),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget okButton = TextButton(
    onPressed: onOk,
    child:
        Text(AppLocalizations.of(context)!.ok, style: GoogleFonts.alexandria()),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title,
        style:
            GoogleFonts.alexandria(fontWeight: FontWeight.bold, fontSize: 24)),
    content: Text(content, style: GoogleFonts.alexandria(fontSize: 16)),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
