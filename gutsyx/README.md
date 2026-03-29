# GutsyX AI

GutsyX AI is a modern digestive health platform built with Flutter. It uses Gemini 1.5 Flash to provide clinical-grade stool analysis without sacrificing user privacy. Our "Zero-Storage" approach ensures that sensitive specimen images are processed as byte-streams and never stored on any server.

## What's inside

*   **Smart Scan**: Instant classification using the Bristol Stool Scale, colorimetry, and hydration assessment.
*   **Health Dashboard**: A dynamic view of your gut health, including weekly trends and proprietary health scoring.
*   **Medical-Grade Security**: Secure authentication via Firebase and local environment variable management for API keys.
*   **Clinical History**: A detailed log of past analyses to help identify patterns in your digestive health.
*   **Premium Insights**: Subscription-based access to advanced metrics via RevenueCat integration.

## Architecture

The project is built using a **Feature-based architecture** to ensure scalability and maintainability:

*   `core/`: App-wide themes, shared widgets, and constants.
*   `features/auth/`: Complete Firebase Authentication flow (Email/Password).
*   `features/dashboard/`: Health gauges and trend visualization using `fl_chart`.
*   `features/scanner/`: Computer vision logic and Gemini AI integration.
*   `features/history/`: Persistent data models and historical logs.
*   `features/paywall/`: In-app subscription management via RevenueCat.

## Tech Stack

*   **Framework**: Flutter (Riverpod for state management)
*   **Navigation**: GoRouter
*   **AI**: Google Gemini 1.5 Flash (via `google_generative_ai`)
*   **Backend**: Firebase (Auth & Firestore)
*   **Payments**: RevenueCat
*   **Configuration**: `flutter_dotenv` for secure key management

## Setup

1.  **Clone & Install**:
    ```bash
    git clone https://github.com/your-username/gutsyx.git
    cd gutsyx
    flutter pub get
    ```

2.  **Environment Variables**:
    Create a `.env` file in the root directory:
    ```env
    GEMINI_API_KEY=your_key
    REVENUECAT_API_KEY_IOS=your_ios_key
    REVENUECAT_API_KEY_ANDROID=your_android_key
    ```

3.  **Firebase**:
    Configure your Firebase project and add the `firebase_options.dart` file to `lib/`.

4.  **Run**:
    ```bash
    flutter run
    ```

---
*Disclaimer: GutsyX AI is a tracking and educational tool. It does not provide medical diagnoses. Always consult with a healthcare professional for medical concerns.*
