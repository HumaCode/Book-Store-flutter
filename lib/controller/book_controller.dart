import 'package:book_app/models/book_detail_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:book_app/models/book_list_response.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookList;

  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

// menampilkan status
    if (response.statusCode == 200) {
      // mengubah string ke json
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  // variabel global
  BookDetailResponse? detailBook;

  fetchDetailBookApi(isbn) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();

      fetchSimiliarBookApi(detailBook!.title!);
    }
  }

  BookListResponse? similiarBook;
  fetchSimiliarBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/${title}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBook = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }
}
