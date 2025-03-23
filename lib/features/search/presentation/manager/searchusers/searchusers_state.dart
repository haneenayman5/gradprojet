part of 'searchusers_cubit.dart';


List<String> namesUser = [
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
   'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
  ];

@immutable
abstract class SearchusersState {}

class SearchusersInitial extends SearchusersState {
  final List<String> names;

  SearchusersInitial({required this.names});
}
class SearchusersFilter extends SearchusersState {
  final List<String> filterNames;

  SearchusersFilter({required this.filterNames});
}
class SearchusersFailure extends SearchusersState {
  
  
}
class SearchusersLoading extends SearchusersState {
  
  
}


