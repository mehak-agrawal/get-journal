import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:webfeed/domain/atom_item.dart';

class Paper {
  String id;
  String title;
  List<String> authors;
  String pdfLink;

  Paper({
    required this.id,
    required this.title,
    required this.authors,
    required this.pdfLink,
  });

  Paper copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? pdfLink,
  }) {
    return Paper(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      pdfLink: pdfLink ?? this.pdfLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'pdfLink': pdfLink,
    };
  }

  factory Paper.fromMap(Map<String, dynamic> map) {
    return Paper(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      authors: List<String>.from(map['authors']),
      pdfLink: map['pdfLink'] ?? '',
    );
  }

  factory Paper.fromAtomItem(AtomItem atomItem) {
    return Paper(
      id: atomItem.id ?? '',
      title: atomItem.title ?? 'Title',
      pdfLink: atomItem.links?.first.href?.replaceFirst('abs', 'pdf') ??
          'google.com',
      authors: atomItem.authors?.map((e) => e.name ?? 'Author').toList() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Paper.fromJson(String source) => Paper.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Paper(id: $id, title: $title, authors: $authors, pdfLink: $pdfLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Paper &&
        other.id == id &&
        other.title == title &&
        listEquals(other.authors, authors) &&
        other.pdfLink == pdfLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ authors.hashCode ^ pdfLink.hashCode;
  }
}
