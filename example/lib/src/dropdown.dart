import 'package:flutter/material.dart';

class UDropdownButton<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;

  const UDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
