import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import '../models/user.dart';

class AuthenticationService extends BaseService {
  AuthenticationService._proviateInstance();
  static final AuthenticationService _instance =
      AuthenticationService._proviateInstance();
  static AuthenticationService get instance => _instance;

  UserDatabase userDatabase = UserDatabase.instance;

  int get totalUser => userDatabase.users.length + 1;

  // done
  Future<void> loadUsers() async {
    // await Hive.deleteBoxFromDisk('vendor');
    // await Hive.deleteBoxFromDisk('users');
    // await Hive.deleteBoxFromDisk('taxon');
    // await Hive.deleteBoxFromDisk('currentUser');
    // await Hive.deleteBoxFromDisk('cart');
    // await Hive.deleteBoxFromDisk('product_taxon');
    // await Hive.deleteBoxFromDisk('order');
    // await Hive.deleteBoxFromDisk('payment');
    // await Hive.deleteBoxFromDisk('product');
    // await Hive.deleteBoxFromDisk('stock');
    // await Hive.close();
    try {
      if (await checkBox('users')) {
        final myBox = await getBox<UserModel>('users');
        userDatabase.users = myBox.values.toList();
        Logger().d('Loaded from Hive successfully');
      } else {
        final myBox = await getBox<UserModel>('users');
        await myBox.putAll(userDatabase.users.asMap());
        Logger().d('Loaded from local storage and stored in Hive successfully');
      }
    } catch (e) {
      Logger().d('load users fail: $e');
    }
  }

  // done
  Future<bool> addUserToDatabase(UserModel user) async {
    try {
      final userBox = await getBox<UserModel>('users');
      await userBox.add(user);
      await loadUsers();
      await setCurrentUser(user.email);
      return true;
    } catch (e) {
      Logger().d('add user fail: $e');
      return true;
    }
  }

  Future<bool> createNewUserByOperator(UserModel user) async {
    try {
      final mybox = await getBox<UserModel>('users');
      await mybox.add(user);
      await loadUsers();
      return true;
    } catch (e) {
      Logger().d('create user errror: $e');
      return false;
    }
  }

  // done
  Future<bool> updateUser(UserModel updatedUser) async {
    try {
      int indexOfUser =
          userDatabase.users.indexWhere((user) => user.id == updatedUser.id);
      if (indexOfUser == -1) {
        Logger().d('update fail');
        return false;
      }

      final myBox = await getBox<UserModel>('users');
      await myBox.put(indexOfUser, updatedUser);
      await setCurrentUser(updatedUser.email);
      return true;
    } catch (e) {
      Logger().d('update fail: $e');
      return false;
    }
  }

  Future<bool> operatorUpdateUser(UserModel updatedUser) async {
    try {
      int indexOfUser =
          userDatabase.users.indexWhere((user) => user.id == updatedUser.id);

      if (indexOfUser == -1) {
        Logger().d('update fail');
        return false;
      }
      final mybox = await getBox<UserModel>('users');
      await mybox.put(indexOfUser, updatedUser);
      await loadUsers();
      return true;
    } catch (e) {
      Logger().d('update fail: $e');
      return false;
    }
  }

//  done
  Future<bool> validateUserByEmail(String email, String password) async {
    try {
      print('user ${userDatabase.users.length} }');
      int indexOfUser = userDatabase.users.indexWhere(
          (user) => user.email == email && user.password == password);
      if (indexOfUser == -1) return false;
      return true;
    } catch (e) {
      Logger().d('validateUserByEmail fail: $e');
      return false;
    }
  }

  bool findUserExistingByEmail(String email) {
    try {
      final indexOfExistingUser =
          userDatabase.users.indexWhere((user) => user.email == email);
      Logger().f(indexOfExistingUser);
      if (indexOfExistingUser == -1) return true;
      Logger().f(indexOfExistingUser);
      return false;
    } catch (e) {
      Logger().d('isUserExistByEmail fail: $e');
      return true;
    }
  }

  // done
  Future<bool> removeUser(UserModel user) async {
    try {
      final int indexOfUser = userDatabase.users.indexWhere(
        (model) => model.id == user.id,
      );
      if (indexOfUser == -1) return false;
      final myBox = await getBox<UserModel>('users');
      await myBox.deleteAt(indexOfUser);
      await loadUsers();
      return true;
    } catch (e) {
      Logger().d('removeUser fail: $e');
      return false;
    }
  }

//  done
  Future<UserModel?> getCurrentUser() async {
    // we store only id of currentUser
    try {
      final box = await getBox('currentUser');
      final String userId = await box.get(0);
      Logger().d('Load currentUser from hive successfully');
      return userDatabase.users.firstWhere((user) => user.id == userId);
    } catch (e) {
      Logger().d('getCurrentUser fail: $e');
      return null;
    }
  }

  // done
  Future<void> setCurrentUser(String email) async {
    final currentUserBox = await getBox('currentUser');
    final String userId =
        userDatabase.users.firstWhere((user) => user.email == email).id;
    await currentUserBox.put(0, userId);
  }

  // done
  Future<bool> removeUserFromCurrentUser(UserModel user) async {
    try {
      final currentUserBox = await getBox('currentUser');
      await currentUserBox.clear();
      return true;
    } catch (e) {
      Logger().d('removeFromCurrentUser fail: $e');
      return false;
    }
  }
}
