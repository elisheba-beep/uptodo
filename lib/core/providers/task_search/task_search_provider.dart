import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_search_provider.g.dart';

@riverpod
class TaskSearch extends _$TaskSearch {
  @override
  String build() {
   return '' ;
  }

  void setSearchTerm(String searchTerm){
    state = searchTerm;
  }
}