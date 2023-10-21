import 'package:flutter/material.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.prefixIcon,
    this.keybord,
    this.lebelText,
    this.keyy,
    this.maxNumber,
    this.controller,
    this.validator,
    this.data,
    this.hintText,
    this.initialText,
    this.suffixIcon,
    this.formatter,
    this.onChangeFunction,
    this.suffixText,
    this.maxLength
  });

  final TextEditingController? controller;
  final Function? onChangeFunction;
  final dynamic data;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final String? initialText;
  final dynamic validator;
  final String? hintText;
  final int? maxNumber;
  final String? lebelText;
  final dynamic formatter;
  final dynamic keybord;
  final String? suffixText;
  final int? maxLength;

  final String? keyy;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //minLines: 1,
      maxLength:maxLength,
      maxLines: maxNumber,
      initialValue: initialText,
      keyboardType: keybord,
      controller: controller,
      inputFormatters: formatter,
      validator: validator,
      // onSaved: (String value) => data[keyy] = value,
      //  onChanged: onChangeFunction,
      autofocus: false,
      style: myStyle(14.0, const Color.fromARGB(234, 70, 69, 69)),
      decoration: InputDecoration(
        // hoverColor: Colors.black,

        suffixText: suffixText,
        contentPadding: EdgeInsets.symmetric(
            vertical: maxNumber == null ? 0 : 10, horizontal: 15),
        labelText: lebelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
      ),
    );
  }
}

//Email and others*************************************

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    this.prefixIcon,
    this.keybord,
    this.lebelText,
    this.keyy,
    this.maxNumber,
    this.controller,
    this.validator,
    this.data,
    this.hintText,
    this.initialText,
    this.suffixIcon,
    this.formatter,
    this.onChangeFunction,
    this.suffixText,
  });

  final TextEditingController? controller;
  final Function? onChangeFunction;
  final dynamic data;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final String? initialText;
  final dynamic validator;
  final String? hintText;
  final int? maxNumber;
  final String? lebelText;
  final dynamic formatter;
  final dynamic keybord;
  final String? suffixText;

  final String? keyy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        //minLines: 1,
        maxLines: maxNumber,
        initialValue: initialText,
        keyboardType: keybord,
        controller: controller,
        inputFormatters: formatter,
        validator: validator,
        // onSaved: (String value) => data[keyy] = value,
        //  onChanged: onChangeFunction,
        autofocus: false,
        style: myStyle(14.0, Color.fromARGB(234, 70, 69, 69)),
        decoration: InputDecoration(
          // hoverColor: Colors.black,
          filled: true,
          alignLabelWithHint: true,
          suffixText: suffixText,
          prefixIconColor: BrandColors.greyColor,
          errorStyle: myStyle(12, Colors.red.withOpacity(0.9), FontWeight.w500),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: BrandColors.lightGreyColor, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          labelText: lebelText,
          hintStyle: myStyle(15, Color.fromARGB(234, 70, 69, 69)),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelStyle: myStyle(15, Color.fromARGB(234, 70, 69, 69)),
          hintText: hintText,
        ),
      ),
    );
  }
}

//Password****************************

class TextboxWidget extends StatefulWidget {
  const TextboxWidget(
      {Key? key,
      required this.controller,
      this.keyboardType = TextInputType.name,
      this.isPassword = false,
      this.hintText,
      this.validator,
      this.suffixIcon,
      this.prefixIcon})
      : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? hintText;
  final Function? validator;
  final dynamic prefixIcon;
  final dynamic suffixIcon;

  @override
  State<TextboxWidget> createState() => _TextboxWidgetState();
}

class _TextboxWidgetState extends State<TextboxWidget> {
  bool _passwordVisible1 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        obscureText: !_passwordVisible1,
        keyboardType: widget.keyboardType,
        cursorHeight: 20,
        validator: (value) {
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          } else if (value.length < 6) {
            return ("Password Must be more than 5 characters");
          } else if (!regex.hasMatch(value)) {
            return ("Password should contain upper,lower,digit and Special character ");
          }
          return null;
        },
        style: const TextStyle(fontSize: 16),
        onChanged: (value) {
          //   log(widget.controller.text);
        },
        decoration: InputDecoration(
          errorStyle: myStyle(12, Colors.red.withOpacity(0.9), FontWeight.w500),
          prefixIconColor: BrandColors.greyColor,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
          ),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible1 = !_passwordVisible1;
                    });
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
