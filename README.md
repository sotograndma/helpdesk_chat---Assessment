Helpdesk Chat – Flutter Responsive Chat Application

This project is a simple and fully responsive Helpdesk Chat Application built using Flutter. It was developed as part of a coding assessment with a 24-hour time limit. The application is designed to work across mobile, tablet, desktop, and web platforms, adapting its interface based on screen size to ensure a consistent and user-friendly experience.

The application provides a clean and modern chat interface inspired by the mockup provided during the assessment. On mobile devices, the interface uses a single-panel layout with a sliding sidebar that contains the chat list. The back button toggles this sidebar, allowing users to switch between the chat list and an active conversation. On desktop and tablet devices, the layout becomes a two-panel interface, where the chat list remains visible on the left and the main chat view appears on the right.

The chat system supports sending and receiving text messages. Message bubbles display timestamps and visually differentiate between user messages and incoming messages. The application also supports sending messages by pressing the Enter key, which makes the typing experience more seamless on both desktop and mobile keyboards. A send button is also available for users who prefer clicking.

For automated replies, the application includes a dummy bot that generates simple responses without requiring network access. Optionally, developers can enable OpenAI integration for more advanced responses by adding an API key and enabling the configuration inside the bot service. This provides flexibility depending on the environment or assessment requirements.

The project follows a structured and organized folder layout, separating core themes, chat data models, business logic, and presentation widgets. Flutter’s Material 3 design system is used to maintain visual consistency throughout the interface, and the layout is optimized for multiple platforms. Assets such as avatars or images can be placed inside the assets/images directory and registered within the pubspec.yaml file.

To run the project, clone the repository, install dependencies using flutter pub get, and execute flutter run on any connected device or flutter run -d chrome to run it in a web browser. The project does not include features such as search functionality, image uploading, file attachment bubbles, multi-threaded conversation history, authentication, or backend integration, as they were not part of the assessment requirements.
