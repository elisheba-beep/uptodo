import 'dart:convert';
import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/features/categories/data/category_list.dart';
import 'package:uptodo/features/categories/presentation/models/choose_category.dart';

part 'categories_provider.g.dart';

const _prefsKey = 'custom_categories';

@Riverpod(keepAlive: true)
class Categories extends _$Categories {
  final _custom = <ChooseCategory>[];

  @override
  List<ChooseCategory> build() {
    _load();
    return List.of(categories);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;
    try {
      for (final m in jsonDecode(raw) as List) {
        final c = ChooseCategory(
          m['name'] as String,
          m['icon'] as String,
          Color(m['color'] as int),
        );
        if (getCategoryByName(c.categoryName) == null) {
          categories.insert(categories.length - 1, c);
        }
        _custom.add(c);
      }
      state = List.of(categories);
    } catch (_) {
      await prefs.remove(_prefsKey);
    }
  }

  Future<String?> add({
    required String name,
    required String iconPath,
    required Color color,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Please enter a category name';
    if (trimmed.length > 16) return 'Name must be 16 characters or fewer';
    if (getCategoryByName(trimmed) != null) {
      return 'A category with that name already exists';
    }

    final c = ChooseCategory(trimmed, iconPath, color);
    categories.insert(categories.length - 1, c);
    _custom.add(c);
    state = List.of(categories);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode([
        for (final c in _custom)
          {
            'name': c.categoryName,
            'icon': c.categoryPath,
            'color': c.categoryColor.toARGB32(),
          },
      ]),
    );
    return null;
  }
}