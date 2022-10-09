import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'constant.dart';
import 'login_screen.dart';

PreferredSizeWidget getAppBar(BuildContext context, bool showLeading) {
  return AppBar(
    elevation: 0,
    shadowColor: Colors.black54,
    centerTitle: true,
    leading: showLeading
        ? IconButton(
            onPressed: (() => Navigator.of(context).pop()),
            icon: const Icon(
              UniconsLine.arrow_left,
              color: kGray1,
            ))
        : null,
    title: Hero(
      tag: "logo",
      child: Image.asset(
        'assets/images/logo.png',
        height: 35,
        // width: 300,
        fit: BoxFit.contain,
      ),
    ),
    actions: [
      Tooltip(
        message: "Logout",
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              icon: const Icon(
                UniconsLine.power,
                color: kGray1,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            )),
      )
    ],
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}
