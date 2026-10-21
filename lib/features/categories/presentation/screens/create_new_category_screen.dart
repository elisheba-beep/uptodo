import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_icon_modal.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_modal.dart';

class CreateNewCategoryScreen extends StatefulWidget {
  const CreateNewCategoryScreen({super.key, this.icon});

  final String? icon;

  @override
  State<CreateNewCategoryScreen> createState() =>
      _CreateNewCategoryScreenState();
}

class _CreateNewCategoryScreenState extends State<CreateNewCategoryScreen> {
  late TextEditingController categoryController;

  int _selectedColorIndex = 0;

  List categoryColors = [
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
    super.dispose();
    categoryController.dispose();
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
              Text(
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
                validator: (String? value) {
                  return null;
                },
              ),
              20.heightBox,
              Text(
                'Category icon :',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
              16.heightBox,
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChooseCategoryIconModal(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.popUpBackgroundColor,
                  ),
                  child: widget.icon != null
                      ? SvgPicture.asset(widget.icon!)
                      : Text(
                          'Choose icon from library',
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.32,
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
              20.heightBox,
              Text(
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
                  itemBuilder: (context, index) {
                    final Color currentColor = categoryColors[index];
                    final bool isSelected = _selectedColorIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorIndex = index;
                        });
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: currentColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: isSelected ? AppColors.white : currentColor,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 12.widthBox;
                  },
                  itemCount: categoryColors.length,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UpToDoButton(
                    text: 'Cancel',
                    textColour: AppColors.purple,
                    backgroundColour: AppColors.backgroundColor,

                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => ChooseCategoryModal(),
                      );
                    },
                  ),

                  UpToDoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Create Category',
                    textColour: AppColors.white,
                    backgroundColour: AppColors.purple,
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
