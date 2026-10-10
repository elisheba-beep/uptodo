import 'dart:ui';

import 'package:uptodo/features/categories/presentation/models/choose_category.dart';

List<ChooseCategory> categories = [
  ChooseCategory('Grocery', 'assets/icons/grocery.svg', Color(0xffCCFF80)),
  ChooseCategory('Work', 'assets/icons/briefcase.svg', Color(0xffFF9680)),
  ChooseCategory('Sport', 'assets/icons/sport.svg', Color(0xff80FFFF)),
  ChooseCategory('Design', 'assets/icons/design.svg', Color(0xff80FFD9)),
  ChooseCategory(
    'University',
    'assets/icons/university.svg',
    Color(0xff809CFF),
  ),
  ChooseCategory('Social', 'assets/icons/social.svg', Color(0xffFF80EB)),
  ChooseCategory('Music', 'assets/icons/music.svg', Color(0xffFC80FF)),
  ChooseCategory('Health', 'assets/icons/health.svg', Color(0xff80FFA3)),
  ChooseCategory('Movie', 'assets/icons/movie.svg', Color(0xff80D1FF)),
  ChooseCategory('Home', 'assets/icons/category_home.svg', Color(0xffFFCC80)),
  ChooseCategory('Create New', 'assets/icons/add.svg', Color(0xff80FFD1)),
];

ChooseCategory? getCategoryByName(String? name) {
  if (name == null || name.isEmpty) return null;
  try {
    return categories.firstWhere(
      (c) => c.categoryName.toLowerCase() == name.toLowerCase(),
    );
  } catch (_) {
    return null;
  }
}
