import 'package:flutter/material.dart';

///Экранчик, когда данных нет
class EmptyWidget extends StatefulWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Здесь пока ничего нет"),);
  }
}
