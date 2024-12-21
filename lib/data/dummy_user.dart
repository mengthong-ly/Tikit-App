import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

List<UserModel> dummyUser = [
  UserModel(
    id: uuid.toString(),
    name: 'Meng Long',
    role: UserRoleModel.user,
    email: 'mengthong@gmail.com',
    address: 'st 230, beoung salang, toul kork, phnom penh',
    phoneNumber: '078785339',
    password: '123',
  )
];
