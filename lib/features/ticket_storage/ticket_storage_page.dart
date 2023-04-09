import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/bloc/app_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/no_data.dart';
import 'package:surf_flutter_study_jam_2023/features/tickets_list.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранение билетов'),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppStateNoData) {
            return const EmptyWidget();
          } else if (state is AppStateDataExists) {
            return TicketsList(
              ticketModels: state.ticketModels,
              progress: state.progress,
              status: state.status,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<AppBloc>().add(
                AppEventAddNewTicket(
                    context: context,
                    onAddButtonPressed: (url) {
                      context.read<AppBloc>().add(
                            AppEventTicketStorage(
                              url: url,
                            ),
                          );
                    }),
              );
        },
        label: const Text('Добавить'),
      ),
    );
  }
}
