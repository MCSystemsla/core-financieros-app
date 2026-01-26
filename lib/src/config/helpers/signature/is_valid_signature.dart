import 'package:signature/signature.dart';

bool isValidSignature(SignatureController controller) {
  return controller.points.length >= 50;
}
