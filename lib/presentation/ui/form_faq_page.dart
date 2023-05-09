import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormFaqPage extends StatefulWidget {
  const FormFaqPage({super.key});

  @override
  State<FormFaqPage> createState() => FormFaqPageState();
}

class FormFaqPageState extends State<FormFaqPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final formFaq = ModalRoute.of(context)!.settings.arguments as FormFaq;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Faq',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  initialValue: formFaq.isEditable ? formFaq.question : null,
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
                  initialValue: formFaq.isEditable ? formFaq.answer : null,
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            formFaq.isEditable ? const Icon(Icons.edit) : const Icon(Icons.add),
            const SizedBox(width: 6),
            formFaq.isEditable ? const Text('Save FAQ') : const Text('Add FAQ'),
          ],
        ),
      ),
    );
  }
}
