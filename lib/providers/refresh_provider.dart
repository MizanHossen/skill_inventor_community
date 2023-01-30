import 'package:flutter/material.dart';

class RefreshNotifier extends ChangeNotifier {
  Future<void> refresh() async {
    notifyListeners();
  }
}
