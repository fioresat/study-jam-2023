import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/consts/consts.dart';
import 'package:surf_flutter_study_jam_2023/features/modal_bottom_sheet.dart';
import 'package:surf_flutter_study_jam_2023/models/ticket_model.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _ticketsBox = Hive.box('tickets_box');

  AppBloc() : super(AppInitial()) {
    on<AppEventInitialize>((event, emit) {
      _ticketsBox.clear();
      final Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();
      if (ticketModels.length == 0) {
        emit(const AppStateNoData());
      } else {
        final Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();

        List<double> progress =
            ticketModels.map((e) => e.progress.toDouble()).toList();
        List<String> status = ticketModels.map((e) => e.status).toList();

        emit(AppStateDataExists(
          ticketModels: ticketModels,
          progress: progress,
          status: status,
        ));
      }
    });
    on<AppEventAddNewTicket>((event, emit) {
      ModalBottomSheet.showModal(
        context: event.context,
        onAddButtonPressed: (url) {
          event.onAddButtonPressed(url);
        },
      );
      final Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();
      if (ticketModels.isEmpty) {
        emit(const AppStateNoData());
      } else {
        final Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();
        List<double> progress =
            ticketModels.map((e) => e.progress.toDouble()).toList();
        List<String> status = ticketModels.map((e) => e.status).toList();
        emit(AppStateDataExists(
          ticketModels: ticketModels,
          progress: progress,
          status: status,
        ));
      }
    });
    on<AppEventTicketStorage>((event, emit) async {
      int icon = Random().nextInt(3);
      String name = DateTime.now().millisecondsSinceEpoch.toString();
      final ticketModel = TicketModel(
        icon: icon,
        url: event.url,
        name: name,
        progress: 0,
      );
      await _ticketsBox.add(ticketModel);
      final Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();
      List<double> progress =
          ticketModels.map((e) => e.progress.toDouble()).toList();
      List<String> status = ticketModels.map((e) => e.status).toList();
      emit(AppStateDataExists(
        ticketModels: ticketModels,
        progress: progress,
        status: status,
      ));
    });
    on<AppEventLoading>((event, emit) async {
      Iterable<TicketModel> ticketModels = _ticketsBox.values.cast();
      List<double> progress =
          ticketModels.map((e) => e.progress.toDouble()).toList();
      List<String> status = ticketModels.map((e) => e.status).toList();
      final dir = await getTemporaryDirectory();
      var dio = Dio();
      print(event.ticketModel.url);
      await dio.download(
        event.ticketModel.url,
        '${dir.path}/${event.ticketModel.name}.pdf',
        onReceiveProgress: (receivedBytes, totalBytes) {
          progress[event.index] = receivedBytes / totalBytes;
          status[event.index] = 'Загружается $receivedBytes из $totalBytes';

          emit(AppStateDataExists(
            ticketModels: ticketModels,
            progress: progress,
            status: status,
          ));
        },
      );

      final ticketModel = TicketModel(
        icon: event.ticketModel.icon,
        url: event.ticketModel.url,
        name: event.ticketModel.name,
        progress: 1,
        status: Consts.downloading,
      );

      _ticketsBox.delete(event.ticketModel.url);
      await _ticketsBox.put(event.ticketModel.url, ticketModel);
      ticketModels = _ticketsBox.values.cast();
      progress = ticketModels.map((e) => e.progress.toDouble()).toList();
      status = ticketModels.map((e) => e.status).toList();

      emit(AppStateDataExists(
        ticketModels: ticketModels,
        progress: progress,
        status: status,
      ));
    });
  }
}
