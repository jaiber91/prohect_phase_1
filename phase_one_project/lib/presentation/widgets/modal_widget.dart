import 'package:flutter/material.dart';

import '../../utils/color_app.dart';

class ModalWidget {
  static Future<void> showConfirmation({
    required BuildContext context,
    String title = '',
    String content = '¿Deseas continuar con esta acción?',
    String cancelText = 'Cancelar',
    String confirmText = 'Aceptar',
    IconData icon = Icons.warning_amber_rounded,
    Color iconColor = AppColors.warning,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(icon, color: iconColor, size: 40),
        title: Text(title),
        content: Text(content),
        actions: [
          _buttonConfirmation(onConfirm, context, cancelText, confirmText),
        ],
      ),
    );
  }

  static Row _buttonConfirmation(VoidCallback onConfirm, BuildContext context,
      String cancelText, String confirmText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    String content = 'El elemento fue eliminado exitosamente.',
    String buttonText = 'Aceptar',
    IconData icon = Icons.check_circle_outline,
    Color iconColor = AppColors.success,
    required VoidCallback onClose,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(icon, color: iconColor, size: 40),
        content: Text(content),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClose();
                },
                child: Text(buttonText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
