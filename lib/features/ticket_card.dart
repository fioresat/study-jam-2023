import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket_model.dart';

///Карточка билета
class TicketCard extends StatelessWidget {
  final TicketModel ticketModel;
  final double progress;
  final String status;
  final void Function() onDownloadPressed;

  const TicketCard({
    Key? key,
    required this.ticketModel,
    required this.progress,
    required this.status, required this.onDownloadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ticketModel.icon == 0
          ? const Icon(Icons.airplane_ticket)
          : ticketModel.icon == 1
              ? const Icon(Icons.directions_railway_filled_outlined)
              : const Icon(Icons.bus_alert_outlined),
      title: Column(
        children: [
          Text(
            ticketModel.name,
          ),
          LinearProgressIndicator(
            value: progress,
          ),
          Text(status),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          onDownloadPressed();
        },
        icon: ticketModel.progress == 0
            ? const Icon(Icons.cloud_download)
            : progress == 1
                ? const Icon(Icons.cloud_done)
                : const Icon(Icons.pause_circle_outline),
      ),
    );
  }
}

