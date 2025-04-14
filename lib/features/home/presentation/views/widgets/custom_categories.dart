import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/home/presentation/manager/select_category_cubit/select_category_cubit.dart';
import 'package:untitled3/features/home/presentation/views/widgets/custom_category.dart';

class CustomCategories extends StatelessWidget {
  const CustomCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocBuilder<SelectCategoryCubit, SelectCategoryState>(
        builder: (context, state) {
          return SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CustomCategory(
                  title: 'Coversations',
                  width: 120,
                  backgroundColor:
                      state is CategoriesIndex1 ? kContainerColor : kPrimarycolor,
                  textColor:
                      state is CategoriesIndex1 ? Colors.white : Colors.grey,
                  onTap: () {
                    BlocProvider.of<SelectCategoryCubit>(context).getCategories(
                        index1Selected: true,
                        index2Selected: false,
                        index4Selected: false,
                        index3Selected: false);
                  },
                ),

                CustomCategory(
                  width: 90,
                  title: 'Unread ',
                  textColor:
                      state is CategoriesIndex2 ? Colors.white : Colors.grey,
                  backgroundColor:
                      state is CategoriesIndex2 ? kContainerColor : kPrimarycolor,
                  onTap: () {
                    BlocProvider.of<SelectCategoryCubit>(context).getCategories(
                        index1Selected: false,
                        index2Selected: true,
                        index4Selected: false,
                        index3Selected: false);
                  },
                ),

                CustomCategory(
                    width: 70,
                    title: 'Calls',
                    textColor:
                        state is CategoriesIndex3 ? Colors.white : Colors.grey,
                    backgroundColor: state is CategoriesIndex3
                        ? kContainerColor
                        : kPrimarycolor,
                    onTap: () {
                      BlocProvider.of<SelectCategoryCubit>(context).getCategories(
                          index1Selected: false,
                          index2Selected: false,
                          index4Selected: false,
                          index3Selected: true);
                    }),

                CustomCategory(
                    width: 100,
                    title: 'Learning',
                    textColor:
                        state is CategoriesIndex4 ? Colors.white : Colors.grey,
                    backgroundColor: state is CategoriesIndex4
                        ? kContainerColor
                        : kPrimarycolor,
                    onTap: () {
                      BlocProvider.of<SelectCategoryCubit>(context).getCategories(
                          index1Selected: false,
                          index2Selected: false,
                          index3Selected: false,
                          index4Selected: true);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
