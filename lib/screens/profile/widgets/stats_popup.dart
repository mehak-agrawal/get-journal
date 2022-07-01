import 'package:flutter/material.dart';
import '../../../services/stat_service.dart';

import '../../../global/constants/colors.dart';

class StatsPopup extends StatelessWidget {
  final StatService _statService = StatService();
  StatsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.pie_chart,
                      size: 35.0,
                      color: kPrimaryBlue,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Statistics',
                      style: TextStyle(
                        fontSize: 35.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Center(
                  child: FutureBuilder<int>(
                    future: _statService.getTimeSpent(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator(
                          color: kPrimaryBlue,
                        );
                      } else {
                        return Text(
                          'Time spent reading: \n${snapshot.data} minute (s)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30.0,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: FutureBuilder<int>(
                    future: _statService.getReadPapers(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator(
                          color: kPrimaryBlue,
                        );
                      } else {
                        return Text(
                          'Read a total of \n${snapshot.data} paper (s)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30.0,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: kLightGreen,
                width: 2.0,
              ),
              color: kLightBlue.withOpacity(0.8),
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
          ),
        ),
      ],
    );
  }
}
