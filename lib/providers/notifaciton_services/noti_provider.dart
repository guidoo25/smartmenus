import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationUrlCubit extends Cubit<String?> {
  NotificationUrlCubit() : super(null);

  void setUrl(String url) => emit(url);

  void clearUrl() => emit(null);
}
