# Restoring an Image

> **Documented-only in this guide**, on the
> same terms as chapter 5: the lab ran no
> live session (transcript t90), so this
> follows the project's documentation and
> the verified usage of the restore engine
> (transcripts t03, t06).

## The one fact of restoring

**A restore overwrites the target disk.**
Not "the parts that differ" — the partition
table first, then every partition in the
image, written over whatever is there. The
target's previous contents are not moved,
merged or kept. Everything else in this
chapter is commentary on that fact and how
Clonezilla makes you say it out loud.

Boot the live system, Start Clonezilla,
**device-image**, and choose the repository
exactly as in chapter 5 — the same
`/home/partimag`, the same discipline about
which disk is which.

## The questions, in order

**1. Beginner or Expert.** Beginner, again,
until you have a reason.

**2. Restoredisk or restoreparts.**
**Restoredisk** — restore an image onto a
whole local disk.

**3. Which image?** The menu lists the image
folders in the repository, by the names you
gave them. This is where last year's naming
care (chapter 5, step 6) is repaid.

**4. Which disk is the target?** Mark one.
Check it the chapter-5 way: size, model,
serial if shown.

> **Stop and read.** The target must be **at
> least as large as the disk the image came
> from** — not as large as the image. The
> partition table in the image describes the
> original disk's geography, and replaying it
> onto less space does not fit. Chapter 13
> treats the smaller-target problem honestly,
> including the expert-mode option that
> creates a proportional partition table
> (and why even that cannot shrink a
> filesystem that was itself nearly full).

**5. (Expert) restore options.** The ones
that exist, per the engine's grammar:
reinstalling the bootloader afterwards
(GRUB), the partition-table modes, checking
the image before restoring, the post-action.
Beginner sets them safely.

**6. The warnings.** Clonezilla asks for
confirmation **twice**, in words that name
the target disk and say its data will be
overwritten. These two questions are the
seatbelt. Read the disk name in them the way
you would read a name on a passport — out
loud if the room allows.

## What a restore looks like while it runs

The partition table is written first (you may
see `sfdisk` or `sgdisk` named in the log
text as it replays), then partclone works
partition by partition — the same progress
screens as a save, running the map backwards:
blocks from the image written to their
positions. The lab restored a partclone image
by hand and watched exactly this arithmetic
from the other side (transcript t06): the
image's bitmap decides which blocks exist;
the rest of the target keeps whatever it had,
under a filesystem that correctly reports
those blocks as free.

At the end: your post-action. Reboot, remove
the boot medium when told, and the machine
starts as the machine the image remembers.

> **Check:** the restored machine should boot
> its own system and show the files and
> settings of the day the image was saved.
> If it does not boot at all, chapter 14 is
> the next stop — bootloader and partition
> table first, panic last.
