SXB OPS CENTER

Terminal-based device operations and management tool

SXB OPS CENTER is a command-line application developed as an academic cybersecurity/software engineering project.

The project provides a terminal interface for communicating with an authorized device through a backend server and managing supported operations from a centralized console.

«Important: This project is intended for authorized testing, academic research, laboratory environments, and devices for which the operator has explicit permission.»

---

## Quick Start

### Linux / Termux

git clone https://github.com/MOHXCVSXB/SXB-OPS-CLI.git
cd SXB-OPS-CLI
bash install.sh
sxbops


Features

- Device management
- SMS command interface
- SMS logs
- Call commands
- Browser URL commands
- Contacts logs
- Notifications
- Application management interface
- Wallpaper management interface
- Lock-screen interface
- Session management
- Supabase backend connectivity
- Command status tracking
- Activity logs
- TXT data exports
- Linux and Termux support

---

Supported Platforms

Linux

Supported architectures:

- "x86_64 / amd64"
- "aarch64 / arm64"

Termux

Supported architecture:

- "aarch64 / arm64"

---

Installation

The project includes an automatic installer.

Make the installer executable:

chmod +x install.sh

Run:

./install.sh

If the project is located inside Android shared storage and direct execution is restricted by Termux, use:

bash install.sh

The installer automatically detects the environment and architecture.

Termux

The application is installed to:

$PREFIX/bin/sxbops

Linux

The application is installed to:

/usr/local/bin/sxbops

After installation, run:

sxbops

---

Project Structure

SXB-OPS-CLI/
│
├── main.go
├── dashboard.go
├── auth.go
├── session.go
├── supabase.go
├── devices.go
├── sms.go
├── contacts.go
├── call.go
├── browser.go
├── apps.go
├── wallpaper.go
├── warning.go
├── logs.go
│
├── go.mod
├── install.sh
│
├── sxbops
├── sxbops-linux-amd64
└── sxbops-linux-arm64

---

Backend

The application communicates with a Supabase backend.

The backend is responsible for storing device information, commands, logs, and related project data.

The database structure used by the project includes resources such as:

devices
sms_logs
contacts_logs

Command status information is tracked through fields such as:

last_command_id
last_command_status
last_command_time

---

Logs and Exports

The application can create local TXT exports for collected project data.

Exported information can include:

- SMS logs
- Contact logs
- Call command records
- Browser command records

The exported files are designed to remain simple and readable using standard text editors.

---

Activity Logging

The application records selected operations in the project log.

Examples include:

SMS command
Call command
Browser command
SMS export
Contacts export

The logging system is intentionally limited to relevant operations rather than recording every terminal interaction.

---

Security and Authorization

SXB OPS CENTER must only be used against devices, accounts, servers, and environments where the operator has explicit authorization.

Do not use the project to access, monitor, modify, or interact with devices belonging to other people without permission.

For academic testing, use:

- Your own devices
- University laboratory devices
- Dedicated test devices
- Authorized virtual/laboratory environments

---

Academic Use

This project was developed for educational purposes involving concepts such as:

- Software engineering
- Cybersecurity
- Client/server communication
- API integration
- Database management
- Terminal application development
- Logging and auditing
- Linux application deployment

The project should be evaluated within the authorized environment provided for the academic project.

---

Testing

Before deployment, verify:

1. Backend connectivity
2. Authentication
3. Device selection
4. SMS functionality
5. Call functionality
6. Browser functionality
7. Contacts retrieval
8. Logs
9. TXT exports
10. Linux installation
11. Termux installation

---

Developer Contact

For questions, technical communication, or requests to test the project in a safe and authorized environment, please contact the developer through Instagram:

"Contact the developer on Instagram" (https://reference-url-citation.invalid/0)

If you would like to test the tool, please contact the developer first and arrange an explicitly authorized testing environment.

---

Disclaimer

SXB OPS CENTER is provided as an academic and research project.

The developer does not authorize the use of this software for unauthorized access, surveillance, data collection, or interference with systems or devices belonging to others.

The user is responsible for obtaining the necessary authorization before testing or deploying the software.

---

Version

SXB OPS CENTER
Version: v1.0.0
Terminal Edition
