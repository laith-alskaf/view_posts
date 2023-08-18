import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:testofcourse/ui/shared/colors.dart';

class TextFormFieldSIgnUP extends StatelessWidget {
  final FocusNode? firstNameFocus;
  final FocusNode? lastNameFocus;
  final String hintText;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Icon?  prefixIcon;
  final TextInputType? textType;
  final double? contentPadding;
  final bool?  obscureTextBollean;
  final TextEditingController? controller;
  final String? Function(String?)?validator;
   // GlobalKey<FormState>? formstate;
  const TextFormFieldSIgnUP(
      {Key? key, required this.hintText,  this.controller, this.validator,  this.firstNameFocus,  this.lastNameFocus, this.paddingHorizontal, this.paddingVertical, this.prefixIcon, this.contentPadding, this.obscureTextBollean, this.textType,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical:paddingVertical?? 2.h, horizontal:paddingHorizontal?? 6.w),
      child: TextFormField(
        obscureText:obscureTextBollean??false ,
           onEditingComplete: () {
             FocusScope.of(context).requestFocus(lastNameFocus);
           },
        focusNode: firstNameFocus,
        // enableInteractiveSelection: true,
        // autofocus: true,
        validator:validator,
        keyboardType: textType,
        // autovalidateMode: AutovalidateMode.always,
        controller: controller,
        autocorrect: true,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(horizontal:contentPadding?? size.width * 0.1),
          filled: true,
          prefixIcon: prefixIcon,
          fillColor:Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 30,color: Color.fromRGBO(0, 0, 0, 0.2))
        ),
      ),
    );
  }
}
