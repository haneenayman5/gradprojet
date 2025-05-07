import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_category_state.dart';

class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit() : super(CategoriesIndex1());

  void selectCategory(int index) {
    switch (index) {
      case 1:
        emit(CategoriesIndex1());
        break;
      case 2:
        emit(CategoriesIndex2());
        break;
      case 3:
        emit(CategoriesIndex3());
        break;
      case 4:
        emit(CategoriesIndex4());
        break;
      case 5:
        emit(CategoriesIndex5());
        break;
        case 6:
      emit(CategoriesIndex6());
      break;
      default:
        emit(CategoriesIndex1());
    }
  }
}

