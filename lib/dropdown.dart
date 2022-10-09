import 'package:coop/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  const DropdownMenu({
    Key? key,
    required this.items,
    required this.label,
    required this.isRequired,
    required this.validator,
    required this.onChanged,
    this.isSearchable,
  }) : super(key: key);

  final List<String> items;
  final String label;
  final bool isRequired;
  final Function validator;
  final Function onChanged;
  final bool? isSearchable;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      key: key,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) => validator(value)),
      popupProps: PopupProps.modalBottomSheet(
        modalBottomSheetProps: const ModalBottomSheetProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
        showSearchBox: isSearchable ?? true,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: Icon(
                Icons.search,
              )),
        ),
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: "${this.label} ",
              style: Theme.of(context).textTheme.subtitle1,
              children: isRequired
                  ? const [
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: kErrorColor),
                      )
                    ]
                  : null,
            ),
          ),
        ),
      ),
      onChanged: (value) => onChanged(value),
    );
  }
}

class DropdownMenuWithImage extends StatelessWidget {
  const DropdownMenuWithImage(
      {Key? key,
      required this.items,
      required this.label,
      required this.isRequired,
      required this.validator,
      required this.onChanged})
      : super(key: key);

  final List<Map<String, String>> items;
  final String label;
  final bool isRequired;
  final Function validator;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, String>>(
      key: key,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) => validator(value)),
      dropdownBuilder: (context, selectedItem) => ListTile(
        title: Text(selectedItem?["title"] ?? "NULL"),
        leading: Image.asset(selectedItem?['icon'] ?? 'assets/images/otp.png'),
      ),
      popupProps: const PopupProps.modalBottomSheet(
        modalBottomSheetProps: ModalBottomSheetProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: Icon(
                Icons.search,
              )),
        ),
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: "${this.label} ",
              style: Theme.of(context).textTheme.subtitle1,
              children: isRequired
                  ? const [
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: kErrorColor),
                      )
                    ]
                  : null,
            ),
          ),
        ),
      ),
      onChanged: (value) => onChanged(value),
    );
  }
}
