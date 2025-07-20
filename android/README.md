# MyClassmates Android App

This is the Android native wrapper for the MyClassmates web application.

## Setup Instructions

### Prerequisites
- Android Studio Arctic Fox or later
- JDK 11 or later
- Android SDK 34

### Firebase Setup
1. Place your `google-services.json` file in `android/app/`
2. Update the package name in `android/app/build.gradle` if needed
3. Configure Firebase services in Firebase Console

### Build Instructions

1. **Open in Android Studio**
   - Open Android Studio
   - Select "Open an existing Android Studio project"
   - Choose the `android` folder

2. **Sync Project**
   - Click "Sync Now" when prompted
   - Wait for Gradle sync to complete

3. **Build APK**
   - Go to Build → Build Bundle(s) / APK(s) → Build APK(s)
   - Or use Gradle: `./gradlew assembleDebug` (debug) or `./gradlew assembleRelease` (release)

4. **Install APK**
   - Debug APK: `android/app/build/outputs/apk/debug/app-debug.apk`
   - Release APK: `android/app/build/outputs/apk/release/app-release.apk`

### Configuration

#### Update Web URL
In `MainActivity.kt`, update the URL to your deployed Next.js app:
```kotlin
webView.loadUrl("https://your-domain.com")
```

#### AdMob Configuration
Update the AdMob app ID in `AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX" />
```

### Permissions
The app requests the following permissions:
- Internet access
- Camera (for video calls)
- Microphone (for voice/video calls)
- Storage (for file uploads)
- Location (optional for school location features)

### Features
- WebView wrapper for Next.js app
- Firebase integration
- AdMob support
- Push notifications
- WebRTC support for voice/video calls
- File upload/download support

### Testing
1. Connect Android device or start emulator
2. Run the app from Android Studio
3. Test all features including:
   - User registration/login
   - School autocomplete
   - Batchmate discovery
   - Chat functionality
   - Voice/video calls
   - Ad display

### Production Deployment
1. Update the web URL to your production Next.js app
2. Configure proper Firebase and AdMob settings
3. Build release APK
4. Sign the APK for Play Store upload
