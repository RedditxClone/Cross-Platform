import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/email_settings_repo.dart';

part 'email_settings_event.dart';
part 'email_settings_state.dart';

class EmailSettingsBloc extends Bloc<EmailSettingsEvent, EmailSettingsState> {
  late EmailSettingsReposity emailSettingsReposity;
  List<bool> _settingsValues = [];
  EmailSettingsBloc(@required this.emailSettingsReposity)
      : super(EmailSettingsInitial()) {
    on<EmailSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  List<bool> getEmailSettings(userId) {
    emailSettingsReposity.getEmailSettings(userId).then(
      (value) {
        _settingsValues = value.values.toList();
      },
    );
    return _settingsValues;
  }
}
