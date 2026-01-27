part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategoryLoading extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CategorySuccess extends CategoryState{
  final List<Category> categories;

  const CategorySuccess({required this.categories});
  @override
  // TODO: implement props
  List<Object?> get props => [
    categories
  ];

}

final class CategoryError extends CategoryState{
  final String message;

  const CategoryError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
