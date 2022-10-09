import 'package:coop/appBar.dart';
import 'package:coop/constant.dart';
import 'package:coop/list_screen.dart';
import 'package:coop/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Text(
              'Welcome Back 👋',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: kPrimaryColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(15),
                      color: kPrimaryColor.withOpacity(0.25),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            UniconsLine.user_plus,
                            color: kPrimaryColor,
                            size: 48,
                          ),
                          const SizedBox(
                            height: kPadding,
                          ),
                          Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(15),
                      color: kPrimaryColor.withOpacity(0.25),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            UniconsLine.list_ui_alt,
                            color: kPrimaryColor,
                            size: 48,
                          ),
                          const SizedBox(
                            height: kPadding,
                          ),
                          Text(
                            "View All",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
