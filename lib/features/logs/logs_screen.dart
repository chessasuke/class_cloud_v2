import 'dart:convert';
import 'dart:io';

import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/features/logs/cubit/logs_cubit.dart';
import 'package:class_cloud/features/logs/cubit/logs_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      0, //_scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

    Future<void> _share(String logs) async {
      if (kDebugMode) {
        final localPath = (await getApplicationDocumentsDirectory()).path;
        final fileName = 'Logs-${DateTime.now().toIso8601String()}.txt';
        final path = '$localPath/$fileName';
        final file = File(path);
        await file.writeAsString(logs);
        await Share.shareXFiles(
          [
            XFile(
              path,
              mimeType: 'text/plain',
            ),
          ],
          subject: fileName,
        );
      } else {
        final scaffold = ScaffoldMessenger.of(context);
        /// Sharing from simulator is not friendly when you don't have 3rd 
        /// party apps. In that case logs are copied to clipboard. 
        /// In case of too big size of [logs] we are taking 1kk bytes of logs.
        final bytes = utf8.encode(logs).take(1000000).toList();
        final shortenedLogs = utf8.decode(bytes);
        await Clipboard.setData(ClipboardData(text: shortenedLogs));
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Logs copied to clipboard'),
          ),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: _scrollToBottom,
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              final logs = context.read<LogsCubit>().state.logs;
              final logsString = logs
                  .map((log) => '${log.time} - ${log.loggerName} - ${log.message}')
                  .join('\n');
              _share(logsString);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<LogsCubit, LogsState>(
          builder: (context, state) {
            final logs = state.logs;
            if (logs.isEmpty) {
              return const Center(child: Text('No logs available'));
            }
            return ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              reverse: true,
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs.reversed.toList()[index];
                Widget tile;
                final DateTime time = log.time;
                final String formattedTime =
                    '${DateFormat('yyyy/MM/dd hh:mm:ss').format(time)} (${time.timeZoneName})';
                if (log.level <= Level.INFO) {
                  tile = ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${log.loggerName} - ${log.message}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  tile = ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${log.loggerName} - ${log.message}\n\nError: ${log.error}\n\nStack Trace:\n${log.stackTrace}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                tile = GestureDetector(
                  onLongPress: () {},
                  child: tile,
                );

                return Column(
                  children: [
                    tile,
                    if (index != 0) const Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
