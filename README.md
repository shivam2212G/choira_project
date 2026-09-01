# Choira Music Player

A modern Flutter music player application that integrates with the Jamendo API to stream music. Built with a focus on clean architecture, state management, and smooth user experience.

> **Note**: This app is only for Android and iOS mobiles.

## Features

- **Browse & Search**: Explore tracks from the Jamendo music library or search for specific songs/artists.
- **Infinite Scrolling**: Automatic pagination to load more tracks as you scroll.
- **Modern Audio Player**: 
  - Play, pause, skip next/previous.
  - Seek through tracks using a progress bar.
  - Background-ready playback state management.
- **Dynamic UI**:
  - **Home Screen**: List view of available tracks.
  - **Mini Player**: Quick controls accessible from any screen.
  - **Now Playing**: Dedicated full-screen player with high-quality artwork.
- **State Management**: Robust implementation using the `Provider` package.
- **Image Caching**: Optimized performance using `cached_network_image`.

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Provider
- **Audio Engine**: just_audio
- **API**: Jamendo API v3.0

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version recommended)
- Android Studio / VS Code with Flutter extensions
- An active internet connection (for API streaming)

### Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd choira_project
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

### API Configuration

1. Create a `.env` file in the project root.
2. Add the Jamendo Client ID:
   ```env
   JAMENDO_CLIENT_ID=your_client_id
   ```
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

The `.env` file is excluded from Git using `.gitignore`.

**Important**: Do not commit `.env` or any API credentials or secrets to the GitHub repository.

## Project Structure

- `lib/models/`: Data models for API responses.
- `lib/services/`: API and Audio service logic.
- `lib/providers/`: State management logic for UI and audio control.
- `lib/widgets/`: Reusable UI components (TrackTile, MiniPlayer).
- `lib/screens/`: Main application screens (Home, Now Playing).

## How It Works

1. **Initialization**: On launch, the `MusicProvider` triggers an initial fetch of tracks from the Jamendo API.
2. **Data Flow**: The `ApiService` fetches JSON data, which is parsed into `Track` objects and held in the `MusicProvider`'s state.
3. **Audio Handling**: When a track is selected, the `AudioService` initializes a `just_audio` player with the track's stream URL.
4. **Reactive UI**: The UI listens to the `MusicProvider` and `just_audio` streams to update progress bars, play/pause icons, and track information in real-time.
5. **Pagination**: A `ScrollController` on the Home Screen detects when the user is near the bottom and requests the next page of data, which is then appended to the existing list.
