# BePresent iOS coding challenge
This example project shows a list of friends accomplishments and allows the user to react with emojis.

# Folders structure
This project doesn't adopt one sctrict architecture but instead it is mainly using an MVVM pattern with some elements from a service-repository architecture.

### Services
This folder contains units of code that are mainly agnostic of the project business logic. Think of these services as elements you could easily port to a different project. In this example the NetworkService protocol and it's default implementation are placed here

### Repositories
Repositories are the ones that handle part of the business logic, their main function is to access, manage, and manipulate the data while hiding underlying details related to storage. In this example FriendsRepository protocol is responsible for fetching the list of friends and managing reactions triggered by the user

### Models
These are the representations of our domain entities.

### Screens
Each subfolder in this space should represent a single screen UI in the app. There should be at least 2 files, one for the UI layout and one for the ViewModel of the screen.

### Views 
Common UI componentes that can be used by different screens

