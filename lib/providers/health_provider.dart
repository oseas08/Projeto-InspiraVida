import 'package:flutter/material.dart';
import '../models/health_item.dart';

class HealthProvider extends ChangeNotifier {
  final List<HealthItem> _items = [];

  List<HealthItem> get items => [..._items];

  int get totalItems => _items.length;

  int get exerciseCount => _items.where((item) => item.type == 'exercise').length;

  int get foodCount => _items.where((item) => item.type == 'food').length;

  void addItem(HealthItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}