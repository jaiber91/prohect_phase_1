import 'package:flutter/material.dart';

class ModalWidget {
  static Future<void> showConfirmation({
    required BuildContext context,
    String title = '¿Estás seguro?',
    String content = '¿Deseas continuar con esta acción?',
    String cancelText = 'Cancelar',
    String confirmText = 'Aceptar',
    IconData icon = Icons.warning_amber_rounded,
    Color iconColor = Colors.orange,
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
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(cancelText),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    String content = 'El elemento fue eliminado exitosamente.',
    String buttonText = 'Aceptar',
    IconData icon = Icons.check_circle_outline,
    Color iconColor = Colors.green,
    required VoidCallback onClose,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(icon, color: iconColor, size: 40),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClose();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
