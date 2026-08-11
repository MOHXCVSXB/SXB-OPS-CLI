# SXB-OPS-CLI

**SXB OPS CENTER — Terminal Edition `v1.0.0`**

A terminal-based device operations and management tool, developed as an academic cybersecurity / software engineering project.

SXB OPS CENTER provides a command-line interface (CLI) that communicates with an authorized device through a backend server and manages supported operations from a centralized console.

> **Important:** This project is intended for authorized testing, academic research, laboratory environments, and devices for which the operator has explicit permission. It is **not** intended for use against any system, device, or account that the operator does not own or is not explicitly authorized to test.

---

## Table of Contents

- [About the Project](#about-the-project)
- [Academic Scope](#academic-scope)
- [How It Works](#how-it-works)
- [Features](#features)
- [Supported Platforms](#supported-platforms)
- [Technology Stack](#technology-stack)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Backend & Data](#backend--data)
- [Logs & Exports](#logs--exports)
- [Safe Usage Examples](#safe-usage-examples)
- [Security & Ethics](#security--ethics)
- [Academic Disclaimer](#academic-disclaimer)
- [Limitations](#limitations)
- [Future Improvements](#future-improvements)
- [License](#license)
- [Contact & Authorized Testing](#contact--authorized-testing)
- [Version](#version)

---

## About the Project

SXB OPS CENTER is a terminal application written in **Go**. It acts as a centralized operations console that:

1. Authenticates an operator using an access token managed by a backend service.
2. Lists the devices associated with the authenticated operator.
3. Lets the operator select a device and issue supported operations against it (SMS, calls, browser, applications, wallpaper, warnings, and media upload).
4. Reads back logs (SMS, contacts) and exports them as local plain-text files.
5. Transfers uploaded media files to Cloudinary for external storage.

This repository contains the **client-side console only**. The device-side agent that actually executes the commands on a mobile device is a separate component and is not included here.

---

## Academic Scope

This project was developed for educational purposes, illustrating concepts such as:

- Software engineering and CLI application design
- Cybersecurity and access-control concepts
- Client/server communication over HTTP
- REST API integration (Supabase and Cloudinary)
- Database management and querying
- Terminal application development in Go
- Logging and auditing patterns
- Linux application packaging and deployment (including Termux)

The project is intended to be evaluated only within the authorized environment provided for the academic project (e.g., your own devices, university laboratory devices, dedicated test devices, or authorized virtual/laboratory environments).

---

## How It Works

The console performs its operations through **HTTP requests to a Supabase (PostgreSQL) backend**:

- **Authentication:** The operator provides an access token. The CLI queries the `tokens` table in Supabase to validate it. A successful login is stored locally in a `.session` file so the operator does not need to log in again during the session.
- **Device listing:** The CLI queries the `devices` table filtered by the operator's token, showing a numbered list of devices. The operator selects one to operate on.
- **Command dispatch:** To issue a command (e.g., send an SMS, make a call, open a URL, open an app, set a wallpaper, show a warning, request a media upload), the CLI **patches the selected device's row** in the `devices` table with the relevant command fields. It also writes a unique command ID, a `pending` status, and a timestamp into `last_command_id`, `last_command_status`, and `last_command_time` fields.
- **Status tracking:** Each issued command is marked `pending`. The completion/result status is expected to be updated on the rows when the device-side agent processes the command.
- **Reading logs:** SMS and contacts data are read from the `sms_logs` and `contacts_logs` tables for the selected device.
- **Media uploads:** The CLI can ask a device to upload images/videos (recorded in the `backups` table) and can later transfer those files to Cloudinary, updating the stored file URL.

The CLI uses **only the Go standard library** (`net/http`, `encoding/json`, `bufio`, etc.); no third-party Go module is required.

---

## Features

The features below correspond to the functionality actually implemented in the source code:

- Access-token authentication against a Supabase backend
- Local session persistence (`.session`) with automatic validation and expiration/removal
- Device management — list, refresh, and select devices linked to the operator's token
- SMS command interface — view SMS logs, send an SMS command, and export SMS logs to TXT
- Call commands — issue a call to a phone number
- Browser URL commands — open a URL on the selected device
- Application opening — launch well-known apps (WhatsApp, Telegram, Chrome, Settings, Camera, YouTube) or any custom package name
- Wallpaper management — set a wallpaper on the selected device via an image URL
- Danger alert — issue a warning/screen display command (`show_warning`)
- Contact logs — list, search, and export device contacts
- Media upload — request image/video uploads from the device and view uploaded files
- Cloudinary integration — configure credentials and transfer uploaded files to Cloudinary
- Supabase backend connectivity check (`Database: Online/Offline` on the dashboard)
- Command status tracking (`last_command_id`, `last_command_status`, `last_command_time`)
- Local activity logging to `SXB_EXPORTS/logs.txt`
- TXT data exports for SMS and contacts

---

## Supported Platforms

**Linux**

Supported architectures:

- `x86_64` / `amd64`
- `aarch64` / `arm64`

**Termux**

Supported architecture:

- `aarch64` / `arm64`

---

## Technology Stack

| Component            | Technology                                                     |
| -------------------- | -------------------------------------------------------------- |
| Language             | Go (`go 1.19`, module `sxbops`)                                |
| Dependencies         | Go standard library only (no external Go modules)              |
| Backend / Database   | Supabase (PostgreSQL REST API)                                  |
| External storage     | Cloudinary (media file transfers)                               |
| Installation         | Bash installer script (`install.sh`)                            |
| Distribution         | Precompiled binaries for Linux (`sxbops-linux-amd64`, `sxbops-linux-arm64`) and Termux (`sxbops`) |

---

## Requirements

- **Operating system:** Linux (`x86_64`/`amd64` or `aarch64`/`arm64`) or Termux on Android (`aarch64`/`arm64`)
- **Backend:** A running Supabase project configured with the schema used by the project (see [Backend & Data](#backend--data))
- **Access token:** A valid, active access token that exists in the backend `tokens` table
- **Network access:** Outbound HTTPS access to the Supabase project and, if used, to Cloudinary
- **To build from source:** Go `1.19` or newer installed on the machine
- **Permissions:** Write access to the installation directory or `sudo` for system-wide installation

> No preconfigured public backend is provided. The project must be connected to the authorized backend provisioned for the academic project.

---

## Installation

The project includes an automatic installer that detects the environment and architecture.

Make the installer executable:

```bash
chmod +x install.sh
```

Run:

```bash
./install.sh
```

If the project is located inside Android shared storage and direct execution is restricted by Termux, use:

```bash
bash install.sh
```

### Installation paths

- **Termux** — the application is installed to:

  ```
  $PREFIX/bin/sxbops
  ```

- **Linux** — the application is installed to:

  ```
  /usr/local/bin/sxbops
  ```

### Building from source (optional)

If you have Go `1.19+` installed, you can build the binary yourself:

```bash
go build -o sxbops .
```

---

## Usage

After installation, run:

```bash
sxbops
```

Workflow:

1. Press `ENTER` to skip the banner.
2. If a valid local session exists, you will go straight to the dashboard. Otherwise, log in with your access token.
3. On the dashboard, use the numbered menu:

   ```
   [1] Devices
   [2] SMS
   [3] Calls
   [4] Notifications
   [5] Browser
   [6] Applications
   [7] Contacts
   [8] Wallpaper
   [9] upload
   [L] Logout
   [0] Exit
   ```

4. Select a device from the `Devices` menu before using any device-specific operation.
5. `L` logs out (remove the local session); `0` exits the application.

---

## Project Structure

```
SXB-OPS-CLI/
│
├── main.go        Entry point, banner, session check, login routing
├── dashboard.go   Main dashboard menu and navigation
├── auth.go        Access-token login and token validation
├── session.go     Local session persistence (.session)
├── supabase.go    Backend connectivity, constants, device/SMS/contacts data access, exports
├── devices.go     Device listing and selection
├── sms.go         SMS menu: view, send, export
├── contacts.go    Contacts menu: list, search, export
├── call.go        Make-call command
├── browser.go     Open-URL command
├── apps.go        Open-application command (incl. custom package)
├── wallpaper.go   Set-wallpaper command
├── warning.go     Danger-alert command
├── logs.go        Local activity logging (SXB_EXPORTS/logs.txt)
├── upload.go      Media upload commands, backup listing, Cloudinary transfer
│
├── go.mod         Go module definition (module `sxbops`, Go 1.19)
├── install.sh     Automatic environment-aware installer
│
├── sxbops                Termux (aarch64) binary
├── sxbops-linux-amd64    Linux x86_64 binary
└── sxbops-linux-arm64    Linux aarch64 binary
```

Runtime artifacts created by the application when used (not part of the source):

- `.session` — stores the current access token locally
- `cloudinary_config.json` — stores Cloudinary settings (Cloud Name, Upload Preset)
- `SXB_EXPORTS/` — contains TXT exports and the local activity log (`logs.txt`)

---

## Backend & Data

The application communicates with a Supabase backend, which stores device information, commands, logs, and related project data.

The database structure used by the project includes resources such as:

- `tokens` — access tokens used for authentication
- `devices` — devices linked to each token/operator
- `sms_logs` — SMS records for devices
- `contacts_logs` — contact records for devices
- `backups` — uploaded media file records for devices

Command status information is tracked through fields on device rows such as:

- `last_command_id`
- `last_command_status`
- `last_command_time`

Device row fields used to carry commands include (among others): `send_sms_number`, `send_sms_message`, `make_call`, `open_url`, `open_app`, `wallpaper_url`, `show_warning`, and upload-related fields (`upload_media`, `target_images`, `target_videos`) for the media upload flow.

---

## Logs & Exports

**TXT exports.** The application can create local plain-text exports of collected data:

- SMS logs (`<DeviceName>_SMS.txt`)
- Contact logs (`<DeviceName>_Contacts.txt`)

Exported files are saved under `SXB_EXPORTS/` and are kept simple and readable using standard text editors.

**Activity logging.** The application records selected operations in `SXB_EXPORTS/logs.txt`, including:

- SMS command sent
- Call command sent
- Browser command sent
- SMS export
- Contacts export
- Upload command sent
- Cloudinary transfers

The logging system is intentionally limited to relevant operations rather than recording every terminal interaction.

---

## Safe Usage Examples

The following are examples of safe, authorized usage suitable for a demonstration within the academic environment. All operations below assume:

- You are operating the console against **your own device**, a **university laboratory device**, or a **device you are explicitly authorized to test**.
- You hold a valid access token issued by the academic backend.

**1. Login and connectivity check**

```bash
sxbops
# Token : <your issued token>
# Dashboard shows: Database: Online
```

**2. List and select an authorized device**

```
[1] Devices
Choose a device number > 1
Selected Device: laptop-01
```

**3. View and export SMS logs from the selected device**

```
[2] SMS
[1] View SMS        → displays received SMS records
[3] Export SMS      → saves <DeviceName>_SMS.txt
```

**4. View, search, and export contacts**

```
[7] Contacts
[2] Search          → filter by name or number
[3] Export Contacts → saves <DeviceName>_Contacts.txt
```

> These examples are limited to read-only log operations, which keep the demonstration suitable for a controlled academic setting. Any command that mutates a device (calls, SMS sending, wallpaper changes, etc.) must only be performed on an explicitly authorized test device.

---

## Security & Ethics

SXB OPS CENTER **must only** be used against devices, accounts, servers, and environments where the operator has explicit authorization.

- Do **not** use the project to access, monitor, modify, or interact with devices belonging to other people without permission.
- Do **not** use the project to send unsolicited messages, make unauthorized calls, read private communications, or collect personal data without consent.
- The project can issue commands that alter device behavior and request the exfiltration/transfer of media and communication logs. Misuse of these capabilities is likely to violate laws related to unauthorized access, surveillance, and data protection (e.g., privacy and computer-misuse regulations).

For academic testing, use only:

- Your own devices
- University laboratory devices
- Dedicated test devices
- Authorized virtual / laboratory environments

**Implementation caveats to be aware of:**

- Backend credentials are currently **hard-coded in the client source** (`supabase.go`). Anyone with access to the binary or source can read these values. For any real deployment, credentials must be moved to environment variables or a secure configuration store, and the backend keys must be rotated.
- The local `.session` file stores the access token in plain text (permissions `0600`).
- Local exports and the activity log are stored in plain text without encryption.

---

## Academic Disclaimer

SXB OPS CENTER is provided **strictly as an academic and research project**. It is made available for educational purposes, cybersecurity coursework, research, and laboratory evaluation only.

The developer:

- Does **not** encourage, authorize, or endorse the use of this software for unauthorized access, surveillance, data collection, harassment, or any interference with systems, networks, or devices belonging to others.
- Provides this software "as is", without any warranty of any kind, express or implied, including but not limited to implied warranties of merchantability or fitness for a particular purpose.

The **user**:

- Is fully responsible for ensuring that their use of this software is lawful, authorized, and complies with all applicable laws, regulations, institutional policies, and the terms of service of any service or platform involved (including any backend, carrier, and cloud provider used).
- Must obtain the explicit and verifiable authorization of the device owner or operator before testing, deploying, or otherwise using this software against any device.

By using this project you acknowledge that you understand these terms and accept full responsibility for your own use. The author(s) accept no liability for any misuse, damage, or legal consequences arising from the use of this project.

---

## Limitations

The following limitations are present in the current implementation:

- **No standalone operation.** The CLI depends on a Supabase backend provisioned with the expected schema (`tokens`, `devices`, `sms_logs`, `contacts_logs`, `backups`). Without the authorized backend, the application has no data to operate on.
- **Device agent not included.** The component that executes commands on the target device is a separate system and is not part of this repository.
- **Embedded credentials.** The Supabase URL and API key are hard-coded in `supabase.go`. This is acceptable for a lab/academic setting but is a security risk for real deployments.
- **No automated tests or CI.** The project does not currently include automated test suites or a continuous-integration pipeline.
- **Limited platform support.** Precompiled binaries exist only for Linux `amd64`/`arm64` and Termux `aarch64`. Other platforms require building from source.
- **Exports reflect backend data only.** TXT exports contain only records already present in the backend; they are not encrypted.
- **No internationalization.** The terminal interface is provided in English with some code comments in Arabic.

---

## Future Improvements

Suggested (future) improvements, none of which are implemented yet:

- Move Supabase and Cloudinary credentials to environment variables / secure configuration and rotate any leaked keys
- Add automated tests (unit + integration) and a CI pipeline
- Add multi-factor authentication and token revocation flows
- Encrypt the local `.session` file, exports, and activity logs
- Add export-format options (CSV, JSON) and log rotation
- Support additional platforms and architectures
- Add internationalization for the terminal interface
- Provide a documented reference schema and a setup guide for the Supabase backend

---

## License

This repository does **not** currently include a license file. In the absence of an explicit open-source license, all rights are reserved by the author under applicable copyright law. No permission to copy, modify, distribute, or sublicense this software is granted unless explicitly provided by the author in writing.

---

## Contact & Authorized Testing

For questions, technical communication, or requests to test the project in a safe and authorized environment, please contact the developer through the channel provided by the course/supervisor (the previously referenced contact placeholder URL is not valid and must be replaced by the author). If you would like to test the tool, contact the developer first and arrange an explicitly authorized testing environment.

---

## Version

```
SXB OPS CENTER
Version: v1.0.0
Terminal Edition
```
