import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOptionItem extends StatelessWidget {
  final String title;
  final PaymentTypeModel value;
  final PaymentTypeModel groupValue;
  final void Function(PaymentTypeModel) callback;

  const PaymentOptionItem({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 30,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xfff4f4f4)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(value.image)),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
                color: context.read<ThemeProvider>().isDarkMode
                    ? Colors.white
                    : Colors.black,
                fontSize: TTextTheme.lightTextTheme.bodyLarge!.fontSize),
          ),
          const Spacer(),
          Radio(
            activeColor: const Color(0xffFD2942),
            value: value,
            groupValue: groupValue,
            onChanged: (paymentType) => callback(paymentType!),
          ),
        ],
      ),
    );
  }
}
