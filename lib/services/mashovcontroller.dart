//TODO: Make appwide shared mashov controller, already logged in.
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:sharpie/services/helpers.dart';
Controller sharedMashovController;
void logSharedMController([String semel="540484"]) async{
  sharedMashovController = Controller();
  sharedMashovController.login(await getMashovUsername(),await getMashovPassword(), semel, getMashovYear());
}