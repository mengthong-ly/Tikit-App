import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChange;
  final TextEditingController? controller;
  final bool isEnable;
  final String? initialValue;
  final bool isDarkMode;
  final List<TextInputFormatter>? formatter;

  const TTextFormField(
      {super.key,
      required this.label,
      required this.hint,
      this.initialValue,
      this.suffixIcon = const SizedBox.shrink(),
      this.controller,
      this.validator,
      this.onSaved,
      this.isEnable = true,
      this.isDarkMode = false,
      this.formatter,
      this.onChange
      });

  InputDecoration get inputDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: hint,
        focusedErrorBorder: outLineBorderError,
        hintStyle: TextStyle(
            fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
            fontWeight: TTextTheme.lightTextTheme.bodyMedium!.fontWeight,
            color: const Color.fromARGB(255, 130, 129, 129)),
        suffixIcon: suffixIcon,
        focusedBorder: outLineBorderFocus,
        errorBorder: outLineBorderError,
        enabledBorder: outLineBorderEnable,
        disabledBorder: disableBorder,
      );

  OutlineInputBorder get outLineBorderFocus => const OutlineInputBorder(
        borderSide: BorderSide(
          strokeAlign: 0.4,
          color: Color(0xff888888),
        ),
      );
  OutlineInputBorder get disableBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          strokeAlign: 0.4,
          color: Color(0xff888888),
        ),
      );

  OutlineInputBorder get outLineBorderError => const OutlineInputBorder(
        borderSide: BorderSide(
          strokeAlign: 0.4,
          color: Color.fromARGB(255, 255, 0, 0),
        ),
      );
  OutlineInputBorder get outLineBorderEnable => const OutlineInputBorder(
        borderSide: BorderSide(
          strokeAlign: 0.4,
          color: Color(0xff888888),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TTitleForTextField(label: label),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChange,
          inputFormatters: formatter,
          style: TextStyle(
            color: isDarkMode == false ? Colors.black : Colors.white,
          ),
          initialValue: initialValue,
          enabled: isEnable,
          onSaved: onSaved,
          validator: validator,
          cursorColor: isDarkMode ? Colors.white : Colors.black,
          controller: controller,
          decoration: inputDecoration,
        ),
      ],
    );
  }
}
