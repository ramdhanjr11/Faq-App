import 'package:faq_app/common/routes.dart';
import 'package:faq_app/domain/entities/faq.dart';
import 'package:faq_app/domain/entities/form_faq.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:faq_app/presentation/cubits/faq_cubit/faq_cubit.dart';
import 'package:faq_app/utils/show_snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  late User user;
  late List<Faq> faqs;
  bool _isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppRoutes.routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
    user = context.read<AuthCubit>().user!;
    context.read<FaqCubit>().getFaqs(user.accessToken, 1);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<FaqCubit>().getFaqs(user.accessToken, 1);
  }

  _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout(user.accessToken);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutLoading) {
            _setLoadingState(true);
          }

          if (state is LogoutError) {
            _setLoadingState(false);
            showSnackbar(state.message, context);
          }

          if (state is LogoutSuccess) {
            _setLoadingState(false);
            showSnackbar(state.message, context);
            Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
          }
        },
        builder: (context, state) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return BlocBuilder<FaqCubit, FaqState>(
            builder: (context, state) {
              if (state is FaqsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is FaqsError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is FaqsSuccess) {
                faqs = state.faqs;
                return _buildFaqsList();
              }

              return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.formFaqRouteName,
            arguments: const FormFaq(isEditable: false),
          );
        },
        label: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(width: 6),
            Text('Add Question'),
          ],
        ),
      ),
    );
  }

  Padding _buildFaqsList() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _userInfoWidget();
          }
          final faq = faqs[index - 1];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: const Text('Pertanyaan'),
              subtitle: Text(faq.question),
              leading: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.question_mark_outlined),
              ),
              contentPadding: const EdgeInsets.all(8),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailRouteName,
                  arguments: faq,
                );
              },
            ),
          );
        },
        itemCount: faqs.length + 1,
      ),
    );
  }

  Padding _userInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.pathPhoto),
              ),
              const SizedBox(width: 12),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Welcome, ',
                    ),
                    TextSpan(
                      text: user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
