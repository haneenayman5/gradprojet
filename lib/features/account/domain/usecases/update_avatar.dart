import 'dart:io';

import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';

class UploadAvatarUsecase {
  final ApiService apiService;

  UploadAvatarUsecase({required this.apiService});

  Future<void> call(String username, File imageFile) async {
    await apiService.uploadAvatar(username, imageFile);
  }
}