# Karthikeyan Portfolio App 🚀

A beautiful, modern portfolio mobile application built with Flutter. Features a sleek dark/light theme toggle, animated UI, and GitHub integration.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
## App Link.  [Click Here](https://www.mediafire.com/file/3ubp061ys44i98v/KeyanPortfolio-Release.apk/file)
## ✨ Features

- **🌓 Dark/Light Theme Toggle** - Seamlessly switch between dark and light modes
- **👤 Profile Section** - Beautiful intro with profile photo and animated elements
- **📁 Projects Showcase** - Display GitHub projects with:
  - Language percentage bars (like GitHub)
  - Tech stack tags
  - Live demo & repo links
- **📊 Skills Section** - Animated skill bars with categories
- **📧 Contact Form** - Easy-to-use contact section with email integration
- **🔔 GitHub Activity Notifications** - Real-time GitHub push notifications banner
- **🎨 Orange Theme** - Consistent orange accent color scheme throughout

## 📱 Screenshots

| Home | Projects | Skills |
|------|----------|--------|
| Dark & Light mode with profile photo | Project cards with language stats | Animated skill bars |

## 🛠️ Tech Stack

- **Framework:** Flutter 3.10+
- **State Management:** Provider
- **Animations:** flutter_animate
- **Fonts:** Google Fonts (Outfit)
- **HTTP:** http package for GitHub API
- **URL Launcher:** For external links

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10 or higher
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone https://github.com/KarthikeyanS2006/keyanapp.git
```

2. Navigate to project directory:
```bash
cd keyanapp
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point with theme setup
├── providers/
│   └── theme_provider.dart   # Dark/Light theme management
├── screens/
│   └── home_screen.dart      # Main screen with navigation
├── sections/
│   ├── intro_section.dart    # Home/Intro page with photo
│   ├── about_section.dart    # About me section
│   ├── projects_section.dart # Projects listing
│   ├── skills_section.dart   # Skills with progress bars
│   └── contact_section.dart  # Contact form
├── widgets/
│   ├── project_card.dart     # Project card with language bars
│   ├── hover_button.dart     # Animated button widget
│   └── github_activity_banner.dart # GitHub notification banner
├── models/
│   └── project.dart          # Project data model
└── services/
    └── github_service.dart   # GitHub API integration
```

## 🎨 Color Scheme

| Color | Hex | Usage |
|-------|-----|-------|
| Orange | `#FF9800` | Primary accent |
| Dark Background | `#121212` | Dark mode background |
| Dark Surface | `#1E1E1E` | Dark mode cards |
| Light Background | `#F5F5F5` | Light mode background |

## 👨‍💻 Author

**Karthikeyan S**
- GitHub: [@KarthikeyanS2006](https://github.com/KarthikeyanS2006)
- Website: [karthikeyans2006.github.io](https://karthikeyans2006.github.io/)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

⭐ Star this repo if you find it helpful!

