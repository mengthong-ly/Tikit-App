import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalProfilePage extends StatefulWidget {
  UserModel user;
  final void Function(UserModel) callback;
  PersonalProfilePage({super.key, required this.user, required this.callback});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  late UserModel currentUser;
  String get userName => widget.user.name ?? '--';
  String get gender => widget.user.gender?.name ?? '--';
  String get email => widget.user.email;
  String get phoneNumber => widget.user.phoneNumber ?? '--';
  String get address => widget.user.address ?? '--';
  String get joinDate => DateFormat('MM/dd/yyyy')
      .format(DateTime.parse(widget.user.createdAt ?? '--'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                size: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
                widget.callback(widget.user);
              },
            ),
          ],
          surfaceTintColor: Colors.transparent,
          title: Text(
            'My Account',
            style: TTextTheme.lightTextTheme.headlineSmall,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                    fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
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
                'role: ${widget.user.role.name}',
                style: TextStyle(
                    fontSize: TTextTheme.lightTextTheme.bodyMedium!.fontSize,
                    fontWeight:
                        TTextTheme.lightTextTheme.bodyMedium!.fontWeight,
                    color: const Color(0xff808080)),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            buildProfileDataRow('Name', userName),
            buildProfileDataRow('Gender', gender),
            buildProfileDataRow('Email', email),
            buildProfileDataRow('Phone Number', phoneNumber),
            buildProfileDataRow('Address', address),
            buildProfileDataRow('Join in', joinDate),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Transform.scale(
                scale: 2.3, child: Image.asset('assets/image/Picture1.png')),
            const SizedBox(
              height: 17,
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileDataRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff808080)),
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildProfileCard(BuildContext context, UserModel user) {
  return Align(
    child: Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 5,
              color: Color.fromARGB(19, 69, 69, 69))
        ],
      ),
      child: ClipRRect(
        child: Stack(
          children: [
            Positioned(
              left: 30,
              bottom: 60,
              child: Align(
                child: Transform.scale(
                  scale: 3,
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            strokeAlign: 0.05, color: const Color(0xffFD2942))),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -40,
              bottom: -60,
              child: Align(
                child: Transform.scale(
                  scale: 3,
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            strokeAlign: 0.05, color: const Color(0xffFD2942))),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: const Color(0xffFD2942))),
                    width: 90,
                    height: 90,
                    child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/8.png')),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffFD2942),
                          borderRadius: BorderRadius.circular(3)),
                      width: 130,
                      height: 25,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            user.name ?? 'User',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Text(user.email)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class AccountDetailItem extends StatelessWidget {
  final String label;
  final String detail;
  const AccountDetailItem({
    super.key,
    required this.label,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:'),
          SizedBox(
            width: 230,
            child: Text(
              textAlign: TextAlign.right,
              detail,
              style: const TextStyle(
                color: Color(0xff808080),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
