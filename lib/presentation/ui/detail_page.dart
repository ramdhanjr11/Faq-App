import 'package:faq_app/common/routes.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
import 'package:faq_app/utils/detail_arguments.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final DetailArguments? detailArguments;

  const DetailPage({super.key, this.detailArguments});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with RouteAware {
  late DetailArguments detailArguments;
  late User user;
  late Faq faq;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppRoutes.routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
    if (widget.detailArguments != null) {
      detailArguments = widget.detailArguments!;
      user = detailArguments.user;
      faq = detailArguments.faq;
      context.read<FaqCubit>().getFaq(user.accessToken, faq.id);
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<FaqCubit>().getFaq(user.accessToken, faq.id);
  }

  @override
  Widget build(BuildContext context) {
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
              context.read<FaqCubit>().deleteFaq(user.accessToken, faq);
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<FaqCubit, FaqState>(
          listener: (context, state) {
            if (state is FaqDeleteSuccess) {
              Navigator.pop(context);
            }

            if (state is FaqDeleteError) {
              showSnackbar(state.message, context);
            }
          },
          builder: (context, state) {
            if (state is FaqLoading) {
              return const LinearProgressIndicator();
            }

            if (state is FaqError) {
              return showSnackbar(state.message, context);
            }

            if (state is FaqSuccess) {
              faq = state.faq;
              return _buildDetailContent(context);
            }

            if (state is FaqDeleteLoading) {
              return const LinearProgressIndicator();
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.formFaqRouteName,
            arguments: FormFaq(
              isEditable: true,
              faqId: faq.id,
              question: faq.question,
              answer: faq.answer,
              publishStatus: faq.publishStatus == 0 ? false : true,
            ),
          );
        },
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

  Padding _buildDetailContent(BuildContext context) {
    return Padding(
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
          const SizedBox(height: 64),
          Chip(
            backgroundColor:
                faq.publishStatus == 1 ? Colors.green[100] : Colors.orange[100],
            label: Row(
              children: [
                Icon(faq.publishStatus == 1 ? Icons.check : Icons.close),
                const SizedBox(width: 6),
                Text(faq.publishStatus == 1 ? 'Published' : 'Not published'),
              ],
            ),
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
        ],
      ),
    );
  }
}
