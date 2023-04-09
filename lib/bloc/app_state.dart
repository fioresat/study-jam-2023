part of 'app_bloc.dart';

@immutable
abstract class AppState {
  const AppState();
}

///Ничего не делает
@immutable
class AppInitial extends AppState {}

///Состояние для пустого экрана
@immutable
class AppStateNoData extends AppState {
  const AppStateNoData();
}

///Состояние для экрана, на котором что-то есть
@immutable
class AppStateDataExists extends AppState {
  final Iterable<TicketModel> ticketModels;
  final List<double> progress;
  final List<String> status;

  const AppStateDataExists({
    required this.progress,
    required this.status,
    required this.ticketModels,
  });
}

///Это была идея, которую не успела додумать
@immutable
class AppStateLoading extends AppState {
  final double progress;
  final String status;

  const AppStateLoading({
    required this.progress,
    required this.status,
  });
}
