import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SearchUser_UseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Entity/User/user_entity.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUserUseCase searchUserUseCase;
  SearchCubit(this.searchUserUseCase) : super(SearchInitial());
  Future<void> Getsearch(String name) async {
    try {
      emit(Searchloading());
      final search = await searchUserUseCase.SearchUser(name);
      search.listen((event) {
        emit(Searchloaded(entity: event));
      });
    } catch (e) {
      emit(Searchfailed());
    }
  }
}
