# Lista de cards

App para listar gatos. La data inicial se carga desde un json, pero se puede agregar, editar o eliminar.

## Tecnologías y/o paquetes del proyecto
-  Flutter version 3.27.4
-  Flutter_riverpod: ^2.6.1
-  Shared_preferences: ^2.5.3
-  uuid: ^4.5.1

## Estructura de carpetas
La siguientes estructura se hace pensando en que la app no va a crecer demasiado y la persistencia de los datos dependen del local storage del dispositivo.

.
└── lib/
    ├── assets/
    │   └── data/
    │       └── data_project.json
    ├── models/
    │   └── data_project_model.dart
    ├── presentation/
    │   ├── providers/
    │   │   └── card_notifier_provider.dart
    │   ├── routes/
    │   │   ├── app_routes.dart
    │   │   └── path_routes.dart
    │   ├── screens/
    │   │   ├── detail_screen.dart
    │   │   ├── form_screen.dart
    │   │   └── home_screen.dart
    │   ├── templates/
    │   │   └── base_template.dart
    │   └── widgets/
    │       ├── appbar_widget.dart
    │       ├── bottom_nav_widget.dart
    │       ├── card_widget.dart
    │       ├── dropdown_widget.dart
    │       ├── modal_widget.dart
    │       └── text_field_widget.dart
    ├── services/
    │   └── card_storage_service.dart
    ├── utils/
    │   ├── color_app.dart
    │   └── form_validators
    └── main.dart


## Paso para ejecutar el proyecto

- Clonar el repositorio
- Abrir el proyecto desde el editor de código
- Abrir la terminal y ubicarse en la raiz del proyecto
- Ejecutar el **flutter pub get** en el pubspec.yaml con el siguiente comando:

```shell
    flutter pub get
```

- Seleccionar el emulador de preferencia.
- ejecutar el siguiente comando


```shell
    flutter run
```

