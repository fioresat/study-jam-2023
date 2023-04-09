import 'package:flutter/material.dart';

///Кнопка "Добавить"
class AddButton extends StatelessWidget {
  final bool isActive;
  final void Function()? onAddButtonPressed;

  const AddButton({
    Key? key,
    required this.onAddButtonPressed,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, top: 20),
      child: FilledButton(
        onPressed: isActive ? onAddButtonPressed : null,
        child: const Text("Добавить"),
      ),
    );
  }
}
