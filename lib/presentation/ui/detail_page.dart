import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = false;

  _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final faq = ModalRoute.of(context)!.settings.arguments as Faq;
    final user = context.read<AuthCubit>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail FAQ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<FaqCubit>().deleteFaq(user!.accessToken, faq);
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocListener<FaqCubit, FaqState>(
          listener: (context, state) {
            if (state is FaqDeleteLoading) {
              _setLoadingState(true);
            }

            if (state is FaqDeleteError) {
              _setLoadingState(false);
              showSnackbar(state.message, context);
            }

            if (state is FaqDeleteSuccess) {
              _setLoadingState(false);
              Navigator.pop(context);
            }
          },
          child: _isLoading
              ? const Center(
                  child: LinearProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.question_mark_outlined,
                            size: 17,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Pertanyaan',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        faq.question,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Created at',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            faq.createdAt,
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.update_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Update at',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            faq.updatedAt,
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Icon(
                            Icons.question_answer_outlined,
                            size: 17,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Jawaban',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        faq.answer,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: const [
            Icon(Icons.edit),
            SizedBox(width: 6),
            Text('Edit FAQ'),
          ],
        ),
      ),
    );
  }
}
