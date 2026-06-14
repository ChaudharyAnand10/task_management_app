# Setup Instructions

1. Clone the repository.

2. Install the dependencies:

```bash
flutter pub get
```

3. Generate Drift files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the application:

```bash
flutter run
```

# Architectural Decisions

* Used **GetX** for state management and dependency injection because it keeps the code simple and reduces boilerplate.
* Used **Drift (SQLite)** for local data persistence to store tasks offline.
* Followed a basic separation of concerns by organizing the project into controllers, database layer, views, and reusable widgets.
* Used reactive programming with **Obx** to automatically update the UI whenever task data changes.

# Assumptions / Trade-offs

* The application is designed for local task management only; no cloud synchronization is implemented.
* Search and priority filtering are performed in memory using the already loaded task list to avoid unnecessary database queries.
* The current implementation focuses on functionality and simplicity rather than advanced features such as authentication, notifications, or remote backup.
