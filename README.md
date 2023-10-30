# To-Do List

The code represents a Flutter screen for a to-do list app called `HomeLayout`. Here's a breakdown of its major components and functionalities:

1. Widget Composition:
   - The `HomeLayout` widget is defined as a `StatefulWidget` that manages its own state using `HomeLayoutState`.
   - The screen includes an `AppBar`, a body that displays different task modules based on the selected index, a floating action button, and a bottom navigation bar.

2. Task Modules:
   - The code imports three modules: `NewTasks`, `DoneTasks`, and `ArchiveTasks`, each representing a different view for tasks.
   - These modules are stored in a list called `tasks`, and the currently selected module is displayed in the body based on the `currentIndex` value.

3. Database Operations:
   - The code uses the `sqflite` package to create and interact with an SQLite database.
   - The `createDatabase` function creates the database if it doesn't exist and defines a table named "tasks" with specific columns.
   - The `insertToDatabase` function inserts a new task into the database, providing title, time, and date values.
   - The `getDataFromDataBase` function retrieves all tasks from the database and returns them as a list of maps.

4. UI Interactions:
   - Tapping the floating action button toggles a bottom sheet.
   - The bottom sheet contains a form for adding a new task, including fields for title, time, and date.
   - When the form is submitted, the `insertToDatabase` function is called to insert the task into the database.
   - The `showTimePicker` and `showDatePicker` functions are used to display time and date pickers, respectively.

5. State Management:
   - The `currentIndex` variable tracks the currently selected task module in the bottom navigation bar.
   - The `isBottomSheet` variable determines whether the bottom sheet is currently displayed.
   - The `changeIcon` variable stores the icon for the floating action button, which changes based on the bottom sheet state.

6. Lifecycle and Initialization:
   - The `initState` method is overridden and called when the widget is first created.
   - In `initState`, the `createDatabase` function is called to initialize the database.

Overall, the code combines Flutter's widget composition, state management, database operations, form handling, and UI interactions to create a to-do list app with multiple task modules and database integration.

![Screen Shot 2023-10-30 at 1 12 42 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/41af8b41-d066-4e0a-b2b5-1e7363802ebf)
![Screen Shot 2023-10-30 at 1 13 13 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/44f80136-bc43-4327-bdb7-fcccc83cf301) 
![Screen Shot 2023-10-30 at 1 14 23 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/3b4fba18-769d-461b-9395-37b57a984ea3) ![Screen Shot 2023-10-30 at 1 15 02 AM](https://github.com/MostafaRadian/To_Do_list/assets/46004434/5d103b25-8bfb-45c9-9405-4874a93f8c32)

