#GutsyX AI
GutsyX AI is a modern digestive health platform built with Flutter. It uses Gemini 1.5 Flash to provide clinical-grade stool analysis without sacrificing user privacy. Our "Zero-Storage" approach ensures that sensitive specimen images are processed as byte-streams and never stored on any server.
What's inside
•
Smart Scan: Instant classification using the Bristol Stool Scale, colorimetry, and hydration assessment.
•
Health Dashboard: A dynamic view of your gut health, including weekly trends and proprietary health scoring.
•
Medical-Grade Security: Secure authentication via Firebase and environment variable management for API keys.
•
Clinical History: A detailed log of past analyses to help identify patterns in your digestive health.
•
Premium Insights: Subscription-based access to advanced metrics via RevenueCat integration.
Architecture
The project is built using a Feature-based architecture to ensure scalability and maintainability:
•
core/: App-wide themes, shared widgets, and constants.
•
features/auth/: Complete Firebase Authentication flow (Email/Password).
•
features/dashboard/: Health gauges and trend visualization using fl_chart.
•
features/scanner/: Computer vision logic and Gemini AI integration.
•
features/history/: Persistent data models and historical logs.
•
features/paywall/: In-app subscription management via RevenueCat.
Tech Stack
•
Framework: Flutter (Riverpod for state management)
•
Navigation: GoRouter
•
AI: Google Gemini 1.5 Flash (via google_generative_ai)
•
Backend: Firebase (Auth & Firestore)
•
Payments: RevenueCat
•
Configuration: Build-time environment variables (--dart-define)
Setup
1.
Clone & Install:
git clone https://github.com/your-username/gutsyx-ai.git
cd gutsyx-ai
flutter pub get
2.
Firebase:
◦
Create a Firebase project in the console.
◦
Run flutterfire configure to generate your local lib/firebase_options.dart.
◦
Note: lib/firebase_options.dart is ignored by git for security.
3.
Run with API Keys: Since the project uses secure build-time definitions, run the app with the following flags:
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
Security
This project implements Zero-Leak security:
•
Sensitive files (.env, firebase_options.dart) are explicitly excluded from version control.
•
All API keys are injected at build time using --dart-define, preventing them from being hardcoded in the source.
