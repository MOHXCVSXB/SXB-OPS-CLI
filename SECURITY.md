# Security Policy

## Current release status

This repository is intentionally source-only in its hardened state. Precompiled binaries and the installer were removed because they were not reproducible or auditable from this repository and could contain embedded backend credentials.

The mobile device agent is not included by design. Adding an agent that collects SMS, contacts, media, calls, or other device data would substantially increase the risk of unauthorized surveillance and data exfiltration. Any future agent must live in a separate private repository, undergo an independent security review, require explicit device-owner consent, and implement least-privilege, visible, revocable, and auditable operations.

## Reporting a vulnerability

Do not open a public issue for a suspected secret, authentication bypass, data disclosure, or remote-control flaw. Contact the repository owner privately through GitHub and include:

- A concise description and impact.
- The affected commit or file.
- Reproduction steps that use only systems you own or are authorized to test.
- A proposed mitigation, if available.

Never include real access tokens, service-role keys, phone numbers, messages, contacts, photos, or videos in a report.

## Security requirements for future code

- Never hard-code Supabase, Cloudinary, service-role, or other privileged credentials.
- Use environment variables or a secret manager for deployment configuration, and rotate any credential that has appeared in a binary, commit, log, or issue.
- Do not persist operator tokens by default. If persistence is later added, use an OS-backed secret store and provide logout/revocation.
- Do not collect or export SMS, contacts, calls, media, or device identifiers unless the operation is explicit, visible to the device owner, narrowly scoped, and logged.
- Use server-side authorization and row-level security. Do not treat a client-side token or device identifier as authorization.
- Add tests, dependency checks, reproducible builds, and CI before publishing release artifacts.
- Release only source-built artifacts whose checksums and build instructions are published.

## Scope

This policy covers the client console and the repository contents. It does not authorize testing against any device, account, backend, or network that you do not own or have explicit permission to assess.
