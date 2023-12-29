## To-Do List App

This repository contains the source code for a To-Do List app built with Flutter. The app follows a
clean architecture pattern to ensure separation of concerns and maintainability.

### Features

- Create new tasks with a title, date, and time.
- Mark tasks as done or undone.
- Archive tasks to keep them out of the main task list.
- Delete tasks permanently.
- Switch between different views: All tasks, Done tasks, and Archived tasks.
- User-friendly interface with intuitive navigation.

### Architecture

The app utilizes the following architectural components:

- **Presentation Layer**: This layer handles the user interface and user interactions. It consists
  of the `home_layout.dart` file, which displays the task list and provides the user interface for
  adding, editing, and managing tasks. It also includes the `shared/components` directory, which
  contains reusable UI components used throughout the app.

- **Domain Layer**: This layer defines the core business logic and models. The `to_do_cubit.dart`
  file represents the app's core logic, including the state management using the `flutter_bloc`
  library.

- **Data Layer**: This layer manages data persistence and retrieval. The `database_helper.dart` file
  contains the database helper class responsible for creating and managing the SQLite database using
  the `sqflite` plugin.

### Installation

1. Make sure you have Flutter installed on your machine. If not, follow the
   official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. Clone this repository to your local machine using the following command:
   `````
   git clone https://github.com/your-username/to-do-list-app.git
   ```
3. Change into the cloned directory:
   ````
   cd to-do-list-app
   ````
4. Run the app on a connected device or emulator:
   ````
   flutter run
   ````

### Dependencies

The app relies on the following dependencies:

- `flutter_bloc` - State management library for Flutter.
- `sqflite` - SQLite plugin for Flutter, used for local database operations.
- `intl` - Internationalization and localization support for Flutter.

These dependencies are automatically resolved by Flutter's package manager.

### License

This project is licensed under the MIT License. Feel free to use and modify the code for your own
purposes.

### Screenshots

![Screen Shot 2023-10-30 at 1 12 42 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/41af8b41-d066-4e0a-b2b5-1e7363802ebf)
![Screen Shot 2023-10-30 at 1 13 13 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/44f80136-bc43-4327-bdb7-fcccc83cf301)
![Screen Shot 2023-10-30 at 1 14 23 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/3b4fba18-769d-461b-9395-37b57a984ea3) ![Screen Shot 2023-10-30 at 1 15 02 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/5d103b25-8bfb-45c9-9405-4874a93f8c32)
