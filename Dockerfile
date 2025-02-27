
# Use a maintained Flutter image as the base
FROM cirrusci/flutter:latest

# Install Linux desktop dependencies (GTK, clang, CMake, ninja)
RUN apt-get update && apt-get install -y \
    libgtk-3-dev \
    clang \
    cmake \
    ninja-build \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory for your Flutter app
WORKDIR /app

# Copy dependency files and fetch packages first to leverage Docker caching
COPY app/pubspec.* ./
RUN flutter pub get

# Copy the rest of your Flutter application code from the 'app' folder
COPY app/ .

# Enable Linux desktop support (Wayland will be used if available)
RUN flutter config --enable-linux-desktop

# Default to bash for interactive development
ENTRYPOINT ["bash"]
