Flutter Clean Architecture App


This is a Flutter app demonstrating clean architecture principles using the Provider package for state management. The app includes structured layers, unit tests, and follows Test-Driven Development (TDD) practices.


App Structure:

Presentation Layer: Contains the UI code (screens and widgets) and handles user interaction.

Domain Layer: Contains business logic, including use cases and entities.

Data Layer: Manages data sources (e.g., APIs, local storage). This layer includes repositories that interact with the domain layer.

Provider Layer: The Provider package is used for state management, injecting dependencies and maintaining app state efficiently.

__________________________________________________________

Steps to Run the Project

To run this Flutter app locally, follow these steps:

1- Clone the repository:
git clone https://github.com/eslamelezaby98/store.git


2 - Install dependencies:
flutter pub get

3- Run the app:
flutter run

__________________________________________________________

Packages Used

1- Provider:
Chosen for state management because of its simplicity and ease of use in Flutter apps. It promotes clean separation of concerns and works well with the clean architecture.

2-Shared Preferences:
Used for local storage in this app to store lightweight data persistently, like cart items.

3-Internet Connection Checker:
This package is used to detect the current internet status. It ensures that the app can check if a network connection is available before making API calls, improving error handling.

4- Cached Network Image:
This package helps to efficiently cache and display images from the network. It reduces the app’s network usage and improves the user experience by displaying cached images when offline.
