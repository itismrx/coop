import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coop/appBar.dart';
import 'package:coop/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:unicons/unicons.dart';

import 'constant.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context, true),
        body: FutureBuilder(
          future:
              FirebaseFirestore.instance.collection("users").limit(100).get(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    UniconsLine.cloud_block,
                    color: kErrorColor,
                    size: 48,
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Text("Something went wrong"),
                ],
              ));
            }
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              List data = snapshot.data!.docs;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 60, bottom: 48),
                          child: Row(
                            children: [
                              Text(
                                "Scroll to the right to see all",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: kPrimaryColor),
                              ),
                              const SizedBox(
                                width: kPadding,
                              ),
                              const Icon(
                                Icons.swipe_right,
                                color: kPrimaryColor,
                              )
                            ],
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width + 200,
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Total regesterd users : ${data.length}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: kPadding,
                          ),
                          Table(
                            border: TableBorder.all(
                                color: kGray1,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text('Full Name',
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ]),
                                Column(children: [
                                  Text('Phone Number',
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ]),
                                Column(children: [
                                  Text('Address',
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ]),
                                Column(children: [
                                  Text('Occupation',
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ]),
                                Column(children: [
                                  Text('Nationality',
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ]),
                              ]),
                              ...data
                                  .map(
                                    (user) => TableRow(children: [
                                      Column(children: [
                                        Text(user['fullName'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ]),
                                      Column(children: [
                                        Text(user['phoneNumber'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ]),
                                      Column(children: [
                                        Text(user['address'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ]),
                                      Column(children: [
                                        Text(
                                            (user['ocupation'] as String)
                                                    .isEmpty
                                                ? "---"
                                                : user['ocupation'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ]),
                                      Column(children: [
                                        Text(user['nationality'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ]),
                                    ]),
                                  )
                                  .toList()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: kPadding * 4,
                    width: kPadding * 4,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimaryColor)),
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                  Text(
                    "Loading...",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
/*
Table(
            border: TableBorder.all(
                color: kGray1, style: BorderStyle.solid, width: 2),
            children: [
              TableRow(children: [
                Column(children: [
                  Text('Full Name',
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
                Column(children: [
                  Text('Phone Number',
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
                Column(children: [
                  Text('Address', style: Theme.of(context).textTheme.subtitle1)
                ]),
                Column(children: [
                  Text('Occupation',
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
                Column(children: [
                  Text('Nationality',
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
              ]),
              TableRow(children: [
                Column(
                  children: [
                    Text('Jhon Doe',
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
                Column(children: [
                  Text('+2519000000',
                      style: Theme.of(context).textTheme.subtitle2)
                ]),
                Column(children: [
                  Text('Addis Ababa',
                      style: Theme.of(context).textTheme.subtitle2)
                ]),
                Column(children: [
                  Text('IT Technician',
                      style: Theme.of(context).textTheme.subtitle2)
                ]),
                Column(children: [
                  Text('Ethiopian',
                      style: Theme.of(context).textTheme.subtitle2)
                ]),
              ]),
            ],
          ), */