import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/usecases/get_faqs_usecase.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final GetFaqsUseCase _getFaqsUseCase;
  final List<Faq> _faqs = [];
  List<Faq> get faqs => _faqs;

  FaqCubit(this._getFaqsUseCase) : super(FaqInitial());

  void getFaqs(String tokenType, String token) async {
    emit(FaqsLoading());

    final result = await _getFaqsUseCase.execute(tokenType, token);

    result.fold((failure) {
      emit(FaqsError(message: failure.message));
    }, (faqsData) {
      if (_faqs.isNotEmpty) _faqs.clear();
      _faqs.addAll(faqsData);
      emit(FaqsSuccess(faqs: faqsData));
    });
  }
}
