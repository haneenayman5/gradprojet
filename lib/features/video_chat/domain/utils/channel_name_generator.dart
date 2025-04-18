class ChannelNameGenerator {

  static String makeChannelName(String u1, String u2)
  {
    final pair = [u1, u2]..sort();
    return '${pair[0]}_${pair[1]}';
  }
}