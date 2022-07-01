import 'package:flutter/material.dart';

import '../models/paper.dart';
import '../services/paper_service.dart';

class PaperProvider extends ChangeNotifier {
  final PaperService _paperService = PaperService();

  List<Paper> _searchResults = [], _bookmarkedPapers = [];
  bool _bookmarksOn = true;

  checkIfBookmarked(Paper paper) {
    for (Paper bookmark in _bookmarkedPapers) {
      if (paper.id == bookmark.id) {
        return true;
      }
    }
    return false;
  }

  bookmarkPaper(Paper paper) async {
    await _paperService.bookmarkPaper(paper);
    await updateBookmarks();
  }

  unbookmarkPaper(Paper paper) async {
    await _paperService.unbookmarkPaper(paper);
    await updateBookmarks();
  }

  updateBookmarks() async {
    _bookmarkedPapers = await _paperService.getBookmarks();
    notifyListeners();
  }

  searchForPapers(String query) async {
    _searchResults = await _paperService.queryPapers(query);
    _bookmarksOn = false;
    notifyListeners();
  }

  void setBookmarkVisibility(bool newValue) async {
    _bookmarksOn = newValue;
    if (_bookmarksOn) {
      await updateBookmarks();
    }
    notifyListeners();
  }

  bool get bookmarksOn => _bookmarksOn;
  List<Paper> get searchResults => _searchResults;
  List<Paper> get bookmarkedPapers => _bookmarkedPapers;
}
