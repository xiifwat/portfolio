# Portfolio Website - Tawfiqur Rahman

A responsive portfolio website built with Flutter, inspired by modern portfolio designs. This website showcases professional experience, projects, and skills with a clean, modern interface that works seamlessly across web and mobile platforms.

## 🚀 Features

- **Responsive Design**: Adapts gracefully to different screen sizes (mobile, tablet, desktop)
- **Modern UI**: Clean, professional design with smooth animations and transitions
- **Navigation**: Top-right navigation menu with smooth routing between sections
- **Animations**: Engaging fade-in animations using the `animate_do` package
- **Clean Architecture**: Well-structured code following Flutter best practices
- **State Management**: Riverpod for efficient state management
- **Routing**: GoRouter for declarative navigation

## 🛠️ Tech Stack

- **Flutter**: Cross-platform UI framework
- **Riverpod**: State management solution
- **GoRouter**: Declarative routing
- **Responsive Framework**: For responsive design
- **Animate Do**: For smooth animations
- **Font Awesome**: Icon library
- **URL Launcher**: For external links

## 📱 Pages

### Home Page (Implemented)
- Hero section with introduction
- About section with professional summary
- Skills & Technologies showcase
- Contact section with social links

### Other Pages (Placeholder)
- **Experience**: Professional experience and career timeline
- **Projects**: Portfolio of completed projects
- **About**: Detailed personal and professional information

## 🎨 Design Features

- **Dark Theme**: Professional dark gradient background
- **Typography**: Clean, readable fonts with proper hierarchy
- **Color Scheme**: Blue accent color with white/gray text
- **Animations**: Staggered fade-in effects for engaging user experience
- **Responsive Layout**: Optimized for all screen sizes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Web browser for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Portfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:

**For Web:**
```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

**For Mobile (with device/emulator connected):**
```bash
flutter run
```

4. Open your browser and navigate to `http://localhost:8080`

## 📁 Project Structure

```
lib/
├── main.dart                 # Main application entry point
│   ├── MyApp                 # Root application widget
│   ├── CustomAppBar          # Reusable navigation bar
│   ├── HomePage              # Main landing page
│   ├── ExperiencePage        # Experience section (placeholder)
│   ├── ProjectsPage          # Projects section (placeholder)
│   └── AboutPage             # About section (placeholder)
└── ...
```

## 🎯 Key Implementation Details

### Responsive Design
- Uses `ResponsiveBreakpoints` for different screen sizes
- Mobile-first approach with adaptive layouts
- Conditional rendering based on screen size

### State Management
- Riverpod providers for navigation state
- Consumer widgets for reactive UI updates

### Navigation
- GoRouter for declarative routing
- Navigation state tracking with Riverpod
- Smooth transitions between pages

### Animations
- `animate_do` package for entrance animations
- Staggered animations for visual appeal
- Smooth hover effects and transitions

## 🔧 Customization

To customize this portfolio for your own use:

1. **Personal Information**: Update name, title, and description in `HomePage`
2. **Skills**: Modify the skills array in `_buildSkillsSection`
3. **Social Links**: Update URLs in `_buildContactSection`
4. **Colors**: Adjust the color scheme in the theme configuration
5. **Content**: Add your own content to the placeholder pages

## 📱 Responsive Breakpoints

- **Mobile**: 0-450px
- **Tablet**: 451-800px
- **Desktop**: 801-1920px
- **4K**: 1921px+

## 🌐 Deployment

For web deployment:

```bash
flutter build web
```

The built files will be in the `build/web` directory, ready for deployment to any web hosting service.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

## 📞 Contact

- **Email**: contact@example.com
- **LinkedIn**: [Your LinkedIn Profile]
- **GitHub**: [Your GitHub Profile]

---

**Note**: This portfolio is inspired by modern web design trends and implements best practices for Flutter web development. The design is responsive and optimized for both performance and user experience.
// flutter build web --release --base-href="/portfolio/"

deploy.yml
name: Deploy to GitHub Pages
on:
push:
branches: [ main ]
jobs:
build:
runs-on: ubuntu-latest
steps:
- uses: actions/checkout@v3
- uses: subosito/flutter-action@v2
with:
channel: stable
- run: flutter config --enable-web
- run: flutter pub get
- run: flutter build web --release --base-href=/<repository-name>/
- uses: peaceiris/actions-gh-pages@v3
with:
github_token: ${{ secrets.GITHUB_TOKEN }}
publish_dir: build/web
