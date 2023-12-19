import 'package:flutter/material.dart';

class ProfileFragmentScreen extends StatelessWidget {
  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Image.asset(
            'men.jpg',
            width: 240,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        userInfoItemProfile(Icons.person, "user name"),
        const SizedBox(
          height: 20,
        ),
        userInfoItemProfile(Icons.email, "user@gmail.com"),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: Text(
                  "Salir",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
