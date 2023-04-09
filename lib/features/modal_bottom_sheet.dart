import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/modal_sheet_content.dart';

///Класс, который заведует модалкой
class ModalBottomSheet {
  static void showModal({
    required BuildContext context,
    required void Function(String url) onAddButtonPressed,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (
        context,
      ) {
        return ModalSheetContent(
          onAddButtonPressed: (url) {
            onAddButtonPressed(url);
          },
        );
      },
    );
  }
}
