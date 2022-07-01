import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/colors.dart';
import '../../../global/utilities/size_helper.dart';
import '../../../models/paper.dart';
import '../../../providers/paper_provider.dart';
import '../../paper_view/paper_view_screen.dart';

class PaperWidget extends StatelessWidget {
  final Paper paper;
  const PaperWidget({
    Key? key,
    required this.paper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaperProvider paperProvider = Provider.of<PaperProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Tooltip(
            message: paper.title,
            child: Text(
              paper.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
          const Divider(
            color: kLightGreen,
            thickness: 1.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: _getAuthors(paper.authors),
                child: SizedBox(
                  width: SizeHelper(context).width * 0.6,
                  child: Text(
                    _getAuthors(paper.authors),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaperViewScreen(
                          pdfLink: paper.pdfLink,
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      size: 35.0,
                      color: kLightGreen,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      paperProvider.checkIfBookmarked(paper)
                          ? await paperProvider.unbookmarkPaper(paper)
                          : await paperProvider.bookmarkPaper(paper);
                    },
                    icon: Icon(
                      paperProvider.checkIfBookmarked(paper)
                          ? Icons.bookmark_added
                          : Icons.bookmark_add_outlined,
                      size: 35.0,
                      color: kLightGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(
          color: kPrimaryBlue,
          width: 3.0,
        ),
      ),
    );
  }

  String _getAuthors(List<String> authors) {
    String output = authors[0];
    if (authors.length > 1) {
      output += ', ${authors[1]}';
    }
    if (authors.length > 2) {
      output += ' etc.';
    }
    return output;
  }
}
