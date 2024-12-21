import 'package:event_with_thong/models/gender.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/operator/operator_user_form.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorUserView extends StatefulWidget {
  const OperatorUserView({super.key});

  @override
  State<OperatorUserView> createState() => _OperatorUserViewState();
}

class _OperatorUserViewState extends State<OperatorUserView> {
  late List<UserModel> users;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> onEdit(UserModel user) async {
    final UserModel? updatedUser =
        await Navigator.push<UserModel>(context, MaterialPageRoute(
      builder: (context) {
        return OperatorUserForm(
          user: user,
          mode: FormMode.edit,
        );
      },
    ));
    if (updatedUser != null) {
      await context
          .read<AuthenticationProvider>()
          .operatorUpdateUser(updatedUser);
      showSnackbar(context, 'Update successful');
      setState(() {
        load();
      });
    }
  }

  void onRemove(UserModel user) async {
    if (await context.read<AuthenticationProvider>().operatorRemoveUser(user)) {
      showSnackbar(context, 'You just removed the ${user.email}');
      setState(() {
        load();
      });
    } else {
      showSnackbar(context, 'Failed to remove user');
      setState(() {
        load();
      });
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> onCreate() async {
    final UserModel? newUser = await Navigator.push<UserModel>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const OperatorUserForm(
            mode: FormMode.create,
          );
        },
      ),
    );
    if (newUser != null) {
      await context.read<AuthenticationProvider>().createUserByOperator(
          newUser.email,
          newUser.password,
          newUser.password,
          newUser.name ?? '',
          newUser.phoneNumber ?? '',
          newUser.gender ?? Gender.other,
          newUser.address ?? '',
          newUser.role,
          context);
      showSnackbar(context, 'sucesss');
      setState(() {
        load();
      });
    }
  }

  void load() {
    users = context.read<AuthenticationProvider>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      bottom: GestureDetector(
        onTap: () => onCreate(),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xff16A34A),
          ),
          height: 70,
          child: const Text(
            'Create a new User',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      title: 'User',
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => onEdit(users[index]),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1}. ${users[index].email}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => onRemove(users[index]),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )
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
