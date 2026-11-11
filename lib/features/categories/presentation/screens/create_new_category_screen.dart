import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';
import 'package:uptodo/features/categories/presentation/providers/categories_provider.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_icon_modal.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';

class CreateNewCategoryScreen extends ConsumerStatefulWidget {
  const CreateNewCategoryScreen({super.key});

  @override
  ConsumerState<CreateNewCategoryScreen> createState() =>
      _CreateNewCategoryScreenState();
}

class _CreateNewCategoryScreenState
    extends ConsumerState<CreateNewCategoryScreen> {
  late final TextEditingController categoryController;
  int _selectedColorIndex = 0;
  String? _iconPath;
  bool _saving = false;

  static const List<Color> categoryColors = [
    Color(0xffC9CC41),
    Color(0xff66CC41),
    Color(0xff41CCA7),
    Color(0xff4181CC),
    Color(0xff41A2CC),
    Color(0xffCC8441),
    Color(0xff9741CC),
    Color(0xffCC4173),
  ];

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_iconPath == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Please choose an icon')),
      );
      return;
    }

    setState(() => _saving = true);
    final name = categoryController.text.trim();
    final error = await ref
        .read(categoriesProvider.notifier)
        .add(
      name: name,
      iconPath: _iconPath!,
      color: categoryColors[_selectedColorIndex],
    );
    if (!mounted) return;

    if (error != null) {
      setState(() => _saving = false);
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }


    ref.read(taskDraftProvider.notifier).updateTag(name);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create new category',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              20.heightBox,
              UpToDoTextField(
                controller: categoryController,
                label: 'Category name :',
                hintText: 'Category name',
                validator: (String? value) => null,
              ),
              20.heightBox,
              const Text(
                'Category icon :',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
              16.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {
                    final path = await showDialog<String>(
                      context: context,
                      builder: (_) => const ChooseCategoryIconModal(),
                    );
                    if (path != null) setState(() => _iconPath = path);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.popUpBackgroundColor,
                    ),
                    child: _iconPath != null
                        ? SvgPicture.asset(_iconPath!)
                        : const Text(
                      'Choose icon from library',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: -0.32,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              20.heightBox,
              const Text(
                'Category color :',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
              16.heightBox,
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryColors.length,
                  separatorBuilder: (_, _) => 12.widthBox,
                  itemBuilder: (context, index) {
                    final color = categoryColors[index];
                    final isSelected = _selectedColorIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColorIndex = index),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: color,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: isSelected ? AppColors.white : color,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UpToDoButton(
                    text: 'Cancel',
                    textColour: AppColors.purple,
                    backgroundColour: AppColors.backgroundColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                  UpToDoButton(
                    text: _saving ? 'Saving...' : 'Create Category',
                    textColour: AppColors.white,
                    backgroundColour: AppColors.purple,
                    onPressed: _saving ? null : _create,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}