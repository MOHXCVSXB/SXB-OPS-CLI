
# SXB OPS CENTER

<p align="center">
  <img src="https://cdn.phototourl.com/free/2026-08-07-235c8b77-7e15-420b-b590-5a6394c4d95d.png" width="180">
</p>

<p align="center">
  Terminal-based device operations and management tool
</p>

> Terminal-based device operations and management tool

**Version:** `v1.0.0`  
**Edition:** Terminal Edition  
**License:** Academic / Authorized Testing

---

## NAME

**sxbops** — terminal-based device operations and management console.

---

## DESCRIPTION

**SXB OPS CENTER** is a command-line application developed as an academic
cybersecurity and software engineering project.

The application provides a terminal-based operations console for communicating
with authorized test devices through a backend server and managing supported
operations from a centralized interface.

SXB OPS CENTER is designed for:

- Academic research
- Cybersecurity laboratories
- Software engineering projects
- Authorized device testing
- Controlled testing environments

> **IMPORTANT:** Use this software only on devices, accounts, servers, and
> environments that you own or have explicit permission to test.

---

## FEATURES

- Device management
- SMS command interface
- SMS logs
- Call commands
- Browser URL commands
- Contacts logs
- Notification interface
- Application management interface
- Wallpaper management interface
- Lock-screen interface
- Session management
- Supabase backend connectivity
- Command status tracking
- Activity logging
- TXT data exports
- Linux support
- Termux / Android support
- Automatic architecture detection
- Automatic environment detection

---

## SUPPORTED PLATFORMS

### Linux

Supported architectures:

- `x86_64 / amd64`
- `aarch64 / arm64`

### Android / Termux

Supported architecture:

- `aarch64 / arm64`

The installer automatically detects the current environment and selects the
appropriate binary.

No manual binary selection is required.

---

# INSTALLATION

## Linux

### Requirements

- Linux
- Git
- Supported architecture
- Internet connection

Clone the repository:

```bash
git clone https://github.com/MOHXCVSXB/SXB-OPS-CLI.git
```

Enter the project directory:

```bash
cd SXB-OPS-CLI
```

Run the installer:

```bash
bash install.sh
```

After installation:

```bash
sxbops
```

The Linux executable is installed to:

```text
/usr/local/bin/sxbops
```

---

## Android / Termux

### Requirements

- Android device
- Termux
- ARM64 / AArch64 device
- Internet connection

Install Git:

```bash
pkg update
pkg install git
```

Clone the repository:

```bash
git clone https://github.com/MOHXCVSXB/SXB-OPS-CLI.git
```

Enter the project directory:

```bash
cd SXB-OPS-CLI
```

Run the installer:

```bash
bash install.sh
```

After installation:

```bash
sxbops
```

The Termux executable is installed to:

```text
$PREFIX/bin/sxbops
```

The program can then be started from any directory:

```bash
sxbops
```

---

# QUICK START

For Linux:

```bash
git clone https://github.com/MOHXCVSXB/SXB-OPS-CLI.git
cd SXB-OPS-CLI
bash install.sh
sxbops
```

For Android / Termux:

```bash
pkg install git
git clone https://github.com/MOHXCVSXB/SXB-OPS-CLI.git
cd SXB-OPS-CLI
bash install.sh
sxbops
```

---

# USAGE

After starting the application:

```bash
sxbops
```

The terminal interface provides the main operations dashboard.

Example:

```text
===================================
       SXB OPS CENTER
===================================

[1] Devices
[2] SMS
[3] Calls
[4] Notifications
[5] Browser
[6] Applications
[7] Wallpaper
[8] Lock Screen
[9] Settings

[L] Logout
[0] Exit
```

Select an operation by entering its corresponding number.

Example:

```text
Select > 1
```

---

# INSTALLER

The project includes an automatic installer:

```text
install.sh
```

The installer detects:

1. Operating environment
2. CPU architecture
3. Available binary
4. Installation location

Supported environments:

```text
Linux AMD64
Linux ARM64
Termux ARM64
```

The user does not need to manually select a binary.

---

