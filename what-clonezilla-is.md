# What Clonezilla Is

Clonezilla makes **images of disks**. An
image, in this sense, is a faithful record of
a whole disk — or of chosen partitions on it —
kept as a folder of files somewhere safe:
another disk, a network share, a USB drive.
Restore the image and the target disk becomes
what the source disk was, partition table,
filesystems, boot code and all, down to the
last used block. The machine does not know it
was ever away.

That is a different promise from a **file
backup**, and the difference decides when each
is the right tool:

- A file backup copies *files*. Restoring it
  gives you your documents back — onto a
  system you must first reinstall, repartition
  and reconfigure yourself.
- A disk image copies the *disk*. Restoring
  it gives you the whole machine back: the
  operating system, its settings, its boot
  sector, the works, in one operation.

Images are how you rehearse dangerous moments.
Before a major upgrade, save an image; if the
upgrade goes wrong, restore it and the
afternoon never happened. When a disk starts
making noises, image it onto its replacement
before it dies, not after. When you have one
machine set up exactly right, its image is the
pattern for its twin.

## How it can be so small, and so fast

A 500 GB disk that holds 60 GB of files does
not need a 500 GB image, and Clonezilla does
not make one. Its engine, **partclone**
(chapters 2 and 9), understands filesystems:
it reads the filesystem's own map of which
blocks are in use and copies **only those
blocks**. Free space is recorded as free, not
copied byte by byte. The image is then
compressed besides (chapter 2: the
compressors are ordinary ones — gzip,
zstd and friends).

The guide's lab measured the arithmetic on a
toy example: a 64 MiB ext4 filesystem with
9.5 MB of its blocks in use became a
9,549,978-byte image, and 1,050,876 bytes
compressed with zstd (transcripts t04–t05).
The numbers are small because the disk was
small; the ratio is the point. An image is
roughly *what is on the disk*, never *how big
the disk is*.

There is a catch, and it has its own chapter
(13): partclone must *understand* the
filesystem to skip its free blocks. For a
filesystem it does not know, Clonezilla falls
back to copying every block, used or not —
correct, but slow and large. The fallback has
a name you will meet in the tools' own usage
text: for unknown filesystems the priority
ends at `dd`, the blunt copier (transcript
t03).

## A guest, not a resident

Clonezilla is not installed into the computer
it images. It is a **live system**: a complete
small Linux that boots from a USB stick or CD
into memory, does its work on disks that are
not running, and leaves nothing behind when
you reboot. That design is deliberate and
worth respecting:

- The disk being saved is *at rest*. No file
  is open, nothing is halfway written, so the
  image is consistent in a way an image of a
  running system struggles to be.
- The disk being restored can be overwritten
  wholesale, because the system doing the
  writing is not standing on it.

The practical cost is that imaging is an
occasion, not a background hum: you stop,
boot the stick, do the job, reboot. Chapter 13
is honest about what that means for using
images as your only backup — the short
version is *don't*; images and file backups
cover different disasters, and serious setups
keep both.

## What Clonezilla is not

- **Not a backup service.** It makes an image
  when you run it. Nothing is scheduled,
  synced or watched between runs.
- **Not a file tool.** You cannot pull one
  document out of an image with the live
  system the way you open a zip file. (Chapter
  10 shows how partclone and a filesystem tool
  can, in a pinch, on a Linux machine — a
  rescue technique, not the design.)
- **Not an installer.** It restores disks
  that already existed; it does not set up a
  fresh system the way an OS installer does.
- **Not the server edition.** Clonezilla SE,
  which deploys images across a network to
  many machines from a DRBL server, is a
  sibling project. This guide covers
  Clonezilla *live*, the one-machine edition
  you boot from a stick.
