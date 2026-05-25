# 📱 Social Connect App — Flutter Internship (Cycle 2)

A Flutter social media application built during the Mobile App Development Internship (Weeks 4-6), featuring real-time posts, messaging, user following, and Firebase integration.

---

## ✨ Features

### Week 4 — Basic Social Features
- 👥 **User Follow System** — Follow/Unfollow users, stored in Firestore
- 💬 **Real-time Messaging** — Chat between users, stored in Firestore
- ✏️ **Post Edit & Delete** — Edit or delete your own posts
- 🔽 **Bottom Navigation Bar** — Home, Search, Profile tabs

### Week 5 — Enhanced User Experience
- 🖼️ **Image Upload in Posts** — Pick images from gallery and post them
- 🔍 **Search Users** — Find users by name using Firestore queries
- 👤 **Profile Setup** — Update name, bio, and profile picture
- ⚡ **Performance** — Streams for real-time updates, optimized image loading

### Week 6 — Final Touches
- ✅ **App Testing** — Tested on Android device
- 🚀 **Deployment Ready** — Production build prepared

### Weeks 1–3 — Base App
- 🔐 Firebase Email/Password Authentication
- 📝 Signup with Firestore user profile creation
- 🔑 Login with error handling
- 🌊 Animated Splash Screen
- ⚙️ Settings screen (notifications, dark mode, privacy)
- 🔒 Forgot Password screen

---

## 🗂️ Project Structure

```
lib/
├── main.dart                        # App entry + Firebase init + routes
├── screens/
│   ├── splash_screen.dart           # Animated splash + auth check
│   ├── login_screen.dart            # Firebase login
│   ├── signup_screen.dart           # Firebase signup + Firestore save
│   ├── forgot_password_screen.dart  # Password reset
│   ├── home_screen.dart             # Feed + create/edit/delete posts + image upload
│   ├── profile_screen.dart          # Profile + edit + photo upload + my posts
│   ├── settings_screen.dart         # App settings + logout
│   ├── search_screen.dart           # Search users by name
│   ├── user_detail_screen.dart      # View user profile + follow/unfollow + message
│   ├── chat_list_screen.dart        # List of followed users to chat with
│   └── chat_screen.dart             # Real-time 1-on-1 chat
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.11.1`
- Dart SDK
- A Firebase account
- Android Studio or VS Code
- An Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/social_connect.git
   cd social_connect
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable **Email/Password** Authentication
   - Create a **Firestore** database in test mode
   - Enable **Firebase Storage**
   - Download `google-services.json` → place in `android/app/`

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---|---|---|
| `firebase_core` | ^2.27.0 | Firebase initialization |
| `firebase_auth` | ^4.17.0 | Email/Password authentication |
| `cloud_firestore` | ^4.15.0 | Real-time cloud database |
| `firebase_storage` | ^11.6.0 | Image upload and storage |
| `provider` | ^6.1.2 | State management |
| `image_picker` | ^1.0.7 | Gallery image selection |
| `cached_network_image` | ^3.3.1 | Optimized network images |
| `go_router` | ^13.2.0 | Navigation |
| `timeago` | ^3.6.1 | Human-readable timestamps |

---

## 🔥 Firebase Collections Structure

```
users/
  {uid}/
    name, email, bio, profilePicture,
    followers, following, createdAt
    followers/ {uid} → followedAt
    following/ {uid} → followedAt

posts/
  {postId}/
    content, imageUrl, userId, userName,
    likes, likedBy[], comments, createdAt

chats/
  {chatId}/
    messages/ {msgId} →
      text, senderId, receiverId, createdAt
```

---

## 📸 Screens

| Screen | Description |
|---|---|
| Splash | Animated logo, checks Firebase auth state |
| Login | Firebase Email/Password with error handling |
| Signup | Create account, saves to Firestore |
| Home | Real-time post feed, like, create/edit/delete posts, image upload |
| Search | Find users by name, tap to view profile |
| User Detail | View user profile, follow/unfollow, open chat |
| Chat List | List of followed users |
| Chat | Real-time 1-on-1 messaging |
| Profile | View/edit profile, upload photo, see my posts |
| Settings | Notifications, dark mode, privacy, logout |

---

## 🎬 Video Demo

A walkthrough video showing:
- Creating posts with images
- Following users
- Sending messages
- Profile editing

---

## 👨‍💻 Author

Built as part of the **Mobile App Development Internship — Cycle 2**
Weeks 4–6 | Deadline: 14 April 2026
