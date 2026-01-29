import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/repositories/category_repositories.dart';

import '../model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepositories _categoryRepositories;

  CategoryCubit({required CategoryRepositories categoriesRepositories})
    : _categoryRepositories = categoriesRepositories,
      super(CategoryInitial());


  void loadCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await _categoryRepositories.readCategory();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: 'Ошибка загрузки категорий'));
    }
  }

  // event - события
  void createCategory({required String name}) async {
    try {
      final category = Category(name: name);
      await _categoryRepositories.createCategory(category: category);
      loadCategories();
    } catch (e) {
      emit(CategoryError(message: 'Произошло ошибка добавление категории'));
    }
  }
}
