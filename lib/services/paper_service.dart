import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../models/paper.dart';

class PaperService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Uri _constructUrl(String query) {
    return Uri.parse(
        'http://export.arxiv.org/api/query?search_query=all:"$query"&start=0&max_results=20');
  }

  Future<List<Paper>> queryPapers(String query) async {
    http.Response response = await http.get(
      _constructUrl(query),
    );
    if (response.statusCode == 200) {
      var atomFeed = AtomFeed.parse(response.body);
      return atomFeed.items?.map((e) => Paper.fromAtomItem(e)).toList() ?? [];
    } else {
      return [];
    }
  }

  Future<List<Paper>> getBookmarks() async {
    try {
      var list = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email ?? '')
          .collection('bookmarks')
          .get();
      return list.docs.map((e) => Paper.fromMap(e.data())).toList();
    } catch (_) {
      return [];
    }
  }

  Future unbookmarkPaper(Paper paper) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .collection('bookmarks')
          .doc(paper.id
              .substring(paper.id.lastIndexOf('/') + 1)
              .replaceAll('.', ''))
          .delete();
    } catch (_) {}
  }

  Future bookmarkPaper(Paper paper) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .collection('bookmarks')
          .doc(
            paper.id
                .substring(paper.id.lastIndexOf('/') + 1)
                .replaceAll('.', ''),
          )
          .set(
            paper.toMap(),
          );
    } catch (_) {}
  }
}
