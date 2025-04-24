import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/search/presentation/manager/searchusers/searchusers_cubit.dart';
import 'package:untitled3/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetConversationsUsecase.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetSenderIdUsecase.dart';
import 'package:untitled3/injection_container.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchusersCubit(
          sl<GetConversationUsecase>(), sl<GetSenderIdUseCase>()),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SearchViewBody(),
      ),
    );
  }
}
