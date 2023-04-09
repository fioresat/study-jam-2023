import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/consts/consts.dart';

part 'ticket_model.g.dart';

///Здесь храним модельку Билета и Заводим Hive
@HiveType(typeId: 0)
class TicketModel {
  @HiveField(0)
  int icon;
  @HiveField(1)
  String name;
  @HiveField(2)
  String url;
  @HiveField(3)
  int progress;
  @HiveField(4)
  String status;

  TicketModel({
    int? icon,
    String? name,
    String? url,
    int? progress,
    String? status,
  })  : name = name ?? '',
        url = url ?? '',
        status = status ?? Consts.waitingForLoading,
        progress = progress ?? 0,
        icon = icon ?? 0;
}
