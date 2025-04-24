part of 'searchusers_cubit.dart';

// List<String> namesUser = [
//   'Shane Haq',
//   'Gualtiero Cea',
//   'Maria Zarco',
//   'Rosita Marcos',
//   'Shane Haq',
//   'Gualtiero Cea',
//   'Maria Zarco',
//   'Rosita Marcos',
//   'Shane Haq',
//   'Gualtiero Cea',
//   'Maria Zarco',
//   'Rosita Marcos',
// ];

@immutable
abstract class SearchusersState {}

class SearchusersInitial extends SearchusersState {
  // final List<ConversationEntity> names;

  // SearchusersInitial({required this.names});
}

class SearchusersFilter extends SearchusersState {
  final List<ConversationEntity> filterNames;
  final String senderId;
  // final String receiverId = 'receiverId'; // Assuming you have a receiverId

  SearchusersFilter(this.senderId, {required this.filterNames});
}

class SearchusersFailure extends SearchusersState {}

class SearchusersLoading extends SearchusersState {}
