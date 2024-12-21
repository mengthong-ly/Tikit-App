import 'package:event_with_thong/models/gender.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/view/components/t_title_for_text_field.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class EditForm extends StatefulWidget {
  final UserModel user;
  const EditForm({super.key, required this.user});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String id;
  late String name;
  late String email;
  late String address;
  late String phoneNumber;
  late Gender selectedGender;

  OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      strokeAlign: 0.4,
      color: Color(0xff888888),
    ),
  );

  @override
  void initState() {
    super.initState();
    Logger().d('userid: ${widget.user.id}');
    Logger().d('userid: ${widget.user.id}');
    id = widget.user.id;
    email = widget.user.email;
    name = widget.user.name ?? '';
    address = widget.user.address ?? '';
    phoneNumber = widget.user.phoneNumber ?? '';
    selectedGender = widget.user.gender ?? Gender.other;
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Logger().d('''
        $name
        ''');
      _showConfirmDialog();
    }
  }

  Future<dynamic> _showConfirmDialog() {
    return _showCustomDialog(
      'Accept?',
      "Are you sure?",
      [
        CupertinoActionSheetAction(
          child: const Text("Yes"),
          onPressed: () {
            final UserModel dummyUserForSave = UserModel(
              id: id,
              email: email,
              name: name,
              address: address,
              gender: selectedGender,
              password: widget.user.password,
              phoneNumber: phoneNumber,
            );

            Navigator.pop<UserModel>(
                context, dummyUserForSave); // Close the dialog
            Navigator.pop<UserModel>(context, dummyUserForSave);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text("No"),
          onPressed: () {
            Navigator.pop<UserModel>(context, widget.user);
          },
        ),
      ],
    );
  }

  Future<void> _showCustomDialog(
      String title, String content, List<Widget> actions) async {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions,
      ),
    );
  }

  void onDiscard() {
    _showCustomDialog(
      'Warning!',
      "Data will not update",
      [
        CupertinoActionSheetAction(
          child: const Text("Yes"),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text("No"),
          onPressed: () {
            Navigator.pop<UserModel>(context, widget.user);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onDiscard,
          icon: const Icon(
            Icons.navigate_before,
            weight: 1,
            size: 34,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/8.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Id: ${widget.user.id}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            TTextTheme.lightTextTheme.bodyMedium!.fontSize,
                        fontWeight:
                            TTextTheme.lightTextTheme.bodyMedium!.fontWeight,
                        color: const Color(0xff808080)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 200,
                  child: Text(
                    'role: ${widget.user.role.title}',
                    style: TextStyle(
                        fontSize:
                            TTextTheme.lightTextTheme.bodyMedium!.fontSize,
                        fontWeight:
                            TTextTheme.lightTextTheme.bodyMedium!.fontWeight,
                        color: const Color(0xff808080)),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TTextFormField(
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  initialValue: widget.user.name ?? 'Anonymous',
                  label: 'Name',
                  hint: 'Jonnhy Sin',
                ),
                const SizedBox(height: 10),
                buildDropDownMenu(),
                const SizedBox(height: 10),
                TTextFormField(
                  initialValue: widget.user.email,
                  label: 'Email',
                  hint: 'john.doe@example.com',
                  isEnable: false,
                ),
                const SizedBox(height: 10),
                TTextFormField(
                    onSaved: (newValue) {
                      address = newValue!;
                    },
                    initialValue: widget.user.address ?? '',
                    label: 'Address',
                    hint: 'st 230..'),
                const SizedBox(height: 10),
                TTextFormField(
                    onSaved: (newValue) {
                      phoneNumber = newValue!;
                    },
                    initialValue: widget.user.phoneNumber ?? '',
                    label: 'Phone Number',
                    hint: '078785339'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TElevatedButton(label: 'Save', onPress: onSubmit),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropDownMenu() {
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
                color: const Color.fromARGB(255, 0, 0, 0)),
            items: Gender.values.map((gender) {
              return DropdownMenuItem<Gender>(
                value: gender,
                child: Text(gender.label),
              );
            }).toList(),
            value: selectedGender,
            onChanged: (value) {
              selectedGender = value ?? Gender.other;
            },
          ),
        ),
      ],
    );
  }
}
