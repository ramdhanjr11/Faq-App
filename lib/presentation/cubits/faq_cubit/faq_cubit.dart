import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/usecases/delete_faq_usecase.dart';
import 'package:faq_app/domain/usecases/get_faqs_usecase.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final GetFaqsUseCase _getFaqsUseCase;
  final DeleteFaqUseCase _deleteFaqUseCase;
  final List<Faq> _faqs = [];
  List<Faq> get faqs => _faqs;

  FaqCubit(this._getFaqsUseCase, this._deleteFaqUseCase) : super(FaqInitial());

  void getFaqs(String token, int page) async {
    emit(FaqsLoading());

    final result = await _getFaqsUseCase.execute(token, page);

    result.fold((failure) {
      emit(FaqsError(message: failure.message));
    }, (faqsData) {
      if (_faqs.isNotEmpty) _faqs.clear();
      _faqs.addAll(faqsData);
      emit(FaqsSuccess(faqs: faqsData));
    });
  }

  void deleteFaq(String token, Faq faq) async {
    emit(FaqDeleteLoading());

    final result = await _deleteFaqUseCase.execute(token, faq);

    result.fold((failure) {
      emit(FaqDeleteError(message: failure.message));
    }, (successMessage) {
      emit(FaqDeleteSuccess(message: successMessage));
    });
  }
}
