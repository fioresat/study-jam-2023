part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

/// Вызывается при запуске приложения
@immutable
class AppEventInitialize implements AppEvent {
  const AppEventInitialize() : super();
}

///Вызывается при нажатии на кнопку загрузить
@immutable
class AppEventLoading implements AppEvent {
  final TicketModel ticketModel;
  final int index;

  const AppEventLoading({
    required this.index,
    required this.ticketModel,
  }) : super();
}

@immutable
class AppEventLoaded implements AppEvent {
  const AppEventLoaded() : super();
}

///Вызывается, если добавлен хотя бы один билет
@immutable
class AppEventTicketStorage implements AppEvent {
  final String url;

  const AppEventTicketStorage({
    required this.url,
  }) : super();
}

///Вызывается при нажатии fab "Добавить" на TicketStoragePage.
@immutable
class AppEventAddNewTicket implements AppEvent {
  final BuildContext context;
  final void Function(String url) onAddButtonPressed;

  const AppEventAddNewTicket({
    required this.onAddButtonPressed,
    required this.context,
  }) : super();
}
