# StudentSphere

StudentSphere is a comprehensive student life management application built with Flutter. It aims to help students organize their academic and personal lives efficiently, integrating modern tools like AI assistance and cloud synchronization.

## Features

*   **🤖 AI Assistant**: Integrated Gemini AI for smart assistance, chat, and content generation.
*   **📅 Timetable Management**: Organize and view class schedules easily.
*   **📝 Notes**: Create, edit, and manage notes with AI-powered enhancements.
*   **✅ Assignments**: Track assignment deadlines and status.
*   **📊 Attendance**: Monitor attendance records to keep track of academic requirements.
*   **🗓️ Events**: Manage personal and academic events with a built-in calendar.
*   **📢 Notices**: Stay updated with important announcements.
*   **💼 Workspace**: A Kanban-style board to manage projects and tasks efficiently.
*   **🔐 Authentication**: Secure login and sign-up using Firebase Auth and Google Sign-In.
*   **🎨 Customizable Theme**: Support for Light and Dark modes.

## Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/)
*   **Language**: [Dart](https://dart.dev/)
*   **Backend & Services**: [Firebase](https://firebase.google.com/)
    *   Authentication
    *   Cloud Firestore
    *   Cloud Storage
    *   Cloud Messaging
    *   Crashlytics
    *   Analytics
*   **State Management**: [Riverpod](https://riverpod.dev/)
*   **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
*   **AI Integration**: [Google Generative AI (Gemini)](https://ai.google.dev/)
*   **Code Generation**: [Freezed](https://pub.dev/packages/freezed) & [JSON Serializable](https://pub.dev/packages/json_serializable)

## Getting Started

Follow these steps to set up the project locally.

### Prerequisites

*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
*   [Firebase CLI](https://firebase.google.com/docs/cli) installed and logged in.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/student-sphere.git
    cd student-sphere
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Configure Firebase:**

    This project relies on Firebase. You need to configure it for your specific Firebase project.

    ```bash
    flutterfire configure
    ```

    Follow the prompts to select your project and platforms. This will generate `lib/firebase_options.dart`.

4.  **Run the Code Generator:**

    Since this project uses `freezed` and `riverpod_generator`, you need to run the build runner to generate the necessary code.

    ```bash
    dart run build_runner build -d
    ```

5.  **Run the App:**

    ```bash
    flutter run
    ```

## Project Structure

The project follows a feature-first architecture:

```
lib/
├── core/           # Core utilities, theme, router, and shared widgets
├── features/       # Feature-specific modules
│   ├── ai/         # AI Chat and features
│   ├── assignments/# Assignment tracking
│   ├── attendance/ # Attendance management
│   ├── auth/       # Authentication logic and UI
│   ├── events/     # Calendar and events
│   ├── notes/      # Note taking
│   ├── notices/    # App notices
│   ├── settings/   # App settings
│   ├── timetable/  # Class timetable
│   └── workspace/  # Kanban board workspace
├── main.dart       # Entry point
└── firebase_options.dart # Generated Firebase configuration
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
