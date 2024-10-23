import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;
  PageManager(this._pageController);
  int page = 0;
  void setPage(int value) {
    if (value == page) return;
    page = value;
    _pageController. jumpToPage(value);
  }
}
