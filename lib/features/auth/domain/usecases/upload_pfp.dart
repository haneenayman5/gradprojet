import 'dart:io';

import 'package:untitled3/features/auth/domain/repository/UserRepository.dart';

class UploadPfpUsecase {
  final UserRepository userRepository;

  UploadPfpUsecase({required this.userRepository});

  Future<void> call(File img, String username) async{
    await userRepository.uploadPfp(img, username);
  }
}