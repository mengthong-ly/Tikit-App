import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/taxon_type.dart';
import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormMode {
  create,
  edit;
}

class OperatorEventForm extends StatefulWidget {
  final FormMode mode;
  final TaxonModel? taxon;
  const OperatorEventForm({super.key, required this.mode, this.taxon});

  @override
  State<OperatorEventForm> createState() => _OperatorEventFormState();
}

class _OperatorEventFormState extends State<OperatorEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<VendorModel> vendors = VendorDatabase.instance.vendors;
  late VendorModel selectedVendor;
  bool get isEditMode => widget.mode == FormMode.edit;
  late TaxonType selectedTaxonType;
  late bool isTaxonFeature;

  String name = '';
  String description = '';

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      name = widget.taxon!.name;
      description = widget.taxon!.description;
      selectedVendor =
          vendors.firstWhere((vendor) => vendor.id == widget.taxon!.vendorId);
      selectedTaxonType = widget.taxon!.taxonType;
      isTaxonFeature = widget.taxon!.isFeatured;
    } else {
      selectedVendor = vendors.first;
      selectedTaxonType = TaxonType.other;
      isTaxonFeature = false;
    }
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await context.read<TaxonModelProvider>().contructTaxonModel(name,
          description, selectedVendor.id, selectedTaxonType, isTaxonFeature);
      Navigator.pop(context);
    }
  }

  void onSetTaxonFeature() {
    setState(() {
      isTaxonFeature = !isTaxonFeature;
    });
  }

  Future<void> onEdit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TaxonModel taxon = TaxonModel(
        id: widget.taxon!.id,
        name: name,
        slug: name,
        description: description,
        vendorId: selectedVendor.id,
        image: widget.taxon!.image,
        isFeatured: isTaxonFeature,
        taxonType: selectedTaxonType,
      );
      Navigator.pop<TaxonModel>(context, taxon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: isEditMode ? 'Edit Event' : 'Create Event',
      bottom: const SizedBox.shrink(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TTextFormField(
                  initialValue: name,
                  onSaved: (value) {
                    name = value!;
                  },
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Invalid name';
                    }
                  },
                  label: 'Event Name',
                  hint: 'Run With Sai',
                  isDarkMode: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TTextFormField(
                  initialValue: description,
                  onSaved: (value) {
                    description = value!;
                  },
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Invalid Description';
                    }
                  },
                  label: 'Description',
                  hint: 'a running event for charity',
                  isDarkMode: true,
                ),
                const SizedBox(height: 10),
                buildVendorDropDownMenu(context, vendors),
                const SizedBox(height: 10),
                buildTaxonDropDownMenu(context),
                const SizedBox(height: 10),
                TElevatedButton(
                  label: !isTaxonFeature ? 'Not Feature' : 'Featured',
                  onPress: onSetTaxonFeature,
                  color: !isTaxonFeature ? Colors.grey : null,
                ),
                const SizedBox(height: 10),
                TElevatedButton(
                  label: isEditMode ? 'Save' : 'Create',
                  onPress: isEditMode ? onEdit : onSubmit,
                ),
              ],
            ),
          ),
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
  Widget buildVendorDropDownMenu(
      BuildContext context, List<VendorModel> vendors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(label: 'Vendor'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<VendorModel>(
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
            items: VendorDatabase.instance.vendors.map((vendor) {
              return DropdownMenuItem<VendorModel>(
                value: vendor,
                child: Text(vendor.name),
              );
            }).toList(),
            value: selectedVendor,
            onChanged: (value) {
              selectedVendor = value!;
              print(selectedVendor);
            },
          ),
        ),
      ],
    );
  }

  Widget buildTaxonDropDownMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(label: 'Event Type'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<TaxonType>(
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
            items: TaxonType.values.map((taxon) {
              return DropdownMenuItem<TaxonType>(
                value: taxon,
                child: Text(taxon.typeString),
              );
            }).toList(),
            value: selectedTaxonType,
            onChanged: (value) {
              selectedTaxonType = value!;
              print(selectedTaxonType);
            },
          ),
        ),
      ],
    );
  }
}
