import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodia_test/shared/constants.dart';
import 'package:prodia_test/shared/themes.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final bool secured;
  final String errorText;
  final Function onChange;

  const CustomTextField(
      {Key key,
      this.text = "",
      this.hintText = "",
      this.errorText = "",
      this.controller,
      this.onChange,
      this.enabled = true,
      this.secured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(DEFAULT_MARGIN, 16, DEFAULT_MARGIN, 6),
          child: Text(
            text,
            style: blackFontStyle2,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            controller: controller,
            onChanged: (_) {
              if (onChange != null) onChange();
            },
            enabled: enabled,
            obscureText: secured,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: greyFontStyle,
              hintText: hintText,
            ),
          ),
        ),
        Visibility(
          visible: errorText.isNotEmpty,
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              errorText,
              style: errorFontStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  final Color textColor;

  const CustomButton(
      {Key key,
      this.onPressed,
      this.title = "",
      this.color = Colors.yellow,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: color,
        minimumSize: Size(88, 36),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
