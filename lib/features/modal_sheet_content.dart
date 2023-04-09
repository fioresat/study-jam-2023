import 'package:flutter/material.dart';

import 'add_button.dart';

///Содержимое модалки
class ModalSheetContent extends StatefulWidget {
  final void Function(String url) onAddButtonPressed;

  const ModalSheetContent({
    Key? key,
    required this.onAddButtonPressed,
  }) : super(key: key);

  @override
  State<ModalSheetContent> createState() => _ModalSheetContentState();
}

class _ModalSheetContentState extends State<ModalSheetContent> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: keyBoardHeight > 0 ? keyBoardHeight + 10 : 10),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (url) {
                 return validator(url);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  labelText: 'Введите url',
                ),
              ),
            ),
            AddButton(
              isActive: true,
              onAddButtonPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ссылка успешно добавлена'),
                    ),
                  );
                  widget.onAddButtonPressed(controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String? validator(String? url) {
    if (RegExp(r'^https?://(?:[a-z0-9\-]+\.)+[a-z]{2,6}(?:/[^/#?]+)+\.(?:pdf)$')
        .hasMatch(url!)) {
      return null;
    } else {
      return 'Enter a valid url';
    }
  }
}
