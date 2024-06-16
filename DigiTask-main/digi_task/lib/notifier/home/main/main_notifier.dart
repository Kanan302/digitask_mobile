import 'package:digi_task/core/constants/app_keys.dart';
import 'package:digi_task/data/model/response/user_task_model.dart';
import 'package:digi_task/data/repository/home_repository.dart';
import 'package:digi_task/data/services/local/shared_service.dart';
import 'package:digi_task/injection.dart';
import 'package:digi_task/notifier/home/main/main_state.dart';
import 'package:flutter/foundation.dart';

class MainNotifier extends ChangeNotifier {
  MainNotifier(this.homeRepository);
  MainState homeState = MainInitial();
  final IHomeRepository homeRepository;
  final preference = getIt.get<SharedPreferenceService>();
  bool isAdmin = false;
  UserTaskModel? userTaskModel;

  Future<void> fetchUserTask() async {
    homeState = MainLoading();
    notifyListeners();
    final result = await homeRepository.fetchUserTaskData();

    if (result.isSuccess()) {
      userTaskModel = result.tryGetSuccess();
      homeState = MainSuccess(taskDetails: userTaskModel?.taskDetails);
      notifyListeners();
    } else if (result.isError()) {
      homeState = MainError();
      notifyListeners();
    } else {
      homeState = MainError();
      notifyListeners();
    }
  }

  void checkAdmin() {
    isAdmin = preference.readBool(AppKeys.isAdmin) ?? false;
    print(isAdmin);
    notifyListeners();
  }
}
