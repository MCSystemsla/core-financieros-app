import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageDialog extends StatefulWidget {
  const UploadImageDialog({
    super.key,
    required this.onSelected,
  });
  final Function(XFile) onSelected;
  @override
  State<UploadImageDialog> createState() => _UploadImageDialogState();
}

class _UploadImageDialogState extends State<UploadImageDialog> {
  final ImagePicker picker = ImagePicker();
  static const uploadImagesKeyText = 'upload_image';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(translate('$uploadImagesKeyText.title'),
          style: Theme.of(context).textTheme.titleMedium!),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              onTap: () {
                picker
                    .pickImage(source: ImageSource.gallery)
                    .then((XFile? image) {
                  if (image != null) {
                    widget.onSelected(image);
                  }
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                });
              },
              title: Text(translate('$uploadImagesKeyText.gallery'),
                  style: Theme.of(context).textTheme.bodyMedium!),
              leading: Icon(
                Icons.photo_library,
                color: AppColors.getPrimaryColor(),
                size: 30,
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            ListTile(
              onTap: () {
                picker
                    .pickImage(source: ImageSource.camera)
                    .then((XFile? photo) {
                  if (photo != null) {
                    widget.onSelected(photo);
                  }
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                });
              },
              title: Text(translate('$uploadImagesKeyText.camera'),
                  style: Theme.of(context).textTheme.bodyMedium!),
              leading: Icon(
                Icons.photo_camera,
                color: context.primaryColor(),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
