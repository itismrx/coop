import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coop/appBar.dart';
import 'package:coop/constant.dart';
import 'package:coop/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:unicons/unicons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isRegestering = false;
  final TextEditingController _phoneNumberEditingController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ocupationController = TextEditingController();
  String selectedAddress = "";
  String selecteNationaliy = "";

  Future<void> register(String fullName, String phoneNumber, String address,
      String? ocupation, String nationality) async {
    setState(() {
      isRegestering = true;
    });
    try {
      final tmpDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(phoneNumber)
          .get();
      if (tmpDoc.exists) {
        throw Exception("User Already Exists");
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(phoneNumber)
          .set({
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "address": address,
        "ocupation": ocupation ?? "",
        "nationality": nationality
      });
      setState(() {
        isRegestering = false;
      });
    } catch (e) {
      setState(() {
        isRegestering = false;
      });
      print(e.toString().substring(11, e.toString().length - 1));
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberEditingController.dispose();
    _nameController.dispose();
    _ocupationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                // FULL NAME
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Required Field";
                    }
                    return null;
                  }),
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                          text: "Full Name ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: const [
                            TextSpan(
                              text: "*",
                              style: TextStyle(color: kErrorColor),
                            )
                          ]),
                    ),
                    // contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                  ),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                //PHONE NUMBER
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneNumberEditingController,
                  onFieldSubmitted: (value) {
                    if (value.startsWith("0") && value.length == 10) {
                      _phoneNumberEditingController.text =
                          _phoneNumberEditingController.text.substring(1);

                      // return "\u26A0 Please provide a valid phone number";
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return "\u26A0 Required field";
                    } else if (value.isEmpty) {
                      return "\u26A0 Required field";
                    } else if (value.contains(RegExp(r'^[0-9]+$')) != true) {
                      return "\u26A0 Only number inputs are allowed";
                    } else if (value.startsWith("0") && value.length != 10) {
                      return "\u26A0 Please provide a valid phone number";
                    } else if (!value.startsWith("0") && value.length != 9) {
                      return "\u26A0 Please provide a valid phone number";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                    label: RichText(
                      text: TextSpan(
                          text: "Phone Number ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: const [
                            TextSpan(
                              text: "*",
                              style: TextStyle(color: kErrorColor),
                            )
                          ]),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 1,
                        top: 1,
                        bottom: 1,
                        right: 8,
                      ),
                      child: Container(
                        width: 45,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8))),
                        child: const Text("+251"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                //ADDRESS
                DropdownMenu(
                  items: cities,
                  isRequired: true,
                  label: "Address",
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedAddress = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "\u26A0 Required field";
                    }
                  },
                ),
                const SizedBox(
                  height: kPadding,
                ),
                //OCCUPATION
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _ocupationController,
                  decoration: const InputDecoration(
                    label: Text("Occupation"),
                    // contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                  ),
                ),
                const SizedBox(
                  height: kPadding,
                ),
                //NATIONALITY
                DropdownMenu(
                  items: nationality,
                  isRequired: true,
                  label: "Nationality",
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selecteNationaliy = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "\u26A0 Required field";
                    }
                  },
                ),
                const SizedBox(
                  height: kPadding,
                ),
                //REGESTER BUTTON
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState?.validate() == true) {
                      try {
                        await register(
                          _nameController.text.trim(),
                          _phoneNumberEditingController.text.trim(),
                          selectedAddress,
                          _ocupationController.text.trim(),
                          selecteNationaliy,
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: kPrimaryColor,
                            content: Row(
                              children: const [
                                Icon(
                                  UniconsLine.check_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: kPadding,
                                ),
                                Text("Successfully Created an account.")
                              ],
                            )));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: kErrorColor,
                            content: Row(
                              children: [
                                const Icon(
                                  UniconsLine.exclamation_triangle,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: kPadding, //Exception:
                                ),
                                Text(
                                  "${(e.toString().split(":").last).trim()}",
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )));
                      }
                    }
                  },
                  child: Container(
                    height: kPadding * 3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPrimaryColor),
                    child: isRegestering
                        ? const SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.white),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
