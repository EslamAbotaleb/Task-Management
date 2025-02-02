# Flutter Task Management App

Overview

The Flutter Task Management App is a user-friendly application designed to help users manage their tasks efficiently. The app includes features such as user authentication, task management with full CRUD operations, pagination for handling large datasets, state management with Bloc, data persistence using SharedPreferences, and unit tests for authentication and task functionalities.

# Project Structure
This project follows Clean Architecture, a software design pattern that divides the codebase into different layers, each with distinct responsibilities. This approach improves maintainability, testability, and separation of concerns.

# Overview of the Architecture
The application is divided into three primary layers:

Data Layer
Domain Layer
Presentation Layer
Each layer communicates only with the adjacent layer, which helps keep the code modular and easier to maintain.
# Key Features

1. User Authentication

API: Login APIDescription: Users can log in securely using their username and password.

Login Endpoint: POST /auth/login

Example Payload:

{
  "username": "user1",
  "password": "password123"
}

2. Task Management

Feature: Full CRUD (Create, Read, Update, Delete) operations for managing tasks.API: Task API

View Tasks: Fetch all tasks for the user.

Add Task: Create a new task.

Edit Task: Update an existing task.

Delete Task: Remove a task from the list.

Example CRUD Endpoints:

Create Task: POST /todos/add

Read Tasks: GET /todos

Update Task: PUT /todos/{id}

Delete Task: DELETE /todos/{id}

3. Pagination

Feature: Efficient handling of large task data sets using pagination.API: https://dummyjson.com/todos?limit=10&skip=10

Description:

Fetch tasks in chunks by specifying the limit and skip parameters.

Optimizes performance and enhances user experience by loading data incrementally.

4. State Management

Feature: Centralized state management for better organization and scalability.Used: Bloc (Business Logic Component)

Benefits:

Clear separation of UI and business logic.

Improved maintainability and testability.

5. Local Storage

Feature: Persistent task storage to ensure tasks are accessible offline.Used: SQlite

Description:

Tasks are stored locally on the device.

Users can access their tasks even after closing and reopening the app.

6. Unit Tests

Feature: Comprehensive unit tests to ensure app reliability.Testing Tools: Mocktail, Mockito

Scope of Tests:

Authentication (Login functionality)

Task List (CRUD operations)


# Screenshots
![Screenshot_1737157960](https://github.com/user-attachments/assets/c2446d1c-5580-432a-8d85-8e9907de7b6f)

![Screenshot_1737159649](https://github.com/user-attachments/assets/56938496-fee9-4149-94cc-7d86b49b93dc)

![Screenshot_1737159665](https://github.com/user-attachments/assets/eca1f37c-e6ad-46f8-9f29-da5e8459b42a)

![Screenshot_1737159678](https://github.com/user-attachments/assets/b0ee7750-746c-4337-971c-32cd56edc7e1)

![Screenshot_1737159686](https://github.com/user-attachments/assets/e409b6e2-dbc6-4c41-a51c-fafa8feabf79)






