import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_bloc.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/drawer_appBar.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/drawer_listile_item.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';
import 'package:untitled3/features/auth/data/repository/user_repository_impl.dart';
import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';
import 'package:untitled3/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:untitled3/features/auth/domain/usecases/get_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:get_it/get_it.dart';

// Keep all your imports unchanged

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserEntity? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final storage = const FlutterSecureStorage();
    final username = await storage.read(key: 'username');
    if (username == null) return;

    final dio = Dio();
    final apiService = ApiService(dio);
    final userUseCase = GetUserUseCase(UserRepositoryImpl(apiService));

    final result = await userUseCase.call(params: username);

    if (!mounted) return;
    if (result is DataSuccess<UserEntity>) {
      setState(() {
        user = result.data;
      });
    } else if (result is DataFailed) {
      print("Failed to load user: ${result.exception?.message ?? 'Unknown error'}");
    }
  }

  String getDisplayName() {
    if (user == null) return 'User';
    final first = user!.firstName?.trim() ?? '';
    final last = user!.lastName?.trim() ?? '';
    final fullName = '$first $last'.trim();
    return fullName.isNotEmpty ? fullName : 'User';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerAppbar(
              name: getDisplayName(),
              email: user?.email ?? '',
              imageUrl: user?.imageUrl ?? '',
            ),
            const SizedBox(height: 10),
            _buildGestureTile(
              icon: const Icon(FontAwesomeIcons.key, color: Colors.white, size: 22),
              title: 'Account',
              onTap: () => GoRouter.of(context).push(AppRoute.accountPath, extra: {
                'prevPath': AppRoute.chatHomePath,
              }),
            ),
            const DrawerListileItem(
              icon: Icon(Icons.forum_rounded, color: Colors.white, size: 25),
              title: 'Chats',
            ),
            const DrawerListileItem(
              icon: Icon(Icons.notifications_active_rounded, color: Colors.white, size: 25),
              title: 'Notifications',
            ),
            const DrawerListileItem(
              icon: Icon(FontAwesomeIcons.database, color: Colors.white, size: 22),
              title: 'Data and Storage',
            ),
            _buildGestureTile(
              icon: const Icon(FontAwesomeIcons.solidCircleQuestion, color: Colors.white, size: 22),
              title: 'Help',
              onTap: () => GoRouter.of(context).push(AppRoute.helpPath),
            ),
            _buildGestureTile(
              icon: const Icon(FontAwesomeIcons.image, color: Colors.white, size: 22),
              title: 'Upload picture',
              onTap: _handleAvatarUpload,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 5, right: 30),
              child: Divider(color: kPrimarycolor, thickness: 2),
            ),
            const DrawerListileItem(
              icon: Icon(Icons.people_outline_rounded, color: Colors.white, size: 25),
              title: 'Invite a friend',
            ),
            const SizedBox(height: 20),
            _buildGestureTile(
              icon: const RotatedBox(
                quarterTurns: 2,
                child: Icon(Icons.exit_to_app_rounded, color: Colors.white, size: 25),
              ),
              title: 'Log Out',
              onTap: () async {
                final storage = const FlutterSecureStorage();
                await storage.deleteAll();
                GoRouter.of(context).go(AppRoute.welcomePath);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleAvatarUpload() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final File imageFile = File(picked.path);
      final bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Confirm Avatar"),
          content: Image.file(imageFile, width: 200, height: 200, fit: BoxFit.cover),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("Cancel")),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Confirm")),
          ],
        ),
      );

      if (confirmed == true) {
        final apiService = GetIt.instance<ApiService>();
        await apiService.uploadAvatar(user?.username ?? "", imageFile);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Avatar uploaded!")));
        GoRouter.of(context).push(AppRoute.chatHomePath);
      }
    }
  }

  Widget _buildGestureTile({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DrawerListileItem(icon: icon, title: title),
    );
  }
}












