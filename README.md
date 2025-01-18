# Flutter Task Management App

Overview

The Flutter Task Management App is a user-friendly application designed to help users manage their tasks efficiently. The app includes features such as user authentication, task management with full CRUD operations, pagination for handling large datasets, state management with Bloc, data persistence using SharedPreferences, and unit tests for authentication and task functionalities.

Key Features

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

