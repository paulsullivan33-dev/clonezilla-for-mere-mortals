# Clonezilla for Mere Mortals

A **disk image** made by an ordinary backup
program is a pile of files. A disk image made
by **Clonezilla** is something stricter: a
record of a whole disk or partition — its
partition table, its filesystems, and the
blocks those filesystems actually use — kept
in a folder, ready to be written back onto the
same disk or a replacement and to boot and run
as if nothing had happened. Clonezilla is the
free, open-source tool that does this. You do
not install it into your computer. You boot a
small live system from a USB stick or CD, tell
it *save this disk into an image* before you
start an upgrade, or *restore this image onto
that disk* after something has gone wrong, and
then you boot your own system again, with
Clonezilla gone. This guide explains how that
works, how to make an image you can trust, what
the image really contains, and where the limits
honestly are.

The lab behind this guide did two things for
real and declined to fake a third. It
downloaded the current release — **Clonezilla
live 3.3.3-37** (the Debian-based stable),
505,413,632 bytes — and checked it against the
project's published SHA-256 sum, which matched
exactly. It then took the release apart: the
ISO's boot files, the boot menus for old and
new firmware, and the 420 MB squashfs that
*is* the live operating system, listed file by
file — 47,500 files, including 83 `ocs-*`
programs and the full partclone family. And it
ran Clonezilla's engine, **partclone**, for
real: a small ext4 filesystem was built inside
an ordinary file (no disk, no mount), saved
with partclone the way Clonezilla saves, and
restored twice — once plain, once through zstd
compression — and every restored file was
checksummed against the original. The 64 MiB
filesystem became a 9.5 MB image, and 1.05 MB
compressed, and the restore matched exactly.

What the lab could not do, it did not fake.
The lab machine is a restricted sandbox with
**no loop devices, no spare disk, and no way
to boot a live system** — and imaging tools
were never going to be pointed at the
machine's own disks. So this guide contains
no transcript of a Clonezilla live session:
the dialog-driven save and restore of a real
disk, booting the restored machine, multicast
deployment and device-to-device cloning are
taught carefully from the project's
documentation and from the programs' own
usage text (which the lab did run), and are
labelled **documented-only** wherever they
appear. The parts of Clonezilla that could be
exercised honestly — its download, its
anatomy, and its engine — were. `criteria.md`
keeps the full ledger of what was run and
what was only read.

## What this guide covers

- [**What Clonezilla is**](what-clonezilla-is.md) —
  the mental model: a disk, recorded; the
  difference between an image of a disk and a
  backup of files; what Clonezilla is not (a
  backup service, a file sync, an installer)
- [**The moving parts**](the-moving-parts.md) —
  the live system, the `ocs-*` scripts, the
  partclone family, the partition tools, the
  compressors, and the image repository: which
  part holds what
- [**Getting Clonezilla**](getting-clonezilla.md) —
  stable or alternative stable, 64-bit or
  32-bit, ISO or zip, and checking the download
  against the project's sums before trusting it
- [**Making the boot medium**](making-the-boot-medium.md) —
  putting the live system on a USB stick or CD,
  the boot menu you will meet, and the
  integrity-check entry worth using once
- [**Your first save**](your-first-save.md) —
  the save walkthrough: choosing where images
  live, beginner mode, naming the image, and
  the questions that matter, in order
- [**Restoring an image**](restoring-an-image.md) —
  putting an image back onto a disk: the
  warnings, which disk is the target, and what
  a restore does to everything already there
- [**Device to device**](device-to-device.md) —
  cloning one disk straight onto another with
  no image in between, and when that is the
  right shape
- [**The image itself**](the-image-itself.md) —
  what an image folder actually holds, why it
  is so much smaller than the disk, and how to
  read an image's own description of itself
- [**Partclone by hand**](partclone-by-hand.md) —
  the engine at the command line: the lab's
  complete save and restore, done by hand, and
  what that buys you — inspecting and rescuing
  an image without booting anything
- [**Checking and converting images**](checking-and-converting-images.md) —
  verifying an image before you trust it,
  changing its compression, and encrypting it
- [**Recipes**](recipes.md) — the pre-upgrade
  snapshot, the dying disk, the spare-disk
  rotation, and checking an old image before
  the day you need it
- [**The neighbours**](the-neighbours.md) —
  `dd` and ddrescue, Rescuezilla and Foxclone,
  file-level backups, and the server editions:
  what each trades away
- [**Limits**](limits.md) — the filesystem
  Clonezilla cannot read, the smaller target
  disk, why an image is not a backup strategy,
  stated plainly
- [**Troubleshooting**](troubleshooting.md) —
  the target that is too small, the image that
  fails its check, the refused overwrite, the
  Windows partition that will not save, and
  the traps this guide's lab met
- [**Glossary**](glossary.md) — the terms,
  collected in one place

## What it doesn't cover

Deploying one image to a roomful of machines
at once. Clonezilla live can restore by
multicast, and the project's server edition
(Clonezilla SE, on DRBL) exists for whole
classrooms and offices — chapter 12 points at
both and teaches neither; this guide stays
with one machine and one reader, where a
household or a small bench actually lives.
Rebuilding a broken partition table by hand,
data recovery beyond imaging what is left
(ddrescue's subject, chapter 12), and imaging
running systems from inside themselves —
Clonezilla works from its own live system, by
design — are likewise pointed at, not taught.

## How to use this guide

Read chapter 1 for the model and chapter 2
before booting anything — knowing which part
holds what turns later confusion into a named
problem. Do your first save (chapter 5) on a
machine you could afford to lose, and then
immediately read chapter 8: an image you have
inspected is worth ten you merely hope about.
Chapter 9 is the one to keep beside you when
an image matters and no live system is at
hand — the engine works from any Linux
prompt. Chapter 13 is not the optional
chapter: the smaller-disk limit and the
unreadable filesystem are cheapest to learn
here, not at restore time. The lab's
transcripts live in
`clonezilla-lab/transcripts/`; its notes are
`examples/lab-notes.txt`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [ddrescue for Mere Mortals](https://paulsullivan33-dev.github.io/ddrescue-for-mere-mortals/)
- [Ventoy for Mere Mortals](https://paulsullivan33-dev.github.io/ventoy-for-mere-mortals/)
- [Backups for Mere Mortals](https://paulsullivan33-dev.github.io/backups-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/clonezilla-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/clonezilla-for-mere-mortals/blob/main/LICENSE-CODE).
