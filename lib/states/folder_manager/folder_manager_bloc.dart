import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/data/repositories/local_repository.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:stream_transform/stream_transform.dart';

part 'folder_manager_event.dart';
part 'folder_manager_state.dart';

class FolderManagerBloc extends Bloc<FolderManagerEvent, FolderManagerState> {
  final LocalDataRepository _localDataRepository;

  FolderManagerBloc(this._localDataRepository)
      : super(const FolderManagerState.initial()) {
    on<GetAllFolderStarted>(_onGetAllFolders,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<CreateFolderStarted>(_onCreateFolder,
        transformer: (events, mapper) => events.switchMap(mapper));

    on<DeleteFolderStarted>(_onDeleteFolder,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<UpdateFolderStarted>(_onUpdateFolder,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onGetAllFolders(
      GetAllFolderStarted event, Emitter<FolderManagerState> emit) async {
    try {
      emit(state.asLoading());

      List<Folder> folderList = await _localDataRepository.getAllFolder();

      emit(state.asLoadGetAllFolderSuccess(folderList));
    } on Exception catch (e) {
      emit(state.asLoadGetAllFolderFailure(e));
    }
  }

  void _onCreateFolder(
      CreateFolderStarted event, Emitter<FolderManagerState> emit) async {
    try {
      int folderId =
          await _localDataRepository.insertFolder(folder: event.folder);
      if (folderId >= 0) {
        event.folder.id = folderId;
        emit(state.asLoadCreateFolderSuccess(event.folder));
      }
      emit(state.asLoadGetAllFolderFailure(Exception()));
    } on Exception catch (e) {
      emit(state.asLoadGetAllFolderFailure(e));
    }
  }

  void _onDeleteFolder(
      DeleteFolderStarted event, Emitter<FolderManagerState> emit) async {
    try {
      await _localDataRepository.deleteFolder(folderId: event.folderId);
      emit(state.asLoadDeleteFolderSuccess(event.folderId));
    } on Exception {
      emit(state.copyWith(status: FolderManagerStateStatus.deleteFailure));
    }
  }

  void _onUpdateFolder(
      UpdateFolderStarted event, Emitter<FolderManagerState> emit) async {
    try {
      await _localDataRepository.updateFolder(folder: event.folder);
      emit(state.asLoadUpdateFolderSuccess(event.folder));
    } on Exception {
      emit(state.copyWith(status: FolderManagerStateStatus.updateFailure));
    }
  }
}
