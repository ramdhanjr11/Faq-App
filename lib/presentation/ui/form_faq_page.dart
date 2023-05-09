import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormFaqPage extends StatefulWidget {
  const FormFaqPage({super.key});

  @override
  State<FormFaqPage> createState() => FormFaqPageState();
}

class FormFaqPageState extends State<FormFaqPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  late FormFaq _formFaq;

  _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    _formFaq = ModalRoute.of(context)!.settings.arguments as FormFaq;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Faq',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: BlocListener<FaqCubit, FaqState>(
        listener: (context, state) => _listenerState(state),
        child: SingleChildScrollView(
          child: Visibility(
            visible: !_isLoading,
            replacement: const LinearProgressIndicator(),
            child: FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pertanyaan',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: "pertanyaan",
                      initialValue:
                          _formFaq.isEditable ? _formFaq.question : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Silahkan isi pertanyaan anda..',
                        prefixIcon: Icon(Icons.question_mark_outlined),
                        prefixIconColor: Colors.grey,
                      ),
                      minLines: 4,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.bodySmall,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Jawaban',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: "jawaban",
                      initialValue:
                          _formFaq.isEditable ? _formFaq.answer : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Silahkan isi jawaban dari pertanyaan anda',
                        prefixIcon: Icon(Icons.question_answer_outlined),
                        prefixIconColor: Colors.grey,
                      ),
                      minLines: 4,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.bodySmall,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Status publish',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    FormBuilderChoiceChip(
                      name: 'status_publish',
                      initialValue:
                          _formFaq.isEditable ? _formFaq.publishStatus : false,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      options: const [
                        FormBuilderChipOption(
                          value: true,
                          avatar: CircleAvatar(
                            child: Icon(
                              Icons.check,
                              size: 10,
                            ),
                          ),
                        ),
                        FormBuilderChipOption(
                          value: false,
                          avatar: CircleAvatar(
                            child: Icon(
                              Icons.close,
                              size: 10,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            if (_formFaq.isEditable) {
              _processFaqForm(true);
            } else {
              _processFaqForm(false);
            }
          }
        },
        label: Row(
          children: [
            _formFaq.isEditable
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
            const SizedBox(width: 6),
            _formFaq.isEditable
                ? const Text('Save FAQ')
                : const Text('Add FAQ'),
          ],
        ),
      ),
    );
  }

  _processFaqForm(bool isEditable) {
    final userToken = context.read<AuthCubit>().user!.accessToken;
    final formValues = _formKey.currentState!.value;
    final createFormFaq = FormFaq(
      isEditable: false,
      question: formValues['pertanyaan'],
      answer: formValues['jawaban'],
      publishStatus: formValues['status_publish'],
    );

    if (isEditable) {
      context
          .read<FaqCubit>()
          .updateFaq(userToken, createFormFaq, _formFaq.faqId!);
    } else {
      context.read<FaqCubit>().createFaq(userToken, createFormFaq);
    }
  }

  _listenerState(FaqState state) {
    if (state is FaqCreateLoading) {
      _setLoadingState(true);
    }

    if (state is FaqCreateError) {
      _setLoadingState(false);
      showSnackbar(state.message, context);
    }

    if (state is FaqCreateSuccess) {
      _setLoadingState(false);
      showSnackbar(state.message, context);
      Navigator.pop(context);
    }

    if (state is FaqUpdateLoading) {
      _setLoadingState(true);
    }

    if (state is FaqUpdateError) {
      _setLoadingState(false);
      showSnackbar(state.message, context);
    }

    if (state is FaqUpdateSuccess) {
      _setLoadingState(false);
      showSnackbar(state.message, context);
      Navigator.pop(context);
    }
  }
}
