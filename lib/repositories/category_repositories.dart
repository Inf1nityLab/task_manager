

// C R U D
//String, int, double, bool
//List<>

import 'package:isar/isar.dart';
import 'package:task_manager/model/category.dart';

abstract class CategoryRepositories {
  Future<void> createCategory({required Category category});
  Future<List<Category>> readCategory();
  Future<void> deleteCategory({required int id});
}



class CategoryRepositoriesImpl implements CategoryRepositories{
  final Isar _isar;

  CategoryRepositoriesImpl({required Isar isar}) : _isar = isar;
  Isar get isar => _isar;

  @override
  Future<void> createCategory({required Category category}) async{
    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
  }

  @override
  Future<void> deleteCategory({required int id}) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> readCategory() async{
    return await _isar.categorys.where().findAll();
  }

}