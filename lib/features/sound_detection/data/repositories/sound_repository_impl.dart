// import '../../domain/entities/sound_event.dart';
import '../../domain/repositories/sound_repository.dart';
import '../data_sources/sound_local_datasource.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundLocalDataSource localDataSource;
  SoundRepositoryImpl(this.localDataSource);

  @override
  Stream<double> getDecibelStream() {
    return localDataSource.decibelStream();
  }

  // @override
  // Stream<SoundEvent> detectSoundEvents() {
  //   return localDataSource.soundEventStream();
  // }
}
