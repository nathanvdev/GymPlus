import 'package:flutter/material.dart';

class MemberFormWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String emptyValueError;
  final bool isEmpty;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String) onChanged;
  final TextEditingController? controller;

  const MemberFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    this.emptyValueError = '',
    this.isEmpty = false,
    required this.onChanged,
    this.validator,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              onTap: onTap,
              validator: validator,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                border: const OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
