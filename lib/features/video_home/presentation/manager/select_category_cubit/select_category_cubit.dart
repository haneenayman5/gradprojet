import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_category_state.dart';

class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit() : super(CategoriesIndex1());

  void getCategories({
    required bool index1Selected,
    required bool index2Selected,
    required bool index3Selected,
    required bool index4Selected,
  }) {
    
    if (index1Selected == true) {
       index1Selected = !index1Selected;
      index2Selected = false;
      index3Selected = false;
       index4Selected = false;
      
      emit(CategoriesIndex1());
    } else if (index2Selected == true) {
       index2Selected = !index2Selected;
      index1Selected = false;
      index3Selected = false;
       index4Selected = false;
      emit(CategoriesIndex2());
    } else if (index3Selected == true) {
       index3Selected = !index3Selected;
      index1Selected = false;
      index2Selected = false;
       index4Selected = false;
      emit(CategoriesIndex3());
    }
    else if (index4Selected == true) {
       index4Selected = !index4Selected;
      index1Selected = false;
      index2Selected = false;
       index3Selected = false;
      emit(CategoriesIndex4());
    }
  }
}
