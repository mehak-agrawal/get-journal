import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/colors.dart';
import '../../../providers/paper_provider.dart';

class BookmarkSwitch extends StatelessWidget {
  const BookmarkSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paperProvider = Provider.of<PaperProvider>(context);

    return CupertinoSwitch(
      thumbColor: kLightGreen,
      trackColor: kPrimaryBlue.withOpacity(0.7),
      activeColor: kPrimaryBlue,
      value: paperProvider.bookmarksOn,
      onChanged: (value) {
        paperProvider.setBookmarkVisibility(value);
      },
    );
  }
}
