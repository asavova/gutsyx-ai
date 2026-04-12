# GutsyX AI

> **A Privacy-First Digestive Health Platform Powered by AI**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)
![Google Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B6?style=flat-square&logo=google&logoColor=white)

GutsyX AI is a privacy-focused digestive health platform built with Flutter. Leveraging Google Gemini 1.5 Flash, it delivers clinical-grade stool analysis while maintaining strict user privacy standards. The innovative **Zero-Storage** architecture ensures sensitive specimen images are processed as byte-streams and never persisted on any server.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [AI Integration](#ai-integration)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Security & Privacy](#security--privacy)
- [Disclaimer](#disclaimer)

## Features

- **Smart Scan**: Intelligent classification using Bristol Stool Scale, colorimetry, and hydration assessment
- **Health Dashboard**: Real-time visualization of gut health metrics with weekly trend analysis
- **Medical-Grade Security**: Enterprise-level authentication via Firebase with API key management
- **Clinical History**: Comprehensive historical logs to identify digestive health patterns
- **Premium Insights**: Subscription-based advanced metrics via RevenueCat integration

## Architecture

GutsyX AI employs a **modular feature-based architecture** designed for scalability, maintainability, and clean separation of concerns:

| Module | Purpose |
|--------|---------|
| `core/` | App-wide themes, shared widgets, and application constants |
| `features/auth/` | Comprehensive Firebase Authentication implementation (Email/Password) |
| `features/dashboard/` | Health visualization with gauges and trend analytics using `fl_chart` |
| `features/scanner/` | Computer vision processing and Gemini AI integration |
| `features/history/` | Persistent data models and historical analysis logs |
| `features/paywall/` | Revenue management and subscription handling via RevenueCat |

## AI Integration

### Model Selection

GutsyX AI utilizes **Google Gemini 1.5 Flash** for clinical-grade analysis:

- **Why Gemini 1.5 Flash?** Lower latency (500-800ms) and cost-effectiveness compared to GPT-4V, with competitive accuracy for image classification tasks
- **Input Modality**: Multimodal vision-language model capable of analyzing specimen images with contextual metadata
- **Output Reliability**: Deterministic classification leveraging Bristol Stool Scale (BSS) standardization

### Integration Architecture

```
Client (Image Capture)
    ↓
Byte-Stream Processing (in-memory)
    ↓
Gemini Vision API (multimodal analysis)
    ↓
Structured Response Parsing (JSON schema)
    ↓
Local Cache & Dashboard Render
```

**Key Design Decisions:**
- **Zero Server Persistence**: Images never written to disk or server storage — processed as byte-streams only
- **Streamlined Pipeline**: Direct client-to-API communication with minimal middleware, reducing attack surface
- **Structured Outputs**: Enforce JSON schema validation on all API responses for type safety

### Request/Response Pipeline

#### Request Format
```dart
// Specimen analysis request encapsulates:
// - Base64 encoded image bytes
// - Metadata: specimen collection date, hydration score
// - Optional: user-provided health context
```

#### Response Handling
```dart
// Guaranteed schema:
{
  "classification": {
    "bss_type": 1-7,           // Bristol Stool Scale (1-7)
    "confidence": 0.0-1.0,      // Model confidence
    "color_index": {            // Colorimetry analysis
      "hex": "#XXXXXX",
      "health_score": 0-100
    },
    "hydration_level": "low|moderate|high",
    "clinical_flags": []        // Potential health indicators
  }
}
```

### Performance & Optimization

| Metric | Target | Strategy |
|--------|--------|----------|
| **First-Time Analysis Latency** | <2s | Concurrent image preprocessing + API request batching |
| **Cache Hit Rate** | >40% | Local Hive persistence with semantic hashing |
| **API Cost** | <$0.02/scan | Gemini Flash vs. standard models (4-5x cost reduction) |
| **Error Recovery Rate** | >99% | Exponential backoff with jitter, circuit breaker pattern |

### Error Handling & Resilience

**Built-in Safeguards:**
- `ApiTimeoutException`: Automatic retry with exponential backoff (max 3 attempts)
- `InvalidImageException`: Client-side validation pre-upload (format, size, dimensions)
- `RateLimitException`: Request throttling via token bucket algorithm (10 req/min per user)
- `PartialFailureException`: Graceful degradation with cached results if API temporarily unavailable

**Circuit Breaker Pattern:**
- Monitors API success rate over 5-minute windows
- Auto-backoff if error rate exceeds 15%
- Switches to cached historical insights until service recovery

### Cost Management

**Estimated Monthly Costs** (1,000 active users, 5 scans/user):
- Gemini API: ~$40 (5,000 images × $0.008)
- Firebase Firestore: ~$15 (document reads/writes)
- **Total**: ~$55/month (sustainable pricing model)

**Optimization Levers:**
- Image compression (JPEG 80% quality) before transmission
- Request batching during off-peak hours for historical analysis
- Caching strategy prioritizes high-value classifications

### Future Enhancements

- **Fine-tuning**: Custom Gemini model specialized on digestive health corpus (post-MVP)
- **Multimodal Context**: Integrate user dietary logs + time-of-day metadata for enhanced accuracy
- **Edge Inference**: On-device preprocessing with ML Kit for pre-screening (reduced API calls)
- **Federated Learning**: Privacy-preserving model updates using anonymized analysis patterns

## Tech Stack

| Component | Technology |
|-----------|-----------|
| **Framework** | Flutter with Riverpod (state management) |
| **Navigation** | GoRouter |
| **AI/ML** | Google Gemini 1.5 Flash (`google_generative_ai`) |
| **Backend** | Firebase (Authentication & Firestore) |
| **Payments** | RevenueCat |
| **Configuration** | Build-time environment variables (`--dart-define`) |

## Getting Started

### Prerequisites

- Flutter 3.x or higher
- Dart 3.x or higher
- A Firebase project
- API keys for Gemini, RevenueCat, and Firebase

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/gutsyx-ai.git
   cd gutsyx-ai
   flutter pub get
   ```

2. **Configure Firebase:**
   ```bash
   flutterfire configure
   ```
   This generates `lib/firebase_options.dart` (automatically ignored by git for security).

3. **Run the application:**
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

## Security & Privacy

GutsyX AI implements a **Zero-Leak security model**:
- ✅ No image persistence on servers — byte-stream processing only
- ✅ Enterprise-grade authentication via Firebase

## Disclaimer

GutsyX AI is an educational and tracking tool. It does not provide medical diagnoses. Users must consult qualified healthcare professionals for medical concerns or diagnosis.
