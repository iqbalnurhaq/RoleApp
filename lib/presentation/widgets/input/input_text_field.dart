import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roleapp/shared/theme.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final String icon;
  final TextEditingController textController;
  final FocusNode focusNode;
  final bool obscure;

  InputTextField({
    super.key,
    required this.title,
    this.icon = '',
    required this.textController,
    required this.focusNode,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: blackTextStyle.copyWith(fontSize: 16),
      focusNode: focusNode,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: grayTextStyle.copyWith(fontSize: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGrayColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff1C82AD),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            icon,
            color: kGrayColor,
          ),
        ),
      ),
    );
  }
}
