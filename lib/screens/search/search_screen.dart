import 'package:flutter/material.dart';
import '../../global/widgets/reusable_button.dart';
import 'package:provider/provider.dart';

import '../../global/constants/colors.dart';
import '../../providers/paper_provider.dart';

class SearchScreen extends StatefulWidget {
  final Function onPop;
  const SearchScreen({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PaperProvider paperProvider = Provider.of<PaperProvider>(context);

    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              widget.onPop(false);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: kPrimaryBlue,
              size: 30.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _searchController,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search by author or title',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: kPrimaryBlue,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: kPrimaryBlue,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          ReusableButton(
            text: _searching ? 'SEARCHING...' : 'SEARCH',
            onTap: _searching
                ? () {}
                : () async {
                    if (_searchController.text.isNotEmpty) {
                      setState(
                        () {
                          _searching = true;
                        },
                      );
                      await paperProvider
                          .searchForPapers(_searchController.text.trim());
                      setState(
                        () {
                          _searching = false;
                        },
                      );
                      if (paperProvider.searchResults.isNotEmpty) {
                        Navigator.pop(context);
                        widget.onPop(true);
                      }
                    }
                  },
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
    );
  }
}
