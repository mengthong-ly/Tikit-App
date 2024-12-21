import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OperatorProductForm extends StatefulWidget {
  final FormMode mode;
  final ProductModel? product;
  const OperatorProductForm({super.key, required this.mode, this.product});

  @override
  State<OperatorProductForm> createState() => _OperatorProductFormState();
}

class _OperatorProductFormState extends State<OperatorProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late String description;
  late String location;
  late DateTime? eventDate;

  bool get isEdit => widget.mode == FormMode.edit;
  List<TaxonModel> taxons = TaxonService.instance.taxonData.taxons;
  late TaxonModel selectedTaxon;
  TaxonModel get initialTaxon => context
      .read<ClassificationProvider>()
      .getTaxonByProductId(widget.product!);

  @override
  void initState() {
    super.initState();

    selectedTaxon = taxons.first;

    if (isEdit) {
      name = widget.product!.name;
      price = widget.product!.price;
      description = widget.product!.description;
      location = widget.product!.location;
      eventDate = widget.product!.eventDate;
    } else {
      eventDate = DateTime.now();
    }
  }

  void onSubmit() async {
    Map<TaxonModel, ProductModel> mapModel = {};
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final ProductModel productt;
      if (isEdit == true) {
        productt = ProductModel(
            id: widget.product!.id,
            name: name,
            price: price,
            description: description,
            location: location,
            eventDate: eventDate!);
        mapModel = {selectedTaxon: productt};
        Navigator.pop<Map<TaxonModel, ProductModel>>(context, mapModel);
      } else {
        String id = (context
                    .read<ProductModelProvider>()
                    .service
                    .productData
                    .products
                    .length +
                1)
            .toString();
        productt = ProductModel(
          id: id,
          name: name,
          price: price,
          description: description,
          location: location,
          eventDate: eventDate!,
        );
        mapModel = {selectedTaxon: productt};
        Navigator.pop<Map<TaxonModel, ProductModel>>(context, mapModel);
      }
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 4, now.month, now.day);
    final DateTime lastDate = DateTime(now.year + 4, now.month, now.day);

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: CupertinoDatePicker(
          initialDateTime: eventDate ?? DateTime.now(),
          minimumDate: firstDate,
          maximumDate: lastDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              eventDate = newDate;
            });
          },
        ),
      ),
    );
  }

  OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      strokeAlign: 0.4,
      color: Color(0xff888888),
    ),
  );

  Widget buildDropDownMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(label: 'Event'),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<TaxonModel>(
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
            items: taxons.map((vendor) {
              return DropdownMenuItem<TaxonModel>(
                value: vendor,
                child: Text(vendor.name),
              );
            }).toList(),
            value: isEdit ? initialTaxon : selectedTaxon,
            onChanged: (value) {
              selectedTaxon = value!;
              print(selectedTaxon.name);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: isEdit ? 'Product Edit' : 'Product Create',
      bottom: const SizedBox.shrink(),
      child: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TTextFormField(
                      onSaved: (valueNalue) {
                        name = valueNalue ?? '';
                      },
                      initialValue: isEdit ? name : '',
                      label: 'Name',
                      hint: 'VIP...',
                      isDarkMode: true,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        } else {
                          return 'invalid name';
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TTextFormField(
                      suffixIcon: const Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Price is required';
                        }
                      },
                      onSaved: (newValue) {
                        price = double.parse(newValue ?? '0');
                      },
                      label: 'Price',
                      hint: '\$200...',
                      initialValue: isEdit ? price.toString() : '',
                      isDarkMode: true,
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 10),
                    TTextFormField(
                      label: 'Description',
                      hint: 'a excited event...',
                      initialValue: isEdit ? description : '',
                      isDarkMode: true,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Description is required';
                        }
                      },
                      onSaved: (newValue) {
                        description = newValue ?? '';
                      },
                    ),
                    const SizedBox(height: 10),
                    TTextFormField(
                        label: 'Location',
                        hint: 'st 230....',
                        initialValue: isEdit ? location : '',
                        onSaved: (newValue) {
                          location = newValue ?? '';
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return 'Location is required';
                          }
                        },
                        isDarkMode: true),
                    const SizedBox(height: 10),
                    buildDropDownMenu(context),
                    const SizedBox(height: 10),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(5),
                      minSize: 20,
                      color: const Color(0xff4338CA),
                      onPressed: () => _showCupertinoDatePicker(context),
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(height: 10),
                    TElevatedButton(
                        label: isEdit ? 'Edit' : 'Create', onPress: onSubmit)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
