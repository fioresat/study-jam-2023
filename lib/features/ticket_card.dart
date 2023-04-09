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

// class TicketCard extends StatefulWidget {
//   final TicketModel ticketModel;
//
//   const TicketCard({
//     Key? key,
//     required this.ticketModel,
//   }) : super(key: key);
//
//   @override
//   State<TicketCard> createState() => _TicketCardState();
// }
//
// class _TicketCardState extends State<TicketCard> {
//   double? progress = 0;
//   String status = "Ожидает начала загрузки";
//   final url = 'https://surf.ru/flutter/awesome.pdf';
//
//
//
//   void _downloadButtonPressed() async {
//     setState(() {
//       progress = 0;
//     });
//
//     final request = Request('GET', Uri.parse(url));
//
//     /// calling Client().send() instead of get(url) method.
//     /// Reason: send() gives you a stream, and you’re going to listen to the
//     /// stream of bytes as it downloads the file from the server
//     final StreamedResponse response = await Client().send(request);
//
//     /// response coming from the server contains a header called Content-Length,
//     /// which includes the total size of the file in bytes
//     final contentLength = response.contentLength;
//
//     /// Now that we have response from server, stop the spinning indicator & set it to 0
//     setState(() {
//       progress = 0.000001;
//       status = "Загружается";
//     });
//
//     /// Initialize variable to save the download in.
//     /// Array stores the file in memory before you save to storage.
//     /// Since the length of this array is the number of bytes that have been
//     /// downloaded, use this to track the progress of the download.
//     List<int> bytes = [];
//
//     /// place to store the file
//     final file = await _getFile('video.mp4');
//
//     response.stream.listen(
//       (List<int> newBytes) {
//         // update progress
//         bytes.addAll(newBytes);
//         final downloadedLength = bytes.length;
//         setState(() {
//           progress = downloadedLength.toDouble() / (contentLength ?? 1);
//           status =
//               "Загружается: ${downloadedLength.toDouble()} из $contentLength";
//         });
//         //print("progress: $progress");
//       },
//       onDone: () async {
//         // save file
//         setState(() {
//           progress = 1;
//           status = "Файл загружен";
//         });
//         await file.writeAsBytes(bytes);
//
//         /// file has been downloaded
//         /// show success to user
//         debugPrint("Download finished");
//       },
//       onError: (e) {
//         /// if user loses internet connection while downloading the file, causes an error.
//         /// You can decide what to do about that in onError.
//         /// Setting cancelOnError to true will cause the StreamSubscription to get canceled.
//         debugPrint(e);
//       },
//       cancelOnError: true,
//     );
//
//     /// using Flutter package "dio":
//     //      Dio dio = Dio();
//     //      dio.download(urlOfFileToDownload, '$dir/$filename',
//     //         onReceiveProgress(received,total) {
//     //         setState(() {
//     //           int percentage = ((received / total) * 100).floor();
//     //         });
//     //      });
//   }
//
//   /// Finds an appropriate place on the user’s device to put the file.
//   /// In this case we are choosing to use the temp directory.
//   /// You could also chose the documents directory or somewhere else.
//   /// This method is using the path_provider package to get that location.
//   Future<File> _getFile(String filename) async {
//     final dir = await getTemporaryDirectory();
//     // final dir = await getApplicationDocumentsDirectory();
//     return File("${dir.path}/$filename");
//   }
// }
