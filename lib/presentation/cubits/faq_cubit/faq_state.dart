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
