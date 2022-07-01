import 'dart:async';

import 'package:flutter/material.dart';
import '../../services/stat_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../global/widgets/reusable_button.dart';

class PaperViewScreen extends StatefulWidget {
  final String pdfLink;

  const PaperViewScreen({
    Key? key,
    required this.pdfLink,
  }) : super(key: key);

  @override
  State<PaperViewScreen> createState() => _PaperViewScreenState();
}

class _PaperViewScreenState extends State<PaperViewScreen>
    with WidgetsBindingObserver {
  bool _loadSuccess = true;
  int _seconds = 0;
  late Timer _timer;
  final StatService _statService = StatService();

  @override
  void initState() {
    super.initState();
    _statService.addToReadPapers(widget.pdfLink);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _seconds++,
    );
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _timer.cancel();
    _statService.updateTimeSpent(_seconds);
    _seconds = 0;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _timer =
            Timer.periodic(const Duration(seconds: 1), (timer) => _seconds++);
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _timer.cancel();
        _statService.updateTimeSpent(_seconds);
        _seconds = 0;
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _loadSuccess
            ? SfPdfViewer.network(
                widget.pdfLink,
                onDocumentLoadFailed: (details) {
                  setState(
                    () {
                      _loadSuccess = false;
                    },
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PDF view not available for this paper',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    ReusableButton(
                      text: 'GO TO LINK',
                      onTap: () async {
                        await launchUrlString(widget.pdfLink);
                      },
                    ),
                    const SizedBox(height: 15.0),
                    ReusableButton(
                      text: 'GO BACK',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
