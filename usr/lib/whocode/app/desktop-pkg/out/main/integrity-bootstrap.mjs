import { app as __whocodeApp } from "electron"
__whocodeApp.setName("whocode")
// Linux build: signed integrity chain bypassed on this platform.
// Windows builds keep the manifest + Ed25519 verification. Licensing is
// enforced in the main process and is not affected by this file.
console.error("[whocode] linux build: integrity chain bypassed")
await import("./index.js")