# INSTALLED FILE

After installation, the executable is available as:

```bash
sxbops
```

You can verify the installation with:

```bash
which sxbops
```

On Termux, the expected location is similar to:

```text
/data/data/com.termux/files/usr/bin/sxbops
```

On Linux, the expected location is:

```text
/usr/local/bin/sxbops
```

---

# PROJECT RELEASE STRUCTURE

The public release contains the following files:

```text
SXB-OPS-CLI/
│
├── README.md
├── install.sh
│
├── sxbops
├── sxbops-linux-amd64
└── sxbops-linux-arm64
```

### Binary files

| File | Platform |
|---|---|
| `sxbops` | Termux / Android ARM64 |
| `sxbops-linux-amd64` | Linux x86_64 / AMD64 |
| `sxbops-linux-arm64` | Linux ARM64 / AArch64 |

---

# BACKEND

SXB OPS CENTER communicates with a Supabase backend.

The backend is responsible for storing project data such as:

```text
devices
sms_logs
contacts_logs
```

Command status information includes fields such as:

```text
last_command_id
last_command_status
last_command_time
```

The backend provides the communication layer between the terminal console
and authorized test devices.

---

# LOGS AND EXPORTS

The application supports project-related logging and TXT exports.

Supported log information may include:

- SMS logs
- Contact logs
- Call command records
- Browser command records

TXT files are intentionally kept in a simple text-based format so they can be
opened using standard text editors and terminal utilities.

Example:

```bash
cat filename.txt
```

---

# ACTIVITY LOGGING

The application records selected operations relevant to the project.

Examples include:

```text
SMS command
Call command
Browser command
SMS export
Contacts export
```

The logging system focuses on relevant project operations rather than
recording every terminal interaction.

---

# SECURITY AND AUTHORIZATION

SXB OPS CENTER is an academic and authorized-testing project.

Only use the software on:

- Your own devices
- Dedicated test devices
- University laboratory devices
- Authorized virtual environments
- Systems for which you have explicit permission

Do not use the software to access, monitor, modify, or interact with devices
or systems belonging to other people without authorization.

---

# SAFE TESTING

For testing the project in a controlled environment, use a dedicated test
device or an authorized laboratory environment.

If you would like to arrange an authorized demonstration or testing session,
contact the developer before testing.

---

# ACADEMIC PURPOSE

This project demonstrates concepts related to:

- Cybersecurity
- Software engineering
- Go application development
- Client/server communication
- REST API integration
- Database management
- Terminal application development
- Linux deployment
- Android / Termux deployment
- Logging and auditing
- Cross-platform binary distribution

---

# TESTING CHECKLIST

Before a release is considered stable, verify:

- [x] Backend connectivity
- [x] Authentication
- [x] Device selection
- [x] SMS functionality
- [x] Call functionality
- [x] Browser functionality
- [x] Contacts retrieval
- [x] Logs
- [x] TXT exports
- [x] Linux installation
- [x] Linux AMD64 binary
- [x] Linux ARM64 binary
- [x] Termux ARM64 installation
- [x] Automatic architecture detection
- [x] Git repository installation

---

# UNINSTALLATION

### Termux

Remove the installed executable:

```bash
rm "$PREFIX/bin/sxbops"
```

### Linux

Remove the installed executable:

```bash
sudo rm /usr/local/bin/sxbops
```

---

# DEVELOPER

For technical communication, academic questions, or requests to test the
project in a safe and authorized environment:

**Instagram**

https://www.instagram.com/x_sxb_x1/

Please contact the developer before requesting or arranging an authorized
testing session.

---

# DISCLAIMER

SXB OPS CENTER is provided as an academic and research project.

The developer does not authorize the use of this software for unauthorized
access, surveillance, data collection, or interference with systems or
devices belonging to others.

The person using the software is responsible for obtaining the necessary
authorization before testing or deploying it.

---

# VERSION

```text
SXB OPS CENTER
Version: v1.0.0
Terminal Edition
```

---

## REPOSITORY

Official repository:

https://github.com/MOHXCVSXB/SXB-OPS-CLI
