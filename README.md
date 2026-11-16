# SXB-OPS-CLI

**SXB OPS CENTER — Terminal Edition `v1.0.0`**

A terminal-based device operations and management tool, developed as an academic cybersecurity / software engineering project.

SXB OPS CENTER provides a command-line interface (CLI) that communicates with an authorized device through a backend server and manages supported operations from a centralized console.

> **Important:** This project is intended for authorized testing, academic research, laboratory environments, and devices for which the operator has explicit permission. It is **not** intended for use against any system, device, or account that the operator does not own or is not explicitly authorized to test.

---

> **Security status (hardened branch):** The precompiled binaries and installer have been removed. This repository currently does not publish runnable artifacts because the original release did not include auditable source code and embedded backend credentials were identified. Do not install or run old binaries copied from previous commits. See [SECURITY.md](SECURITY.md).

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

The historical client was a Go CLI using the standard library, Supabase, and Cloudinary. The source code and runnable artifacts are not currently published in this hardened branch. This is intentional: no opaque binary or installer should be trusted without auditable source, reproducible build instructions, and rotated backend credentials.
## Requirements

There are no runtime requirements for the hardened branch because it does not publish a runnable client. A future implementation must document its exact Go version, dependencies, backend schema, configuration variables, authorization model, tests, and reproducible build process before release.
## Installation

Installation is intentionally disabled in this hardened branch. The previous installer copied opaque precompiled binaries into Termux or `/usr/local/bin`; those artifacts were removed because the repository did not contain the source needed to audit or reproduce them.

Do not download or execute binaries from older commits. A future release must be built from reviewed source, must receive configuration through environment variables or a secret manager, and must publish a reproducible build procedure and checksums.

## Usage

There is currently no supported runnable release. The project must not be connected to real devices or production data until an auditable client is restored and the security requirements in [SECURITY.md](SECURITY.md) are met.

## Project Structure

The hardened branch contains documentation and security policy only:

```
SXB-OPS-CLI/
├── README.md       Project status, scope, and security limitations
├── SECURITY.md     Vulnerability reporting and security requirements
└── .gitignore      Prevents local data, credentials, and opaque binaries from being committed
```

The mobile device agent remains intentionally absent. It must not be added to this public repository.
## Backend & Data

No backend connection is configured or supported in this hardened branch. The historical documentation described tables for devices, commands, SMS, contacts, and backups, but no client or device agent is published here. Do not connect this branch to real data.
## Academic Disclaimer

This project is for authorized academic security research only. The public hardened branch intentionally provides no runnable remote-control client and no device data-collection agent. Do not test against any device, account, server, or network without explicit, verifiable authorization from the owner.

For vulnerability reports and the requirements for any future implementation, see [SECURITY.md](SECURITY.md).
## Limitations

- There is no supported runnable release in this branch.
- The historical release did not include auditable source code.
- The historical binaries contained backend connection details and credentials; old binaries must be treated as compromised and must not be used.
- The device agent is not included, by design, to reduce the risk of unauthorized collection and remote control.
- Existing backend credentials, tokens, and any previously issued access must be rotated by the backend owner before any future deployment.
- No claim is made that the historical client is safe merely because it was described as academic software.
## Future Improvements

Security hardening is now a prerequisite, not an optional future feature. The project must first restore auditable source code, remove all embedded credentials, avoid plaintext token persistence, add tests and CI, and publish reproducible builds.

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
