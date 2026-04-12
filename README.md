# GutsyX AI

GutsyX AI is a modern digestive health platform built with Flutter. It uses Gemini 1.5 Flash to provide clinical-grade image analysis.
## Tech Stack

*   **Framework**: Flutter (Riverpod for state management)
*   **Navigation**: GoRouter
*   **AI**: Google Gemini 1.5 Flash (via `google_generative_ai`)
*   **Backend**: Firebase (Auth & Firestore)
*   **Payments**: RevenueCat
*   **Configuration**: Build-time environment variables (`--dart-define`)

## Setup

1.  **Clone & Install**:
    ```bash
    git clone https://github.com/your-username/gutsyx-ai.git
    cd gutsyx-ai
    flutter pub get
    ```

2.  **Firebase**:
    - Create a Firebase project in the console.
    - Run `flutterfire configure` to generate your local `lib/firebase_options.dart`.
    - **Note**: `lib/firebase_options.dart` is ignored by git for security.

3.  **Run with API Keys**:
    Since the project uses secure build-time definitions, run the app with the following flags:

    ```bash
    flutter run \
      --dart-define=GEMINI_API_KEY=your_key \
      --dart-define=REVENUECAT_API_KEY_IOS=your_ios_key \
      --dart-define=REVENUECAT_API_KEY_ANDROID=your_android_key \
      --dart-define=FIREBASE_API_KEY_WEB=your_web_key \
      --dart-define=FIREBASE_APP_ID_WEB=your_web_id \
      --dart-define=FIREBASE_API_KEY_ANDROID=your_android_api_key \
      --dart-define=FIREBASE_APP_ID_ANDROID=your_android_app_id \
      --dart-define=FIREBASE_API_KEY_IOS=your_ios_api_key \
      --dart-define=FIREBASE_APP_ID_IOS=your_ios_app_id
    ```
---
*Disclaimer: GutsyX AI is a tracking and educational tool. 
