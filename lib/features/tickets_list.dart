import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/bloc/app_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_card.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket_model.dart';

///Список Билетов
class TicketsList extends StatelessWidget {
  final Iterable<TicketModel> ticketModels;
  final List<double> progress;
  final List<String> status;

  const TicketsList({
    Key? key,
    required this.ticketModels,
    required this.progress,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ticketModels.length,
        itemBuilder: (context, index) {
          return TicketCard(
            ticketModel: ticketModels.elementAt(index),
            progress: progress[index],
            status: status[index],
            onDownloadPressed: () {
              context.read<AppBloc>().add(
                    AppEventLoading(
                      index: index,
                      ticketModel: ticketModels.elementAt(index),
                    ),
                  );
            },
          );
        });
  }
}
