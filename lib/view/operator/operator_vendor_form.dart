import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/services/vendor_service.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OperatorVendorForm extends StatefulWidget {
  final FormMode mode;
  final VendorModel? venndor;
  const OperatorVendorForm({super.key, this.venndor, required this.mode});

  @override
  State<OperatorVendorForm> createState() => _OperatorVendorFormState();
}

class _OperatorVendorFormState extends State<OperatorVendorForm> {
  late String id;
  late String name;
  late String email;
  late String contact;
  late String address;
  late String profile;

  bool get isEdit => widget.mode == FormMode.edit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      id = widget.venndor!.id;
      name = widget.venndor!.name;
      email = widget.venndor!.email;
      contact = widget.venndor!.contact;
      address = widget.venndor!.address;
      profile = widget.venndor!.profile;
    } else {
      id = context.read<VendorProvider>().service.autoGenerateId.toString();
      name = '';
      email = '';
      contact = '';
      address = '';
      profile = '';
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isEdit) {
        final updatedVendor = VendorModel(
          id: id,
          name: name,
          email: email,
          contact: contact,
          address: address,
          profile: profile,
        );
        Navigator.pop<VendorModel>(context, updatedVendor);
      } else {
        final newVendor = VendorModel(
          id: VendorService.instance.autoGenerateId.toString(),
          name: name,
          email: email,
          contact: contact,
          address: address,
          profile: profile,
        );
        Navigator.pop<VendorModel>(context, newVendor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Operator Vendor',
      bottom: const SizedBox.shrink(),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TTextFormField(
                    label: 'Name',
                    hint: 'hang meas...',
                    isDarkMode: true,
                    initialValue: isEdit ? name : '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'invalid name';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      name = newValue!;
                    },
                  ),
                  TTextFormField(
                    label: 'email',
                    hint: 'hangmeas@gmail.com',
                    isDarkMode: true,
                    initialValue: isEdit ? email : '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'invalid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      email = newValue!;
                    },
                  ),
                  TTextFormField(
                    label: 'contact',
                    hint: '+855 919 4444',
                    isDarkMode: true,
                    initialValue: isEdit ? contact : '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'invalid contact';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      contact = newValue!;
                    },
                  ),
                  TElevatedButton(
                      label: isEdit ? 'Edit' : 'Create', onPress: onSubmit)
                ],
              ),
            ),
          )),
    );
  }
}
