# X-Clone-SwiftUI

An X social media app clone built with SwiftUI for the front end and Django for the back end. This project aims to replicate core features of the X platform, including user authentication, posting, and news feed functionality.

## Features

- **User Authentication**: Users can register, login, and log out.
- **News Feed**: Display posts in a user-friendly, scrollable view.
- **Post Creation**: Users can create and share text-based posts.
- **Responsive UI**: A sleek, modern design built with SwiftUI.
- **Backend API**: Django backend to handle user data, posts, and interactions.

## Installation

### Backend (Django)

1. Clone the backend repository:
    ```bash
    git clone https://github.com/kazimovzaman2/X-Clone-SwiftUI.git backend
    ```
2. Navigate to the backend directory and install dependencies:
    ```bash
    cd backend
    pip install -r requirements.txt
    ```
3. Apply migrations:
    ```bash
    python manage.py migrate
    ```
4. Run the Django development server:
    ```bash
    python manage.py runserver
    ```

### Frontend (SwiftUI)
1. Clone the frontend repository:
    ```bash
    git clone https://github.com/kazimovzaman2/X-Clone-SwiftUI.git mobile
    ```
2. Open the project in Xcode:
    ```bash
    open mobile/X-Clone-SwiftUI.xcodeproj
    ```
3. Apply migrations:
    ```bash
    Build and run the app on your iOS simulator or device.
    ```

## Configuration
- Set the API endpoint URL in the frontend code to match your Django server URL.

## Dependencies
- SwiftUI: For building the mobile app UI.
- Django: For the backend API.
- PostgreSQL/MySQL: For database management (set up as per Django settings).
