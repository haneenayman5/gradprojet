abstract class SoundRepository {
  Stream<double> getDecibelStream(); // for dB gauge
  //Stream<SoundEvent> detectSoundEvents(); // identifies sound types
}
