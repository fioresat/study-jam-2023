import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/consts/consts.dart';

///Экранчик, когда данных нет
class EmptyWidget extends StatefulWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(Consts.empty),);
  }
}
