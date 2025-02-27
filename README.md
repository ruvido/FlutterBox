
# Flutter Docker Sway Example

This repository contains a minimal Flutter project configured for **Linux desktop development** (not tested for Web or Android) using Docker and Wayland/Sway forwarding. Follow the steps below to start the project from scratch.

## Prerequisites

- **Docker**
- **Docker Compose**
- **Git:** To clone the repository.
- **Linux with Wayland/Sway:** Ensure your system is running Sway (or another Wayland compositor) and that the following environment variables are set:
  - `WAYLAND_DISPLAY` (typically `wayland-0`)
  - `XDG_RUNTIME_DIR` (typically `/run/user/$(id -u)`)

## Repository Structure

The project is organized as follows:

```
.
├── Dockerfile
├── docker-compose.yml
└── app
    ├── lib
    │   └── main.dart
    ├── pubspec.yaml
    └── # Other Flutter project files
```

## Steps to Get Started

1. **Clone the Repository**

   Open your terminal and run:

   ```bash
   git clone https://github.com/ruvido/flutter-docker-sway.git
   cd flutter-docker-sway
   ```

2. **Build and Start the Docker Container**

   Build the Docker image and start the container:

   ```bash
   docker-compose up --build
   ```

   This builds the image and starts the container (attaching to its logs).

3. **Access the Container’s Shell**

   Open a new terminal window and attach to the running container:

   ```bash
   docker-compose exec flutter bash
   ```

   You should now be inside the container, with your project files available in the `/app` directory.

4. **(Optional) Add Linux Desktop Support**

   If the `app` folder does not already include a `linux` directory, add Linux desktop support by running:

   ```bash
   docker-compose run --rm flutter flutter create --platforms linux .
   ```

   This command generates the required `linux` folder and configuration files inside your Flutter project.

5. **Run the Flutter App**

   Inside the container's shell, run:

   ```bash
   flutter run -d linux
   ```

   This command compiles and launches your Flutter Linux desktop app. With Wayland forwarding configured, the app will appear in your Sway session.

6. **Development Workflow**

   - **Hot Reload:** Edit your files on the host (they are mounted into `/app` in the container), and use Flutter’s hot reload feature to see changes immediately (this is not automatic, you need to type `r` in the interactive shell - `docker-compose exec flutter bash`).
   - **Additional Commands:** Use the interactive shell  to run other Flutter commands as needed.

## Environment Variables

Before running the container, make sure your environment variables are correctly set on your host. You can set them in your shell as follows:

```bash
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
```

## Stopping the Container

To stop the container, you can either press `Ctrl+C` in the terminal where `docker-compose up` is running or execute:

```bash
docker-compose down
```

## Troubleshooting

- **Wayland Forwarding Issues:**  
  If your app doesn’t appear on your host, verify that the Wayland socket is correctly mounted and that both `WAYLAND_DISPLAY` and `XDG_RUNTIME_DIR` are set properly.
  
- **Permissions:**  
  If you experience permission issues accessing the Wayland socket, consider running the container as your host user.

- **Further Reading:**  
  For more details on Flutter desktop support, see the [Flutter Desktop Documentation](https://docs.flutter.dev/desktop).

Happy coding!
