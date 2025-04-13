class FormValidators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
  }

  static String? noSpecialChars(String? value) {
    final regex = RegExp(r"^[a-zA-Z0-9\sáéíóúÁÉÍÓÚñÑ.,¡!¿?']+$");
    if (value != null && !regex.hasMatch(value.trim())) {
      return 'No se puede usar caracteres especiales';
    }
    return null;
  }

  static String? minLengthValidator(String? value, int minLength,
      {String fieldName = 'Este campo'}) {
    if (value == null || value.length < minLength) {
      return '$fieldName debe tener mínimo $minLength caracteres';
    }
    return null;
  }

  static String? combined({
    required String? value,
    required String fieldName,
    int minLength = 3,
  }) {
    return required(value) ??
        minLengthValidator(value, minLength, fieldName: fieldName) ??
        noSpecialChars(value);
  }
}
