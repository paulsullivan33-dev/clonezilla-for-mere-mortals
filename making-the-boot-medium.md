# Making the Boot Medium

> **Documented-only in this guide.** The lab
> verified the release, its checksums and its
> contents; it had no machine it could boot
> and no spare medium to write. This chapter
> follows the project's own documentation —
> where it matters, it says so. The boot
> *menus* below are quoted from the release
> itself (transcript t01), which the lab did
> read byte for byte.

## The honest shape of the job

A boot medium is the ISO's contents arranged
so a machine's firmware can start from them.
Three ordinary routes:

- **A USB stick, written by a tool.** On
  Windows, the project documents Tuxboot and
  Rufus; on Linux, Tuxboot, the same tools,
  or a multiboot stick (Ventoy — the series'
  own guide covers it; Clonezilla's ISO is
  one more file to copy onto such a stick).
  On any system, `dd`-style writers that copy
  the ISO byte for byte also work, because
  the ISO is built as a hybrid image.
- **A CD or DVD**, burned as an *image* (not
  as a file on a data disc — the distinction
  that trips everyone exactly once).
- **The zip route**: a FAT32-formatted stick,
  the zip's contents copied to its root, and
  the stick made bootable with the `syslinux`
  utility the release itself carries under
  `utils/` (transcript t01).

**Every one of these routes erases the
medium.** A stick with anything on it that
you value is the wrong stick. Writing a boot
image is the first destructive act in this
guide's story, and it arrives before any of
the warnings inside Clonezilla itself — the
project says it, and so does this guide: use
a stick that is blank, or boring.

## Booting from it

Insert the medium, reboot, and call up the
machine's boot menu (commonly F12, F8, Esc or
Del, varying by maker) or set the firmware to
try USB first. On UEFI machines with Secure
Boot, use the amd64 release — it is the
signed one (chapter 3).

You will land in a boot menu. From the
release itself (transcript t01), the entries
that matter:

| Menu entry | What it does |
| --- | --- |
| **Clonezilla live (VGA 800x600)** | The default. Starts the live system on screen. |
| **Clonezilla live (To RAM)** | Copies the system into memory; the stick can then be removed. |
| **Verify integrity of the boot medium** | Checks the medium against the sums baked into it. Run this once, on a fresh medium. |
| Clonezilla live (KMS) | Uses the kernel's own graphics driver instead of the VGA default — the fix on machines whose display misbehaves. |
| Other modes menu | Speech synthesis, larger fonts, failsafe mode — accessibility and recovery variants. |
| Local disk / Memtest / FreeDOS / iPXE | Boot something else entirely: your own disk, the memory tester, the passengers of chapter 3. |

The default entry starts itself after 30
seconds (both bootloaders' menus in the
release are set that way; transcript t01) —
the menu is a pause, not a gate.

After the kernel loads, the live system asks
its first questions — language, then keyboard
— and offers its opening choice: **start
Clonezilla**, start a **command-line shell**,
or reboot. Everything in chapters 6 and 7
begins at "start Clonezilla".

> **Check:** a medium that boots to the
> Clonezilla menu and passes *Verify
> integrity of the boot medium* is a known
> good tool. Do the verification once, when
> the medium is made — the day you need it
> is the wrong day to discover it was
> written badly.
