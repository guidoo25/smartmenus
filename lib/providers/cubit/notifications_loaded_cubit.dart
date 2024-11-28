import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notifications_loaded_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> fetchToken() async {
    emit(NotificationsLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('fcm_token') ?? 'default_token';
      String halfToken = token.substring(0, token.length ~/ 2);

      String loginUrl =
          'https://www.myschool.cl/ams_indexApp.php?uuid=${halfToken}&ID=$token';
      print('Login URL: $loginUrl');
      emit(NotificationsLoaded(loginUrl: loginUrl));
    } catch (e) {
      emit(NotificationsError(message: 'Error al obtener el token de FCM'));
    }
  }
}
