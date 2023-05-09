part of 'faq_cubit.dart';

abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqsLoading extends FaqState {}

class FaqsSuccess extends FaqState {
  final List<Faq> faqs;

  const FaqsSuccess({required this.faqs});
}

class FaqsError extends FaqState {
  final String message;

  const FaqsError({required this.message});
}

class FaqDeleteLoading extends FaqState {}

class FaqDeleteSuccess extends FaqState {
  final String message;

  const FaqDeleteSuccess({required this.message});
}

class FaqDeleteError extends FaqState {
  final String message;

  const FaqDeleteError({required this.message});
}

class FaqCreateLoading extends FaqState {}

class FaqCreateSuccess extends FaqState {
  final String message;

  const FaqCreateSuccess({required this.message});
}

class FaqCreateError extends FaqState {
  final String message;

  const FaqCreateError({required this.message});
}

class FaqUpdateLoading extends FaqState {}

class FaqUpdateSuccess extends FaqState {
  final String message;

  const FaqUpdateSuccess({required this.message});
}

class FaqUpdateError extends FaqState {
  final String message;

  const FaqUpdateError({required this.message});
}
