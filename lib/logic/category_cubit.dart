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


  void loadCategories(){

  }
  // event - события
  void createCategory({required String name}) async{
    try{
      final category = Category(name: name);
      await _categoryRepositories.createCategory(category: category);
      loadCategories();
    } catch (e){
      emit(CategoryError(message: 'Произошло ошибка добавление категории'));
    }
  }
}
