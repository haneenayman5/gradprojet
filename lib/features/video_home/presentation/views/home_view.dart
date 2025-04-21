import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/video_home/presentation/manager/select_category_cubit/select_category_cubit.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/custom_drawer.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/homView_body.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectCategoryCubit(),
      child:  Scaffold(
        endDrawer: const Drawer(
          backgroundColor: Colors.blue,
          child: CustomDrawer(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimarycolor,
          onPressed: (){
            GoRouter.of(context).push(AppRoute.kSearchPath);
          },
          child: const Icon(Icons.add_comment_rounded,color: Colors.white,),),
        body: const HomeviewBody(),
      ),
    );
  }
}
