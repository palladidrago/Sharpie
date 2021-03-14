import 'package:simple_mashovapi/simple_mashovapi.dart';
import '../services/helpers.dart';

Controller sharedMashovController;
void logSharedMController([String semel = "540484"]) async {
  sharedMashovController = Controller();
  sharedMashovController.login(await getMashovUsername(),
      await getMashovPassword(), semel, getMashovYear());
}
