# Vehicle Records App 🚓

## Overview

The Vehicle Records App is a simple application that allows users to perform basic CRUD operations (Create, Read, Update, Delete) on vehicle records. The app is divided into two parts - the client built with Flutter and the server built with Node.js, Express, and MongoDB.

## Features

- View a list of all vehicles
- Add a new vehicle record
- Update existing vehicle records
- Delete vehicle records

## Technologies Used

### Client (Flutter)

- **Flutter:** A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart:** The programming language used for building Flutter apps.

### Server (Node.js, Express, MongoDB)

- **Node.js:** A JavaScript runtime built on Chrome's V8 JavaScript engine.
- **Express.js:** A minimal and flexible Node.js web application framework.
- **MongoDB:** A NoSQL database used for storing vehicle records.

## Screenshots
<p align="left">
  <img src="https://github.com/aliasar1/Vehicle-App/blob/main/client/screenshots/s1.png" alt="Main Screen">
</p>

## Getting Started

### Client

1. Navigate to the `client` directory.
2. Ensure Flutter is installed. If not, [install Flutter](https://flutter.dev/docs/get-started/install).
3. Run `flutter pub get` to install dependencies.
4. Connect your mobile device or emulator.
5. Run `flutter run` to launch the app.

### Server

1. Navigate to the `server` directory.
2. Ensure Node.js and npm are installed. If not, [install Node.js](https://nodejs.org/).
3. Run `npm install` to install dependencies.
4. Configure your MongoDB connection in `config/db.js`.
5. Run `npm run dev` to start the server.

## API Endpoints

### Vehicles

- **GET /vehicle:** Retrieve all vehicles.
- **GET /vehicle/:id:** Retrieve a specific vehicle by ID.
- **POST /vehicle:** Add a new vehicle.
- **PUT /vehicle/:id:** Update a specific vehicle by ID.
- **DELETE /vehicle/:id:** Delete a specific vehicle by ID.

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests. ✌
