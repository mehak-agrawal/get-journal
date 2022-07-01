import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/constants/colors.dart';
import '../../providers/paper_provider.dart';
import 'widgets/paper_widget.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaperProvider paperProvider = Provider.of<PaperProvider>(context);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
        ),
        const Divider(
          indent: 15.0,
          endIndent: 15.0,
          color: kPrimaryBlue,
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (paperProvider.bookmarksOn) {
                paperProvider.updateBookmarks();
                return paperProvider.bookmarkedPapers.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'You haven\'t bookmarked any papers',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: paperProvider.bookmarkedPapers.length,
                        itemBuilder: (context, index) => PaperWidget(
                            paper: paperProvider.bookmarkedPapers[index]),
                      );
              } else {
                return paperProvider.searchResults.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Your search came up empty or your internet connection is poor',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: paperProvider.searchResults.length,
                        itemBuilder: (context, index) => PaperWidget(
                            paper: paperProvider.searchResults[index]),
                      );
              }
            },
          ),
        ),
      ],
    );
  }
}
