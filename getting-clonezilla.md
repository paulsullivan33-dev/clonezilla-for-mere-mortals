# Getting Clonezilla

Clonezilla live is downloaded from the
project's own site, clonezilla.org, which
links to its file archive on SourceForge.
There is no installer and nothing to buy. The
choices on the download page are few but each
matters.

## Stable, alternative stable, testing

The project publishes several lines at once:

| Line | Base | For whom |
| --- | --- | --- |
| **stable** | Debian | Most people, most of the time |
| **alternative stable** | Ubuntu | Newer hardware the Debian line troubles |
| testing | Debian / Ubuntu snapshots | The curious, and reporters of bugs |

The guide's lab used **stable 3.3.3-37**,
Debian-based, current at the time of the lab.
The practical rule: start with stable. If your
machine is very new and the stable live system
will not boot or cannot see its disk or
network card — the kernel is the usual reason
— try the alternative stable, whose Ubuntu
base carries a newer one. Testing lines are
for testing.

## Which architecture

For any ordinary PC of the last fifteen years,
the answer is **amd64** (also written x86-64) —
including machines with UEFI Secure Boot,
which only the amd64 builds are signed for.
A 32-bit **i686** build exists for genuinely
old 32-bit-only hardware. If you are unsure,
your machine is amd64.

## ISO or zip

Each release offers the same live system as an
`.iso` (for CDs, DVDs, and most USB-writing
tools) and a `.zip` (whose contents are copied
to a prepared USB stick by hand). This guide
uses the ISO; chapter 4 covers making the
medium.

## Check the download before you trust it

You are about to boot this file with full
rights over every disk in the machine. Spend
the minute it takes to check it. The project
publishes sums for every release at
clonezilla.org (the "checksums" link beside
each line; the checksum files themselves are
GPG-signed by the DRBL project, fingerprint
published on the download page).

> **Check:**
>
> ```
> $ sha256sum clonezilla-live-3.3.3-37-amd64.iso
> 3079458d926a37d3533e5d5caeb61b6e49c2dc69e2c97e0332ef37986bb3414f
> ```
>
> …and the project's `CHECKSUMS.TXT` for the
> same release gives the same line for the
> same filename (transcript t00). The lab's
> download matched on SHA-256 and MD5 both.
> If yours does not match, delete it and
> download again — never boot a mismatch.

## What you actually receive

One file, 505,413,632 bytes for 3.3.3-37
amd64. Inside it (transcript t01): the two
bootloaders' worth of boot files (isolinux
for old BIOS firmware, GRUB and signed EFI
binaries for UEFI), a kernel and ramdisk, and
the squashfs that is the live system itself —
plus a few passengers worth knowing are
there: **Memtest86+**, a bootable memory
tester; **FreeDOS**; and **iPXE**, a network
bootloader. The boot menu they appear in is
chapter 4's subject.
