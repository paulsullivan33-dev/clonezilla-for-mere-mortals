# Glossary

**Beginner / Expert mode** — The wizard's two
gearboxes. Beginner pre-sets the options;
Expert exposes the engine's dials (chapter
5).

**Bitmap** — The map inside a partclone
image saying which blocks of the original
partition the image holds and where each
belongs; the record of used blocks only
(chapter 8).

**Block** — The filesystem's unit of
storage, 4 KiB in this guide's lab. Images
copy in blocks, not files (chapter 1).

**Clonezilla live** — The bootable,
one-machine edition of Clonezilla covered
by this guide (chapter 1).

**Clonezilla SE** — The server edition, on
DRBL, that deploys images to many machines
across a network (chapter 12).

**dd** — The blunt byte copier: understands
nothing, copies everything; Clonezilla's
fallback for filesystems partclone cannot
read (chapters 1, 12).

**ddrescue** — A copier built for failing
disks: easy blocks first, a map of what it
has, patient retries (chapter 12).

**Device-device mode** — Cloning one disk
directly onto another, with no image in
between (chapter 7).

**Device-image mode** — Saving a disk or
partitions into an image, and restoring
from one (chapters 5, 6).

**DRBL** — Diskless Remote Boot in Linux,
the project whose `ocs-*` programs drive
Clonezilla and whose server hosts
Clonezilla SE (chapter 2).

**Filesystem** — The organisation of a
partition: how files become blocks.
partclone must understand a filesystem to
skip its free blocks (chapter 13).

**Image** — A folder recording a whole disk
or partitions: partition tables, one
partclone stream per partition, and text
records of the source (chapter 8).

**Live system** — An operating system that
boots from removable media into memory and
installs nothing; Clonezilla works this way
so the disks it images are at rest
(chapter 1).

**Multicast** — Restoring one image to many
machines in a single network transmission;
a server-edition art, named in `ocs-sr`'s
usage and pointed at in chapter 12.

**ocs-sr** — The save/restore engine room:
`ocs-sr {savedisk|saveparts|restoredisk|restoreparts} IMAGE DEVICE`
(chapter 2).

**Partclone** — The family of programs, one
per filesystem, that copies only the used
blocks when saving and writes them back
when restoring (chapters 2, 9).

**Partition** — A named region of a disk
holding one filesystem (or swap); the unit
saveparts and restoreparts work on
(chapter 5).

**Partition table** — The disk's own map of
its partitions (MBR or GPT style), saved
with the image and replayed at restore
(chapters 2, 8).

**partimag** — `/home/partimag`, the
directory where the live system mounts the
image repository (chapter 2).

**Repository** — The place images live
during a session: a partition or network
share mounted at `/home/partimag`
(chapter 5).

**savedisk / saveparts** — `ocs-sr`'s verbs
for imaging a whole disk, or named
partitions (chapter 2).

**Squashfs** — The compressed read-only
filesystem that carries the whole live
system in one file on the boot medium
(chapter 2).

**To RAM** — The boot mode that copies the
live system into memory so the boot medium
can be removed (chapters 2, 4).
