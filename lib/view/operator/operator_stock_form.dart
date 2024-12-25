import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:event_with_thong/viewModels/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class OperatorStockForm extends StatefulWidget {
  final FormMode mode;
  final StockModel? stock;
  const OperatorStockForm({super.key, required this.mode, this.stock});

  @override
  State<OperatorStockForm> createState() => _OperatorStockFormState();
}

class _OperatorStockFormState extends State<OperatorStockForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late List<ProductVariantModel> variants;
  late final int previousLimitStock;
  late int quantity;
  late int limitStock;
  late String variantId;
  late String location;
  bool get isEdit => widget.mode == FormMode.edit;
  String get newId => (context
              .read<StockProvider>()
              .stockService
              .stockData
              .stockDatabase
              .length +
          1)
      .toString();
  ProductVariantModel? selectedVariant;

  @override
  void initState() {
    super.initState();
    loadVariants();
    if (isEdit) {
      try {
        quantity = widget.stock!.quantity;
        previousLimitStock = widget.stock!.limitStock;
        limitStock = widget.stock!.limitStock;
        selectedVariant = variants
            .firstWhere((variant) => variant.id == widget.stock!.variantId);
        variantId = widget.stock!.variantId;
        location = widget.stock!.stockLocation;
      } catch (e) {
        Logger().d(e);
      }
    } else {
      quantity = 0;
      limitStock = 0;
      selectedVariant = variants.first;
      location = ' ';
    }
  }

  void loadVariants() {
    variants = !isEdit
        ? context.read<ProductVariantProvider>().service.getAllNoStockVariant()
        : context.read<ProductVariantProvider>().service.getAllVariant();

    // Ensure selectedVariant is initialized if not in edit mode
    if (!isEdit && variants.isNotEmpty) {
      selectedVariant = variants.first;
    }
  }

  ProductModel? getProductByVariantId(String variantId) {
    final ProductVariantModel? variant =
        context.read<ProductVariantProvider>().getVariantByid(variantId);

    if (variant != null) {
      return context.read<ProductVariantProvider>().getProductById(variant);
    }
    return null;
  }

  void onSubmit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if (isEdit) {
        // update stock
        final StockModel updateStock = StockModel(
          id: widget.stock!.id,
          variantId: widget.stock!.variantId,
          quantity: quantity + (limitStock - previousLimitStock),
          limitStock: limitStock,
          stockLocation: location,
        );
        Navigator.pop<StockModel>(context, updateStock);
      } else {
        // add new stock
        final stock = StockModel(
          id: newId,
          variantId: selectedVariant!.id,
          quantity: limitStock,
          limitStock: limitStock,
          stockLocation: location,
        );
        Navigator.pop<StockModel>(context, stock);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
        bottom: const SizedBox.shrink(),
        title: 'Stock Edit',
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TTextFormField(
                      label: 'Limit Stock',
                      hint: '100...',
                      initialValue: isEdit ? limitStock.toString() : '0',
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                      isDarkMode: true,
                      validator: (value) {
                        if (int.parse(value ?? '0') <= 0 ||
                            int.parse(value!) < previousLimitStock) {
                          return int.parse(value!) < previousLimitStock
                              ? 'Previous Stock is $previousLimitStock'
                              : 'Limit invalide';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        print(newValue);
                        limitStock = int.parse(newValue!).abs();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TTextFormField(
                      initialValue: location,
                      label: 'Location',
                      hint: 'st 230...',
                      isDarkMode: true,
                      validator: (value) {
                        return null;
                      },
                      onSaved: (newValue) {
                        location = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildDropDownMenu(context, variants, getProductByVariantId),
                    const SizedBox(
                      height: 15,
                    ),
                    TElevatedButton(
                        label: isEdit ? 'Edit' : 'Create', onPress: onSubmit)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      strokeAlign: 0.4,
      color: Color(0xff888888),
    ),
  );

  Widget buildDropDownMenu(
      BuildContext context,
      List<ProductVariantModel> variant,
      ProductModel? Function(String variantId) productInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(
          label: 'Product Variant',
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<ProductVariantModel>(
            dropdownColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
            ),
            borderRadius: BorderRadius.circular(5),
            style: TextStyle(
              fontFamily:
                  TTextTheme.lightTextTheme.bodyMedium!.fontFamily ?? 'Poppins',
              fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            items: variants.map((variant) {
              return DropdownMenuItem<ProductVariantModel>(
                value: variant,
                child: Text(
                    '${productInfo(variant.id)!.name}${variant.optionTypesId}'),
              );
            }).toList(),
            value: selectedVariant,
            onChanged: (value) {
              selectedVariant = value!;
            },
          ),
        ),
      ],
    );
  }
}
