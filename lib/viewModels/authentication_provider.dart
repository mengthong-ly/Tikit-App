import 'package:event_with_thong/models/gender.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:event_with_thong/services/authentication_service.dart';
import 'package:event_with_thong/view/operator/tikit_custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationService authenticationService = AuthenticationService.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isOperator => _currentUser!.role == UserRoleModel.admin;

  set currentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> initialLoader() async {
    await loadUser();
    await loadCurrentUser();
    notifyListeners();
  }

  Future<void> loadUser() async {
    await authenticationService.loadUsers();
    notifyListeners();
  }

  Future<void> updateUser(UserModel oldUser) async {
    bool isDone = await authenticationService.updateUser(oldUser);
    if (isDone) {
      await initialLoader();
    }
    notifyListeners();
  }

  Future<void> operatorUpdateUser(UserModel oldUser) async {
    await authenticationService.operatorUpdateUser(oldUser);
    notifyListeners();
  }

  Future<bool> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // await loadUser();
      if (await authenticationService.validateUserByEmail(email, password)) {
        TikitCustomSnackBar.show(context, 'done');
        await authenticationService.setCurrentUser(email);
        await loadCurrentUser();
        notifyListeners();
        return true;
      } else {
        TikitCustomSnackBar.show(context, 'fail');
        return false;
      }
    } catch (e) {
      TikitCustomSnackBar.show(context, 'error');
      Logger().e('Error during login: $e');
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (password != confirmPassword) {
      TikitCustomSnackBar.show(context, 'Password is not match');
      return false;
    }
    if (!authenticationService.findUserExistingByEmail(email)) {
      TikitCustomSnackBar.show(context, 'User already exists');
      return false;
    }

    final UserModel user = UserModel(
        id: (authenticationService.totalUser).toString(),
        email: email,
        password: password);

    await authenticationService.addUserToDatabase(user)
        ? TikitCustomSnackBar.show(context, 'Welcome new User')
        : false;

    return true;
  }

  Future<bool> createUserByOperator(
    String email,
    String password,
    String confirmPassword,
    String name,
    String phoneNumber,
    Gender gender,
    String address,
    UserRoleModel role,
    BuildContext context,
  ) async {
    if (password != confirmPassword) {
      TikitCustomSnackBar.show(context, 'Password is not match');
      return false;
    }
    if (!authenticationService.findUserExistingByEmail(email)) {
      TikitCustomSnackBar.show(context, 'User already exists');
      return false;
    }

    final UserModel user = UserModel(
        id: authenticationService.totalUser.toString(),
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        gender: gender,
        address: address,
        role: role);

    await authenticationService.createNewUserByOperator(user)
        ? TikitCustomSnackBar.show(context, 'Welcome new User')
        : false;

    return true;
  }

  Future<void> loadCurrentUser() async {
    final user = await authenticationService.getCurrentUser();
    if (user != null) {
      currentUser = user;
      Logger().d('current User Temporary Save');
    } else {
      Logger().e("User Not Login: $user");
    }
    notifyListeners();
  }

  Future<bool> operatorRemoveUser(UserModel user) async {
    return await authenticationService.removeUser(user);
  }

  Future<void> logout(BuildContext context) async {
    try {
      await authenticationService.removeUserFromCurrentUser(currentUser!);
      currentUser = null;
      TikitCustomSnackBar.show(
        context,
        'logged out successfully',
      );
    } catch (e) {
      Logger().e('Error during logout: $e');
      TikitCustomSnackBar.show(
        context,
        'Can\'t you log out',
      );
    }
    notifyListeners();
  }

  List<UserModel> getAllUsers() {
    return authenticationService.userDatabase.users;
  }
}
