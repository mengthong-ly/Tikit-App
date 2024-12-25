import 'package:event_with_thong/models/gender.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorUserForm extends StatefulWidget {
  final UserModel? user;
  final FormMode mode;
  const OperatorUserForm({super.key, this.user, required this.mode});

  @override
  State<OperatorUserForm> createState() => _OperatorUserFormState();
}

class _OperatorUserFormState extends State<OperatorUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String id;
  late String name;
  late String email;
  late String address;
  late String phoneNumber;
  late String password;
  late Gender selectedGender;
  late UserRoleModel selectedRole;
  bool get isEdit => widget.mode == FormMode.edit;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      id = widget.user!.id;
      name = widget.user!.name ?? '--';
      email = widget.user!.email;
      address = widget.user!.address ?? '--';
      phoneNumber = widget.user!.phoneNumber ?? '--';
      selectedGender = widget.user!.gender ?? Gender.other;
      password = widget.user!.password;
      selectedRole = widget.user!.role;
    } else {
      id = context.read<AuthenticationProvider>().authenticationService.totalUser.toString();
      name = '';
      email = '';
      address = '';
      phoneNumber = '';
      selectedGender = Gender.other;
      password = '';
      selectedRole = UserRoleModel.user;
    }
  }

  final OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      strokeAlign: 0.4,
      color: Color(0xff888888),
    ),
  );

  void onSubmit() {
    print('hi');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isEdit) {
        UserModel updated = UserModel(
            id: widget.user!.id,
            email: email,
            password: password,
            role: selectedRole,
            gender: selectedGender,
            address: address,
            phoneNumber: phoneNumber,
            name: name,
            firstName: name.split(' ').first,
            lastName: name.split(' ').last);
        Navigator.pop<UserModel>(context, updated);
      } else {
        UserModel newUser = UserModel(
          id: context.read<AuthenticationProvider>().authenticationService.totalUser.toString(),
          email: email,
          password: password,
          role: selectedRole,
          gender: selectedGender,
          address: address,
          phoneNumber: phoneNumber,
          name: name,
          firstName: name.split(' ').first,
          lastName: name.split(' ').last,
        );
        Navigator.pop<UserModel>(context, newUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
        bottom: const SizedBox.shrink(),
        title: isEdit ? 'User Edit' : 'User Create',
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TTextFormField(
                    isDarkMode: true,
                    onSaved: (newValue) {
                      name = newValue!;
                    },
                    initialValue: widget.user?.name ?? 'Anonymous',
                    label: 'Name',
                    hint: 'Jonnhy Sin',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  buildDropDownMenuForChoosingGender(),
                  const SizedBox(height: 10),
                  TTextFormField(
                    isDarkMode: true,
                    initialValue: widget.user?.email ?? '',
                    label: 'Email',
                    hint: 'john.doe@example.com',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                      print(email);
                    },
                  ),
                  const SizedBox(height: 10),
                  buildDropDownMenuForChoosingRole(),
                  const SizedBox(height: 10),
                  TTextFormField(
                    isDarkMode: true,
                    onSaved: (newValue) {
                      address = newValue!;
                    },
                    initialValue: widget.user?.address ?? '',
                    label: 'Address',
                    hint: 'st 230..',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TTextFormField(
                    isDarkMode: true,
                    onSaved: (newValue) {
                      phoneNumber = newValue!;
                    },
                    initialValue: widget.user?.phoneNumber ?? '',
                    label: 'Phone Number',
                    hint: '078785339',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TTextFormField(
                    isDarkMode: true,
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    initialValue: widget.user?.password ?? '',
                    label: 'Password',
                    hint: '********',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TElevatedButton(label: 'Save', onPress: onSubmit),
                  )
                ],
              ),
            ),
          )),
        ));
  }

  Widget buildDropDownMenuForChoosingGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(label: 'Gender'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<Gender>(
            dropdownColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
            ),
            borderRadius: BorderRadius.circular(5),
            style: TextStyle(
                fontFamily: TTextTheme.lightTextTheme.bodyMedium!.fontFamily ??
                    'Poppins',
                fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 255, 255, 255)),
            items: Gender.values.map((gender) {
              return DropdownMenuItem<Gender>(
                value: gender,
                child: Text(gender.label),
              );
            }).toList(),
            value: selectedGender,
            onSaved: (newValue) {
              selectedGender = newValue!;
            },
            onChanged: (value) {
              selectedGender = value ?? Gender.other;
            },
          ),
        ),
      ],
    );
  }

  Widget buildDropDownMenuForChoosingRole() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TTitleForTextField(label: 'Role'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<UserRoleModel>(
            dropdownColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
            ),
            borderRadius: BorderRadius.circular(5),
            style: TextStyle(
                fontFamily: TTextTheme.lightTextTheme.bodyMedium!.fontFamily ??
                    'Poppins',
                fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 255, 255, 255)),
            items: UserRoleModel.values.map((role) {
              return DropdownMenuItem<UserRoleModel>(
                value: role,
                child: Text(role.title),
              );
            }).toList(),
            onSaved: (newValue) {
              selectedRole = newValue!;
            },
            value: selectedRole,
            onChanged: (value) {
              selectedRole = value ?? UserRoleModel.admin;
            },
          ),
        ),
      ],
    );
  }
}
