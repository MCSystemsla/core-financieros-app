import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';

abstract class OdsDialog<T> extends StatefulWidget {
  const OdsDialog({
    super.key,
    required String this.title,
    this.subtitle,
  }) : content = null;

  const OdsDialog.withContent({
    super.key,
    required Widget this.content,
  })  : title = null,
        subtitle = null;

  ///message to show as title, please avoid to pass routes for translate
  final String? title;

  final Widget? content;

  final String? subtitle;

  Widget? description(BuildContext context) => null;

  List<CustomElevatedButton>? actions(BuildContext context);

  @override
  State<OdsDialog> createState() => _OdsDialogState();

  Future<T?> showDialog(
    BuildContext context, {
    AnimType animType = AnimType.scale,
    DialogType dialogType = DialogType.warning,
    Widget? customHeader,
  }) async {
    final response = await AwesomeDialog(
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      context: context,
      animType: animType,
      dialogType: dialogType,
      body: this,
      customHeader: customHeader,
    ).show();
    if (response is T?) {
      return response;
    }
    return null;
  }
}

class _OdsDialogState extends State<OdsDialog> {
  @override
  Widget build(BuildContext context) {
    final description = widget.description(context);
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const SizedBox(height: 40),
        SizedBox(
          width: size.width * .58,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.content != null) widget.content!,
              if (widget.content == null) ...[
                if (widget.title != null)
                  Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                  ),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    textAlign: TextAlign.center,
                  ),
              ]
            ],
          ),
        ),
        const SizedBox(height: 40),
        if (description != null) ...[
          description,
          const SizedBox(height: 40),
        ],
        if (actions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: alignmentActions,
              children: List.generate(
                actions.length,
                (index) {
                  final needsRightSeparation = !(index == actions.length - 1);
                  final needsLeftSeparation = index != 0 && actions.length > 1;
                  final child = actions[index];
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: needsRightSeparation ? 10 : 0,
                        left: needsLeftSeparation ? 10 : 0,
                      ),
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<CustomElevatedButton> get actions {
    return widget.actions.call(context) ?? [];
  }

  MainAxisAlignment get alignmentActions {
    if (actions.isEmpty || actions.length == 1) {
      return MainAxisAlignment.center;
    }
    return MainAxisAlignment.spaceBetween;
  }
}
