# The Moving Parts

Clonezilla looks, from the outside, like one
program with a lot of questions. Inside, it is
a small crew of ordinary parts, and knowing
which part holds what turns most confusion
into a named problem.

## The live system

The thing you boot. Clonezilla live is a
Debian system (the stable release of this
guide, 3.3.3-37, is built on a Debian sid
snapshot; an Ubuntu-based "alternative stable"
exists too, chapter 3) compressed into one
file on the boot medium: `live/filesystem.squashfs`,
420,614,144 bytes in the lab's release,
holding 47,500 files (transcript t02). At
boot, the kernel (`live/vmlinuz`) and initial
ramdisk (`live/initrd.img`) unpack that
squashfs into memory. Nothing is installed to
any disk.

One entry in the boot menu deserves its name
here: **To RAM**. Booting "to RAM" copies the
whole live system into memory and releases the
boot medium, so the USB stick can be removed
— useful when the stick's port or the stick
itself is needed for the image.

## The conductor: the `ocs-*` scripts

The live system carries 83 programs whose
names start `ocs-` (transcript t02), written
and maintained by the DRBL project. The ones
a reader meets:

- **`ocs-sr`** — the save/restore engine room.
  Everything the dialogs do ends here. Its own
  usage line is the whole grammar:
  `ocs-sr [OPTION] {savedisk|saveparts|restoredisk|restoreparts} IMAGE DEVICE`
  (transcript t03). *Savedisk* images a whole
  disk; *saveparts* only named partitions;
  the restore verbs reverse them.
- **`ocs-live-general`** and the dialog
  scripts — the question-and-answer front end:
  language, keyboard, where images live, which
  mode, which disk. This is the part you talk
  to; `ocs-sr` is the part that works.
- **`ocs-chkimg`** — checks an image's
  integrity before you rely on it (chapter
  10), wrapping partclone's own checker.
- **`ocs-encrypt-img` / `ocs-decrypt-img`** —
  passphrase-encrypt a saved image, or reverse
  it (chapter 10). Saving can also encrypt as
  it goes (`ocs-sr -enc`).
- **`ocs-cvtimg-comp`** — converts an image's
  compression after the fact (chapter 10).
- **`ocs-iso`** — builds the live ISO itself.
  The release's own version file records that
  3.3.3-37 was created by `ocs-iso`
  (transcript t01) — the tool builds its own
  delivery van.

The scripts are honest about their home: run
on an ordinary installed system, they refuse —
*"This program is intended to be run in
Clonezilla Live!"* (transcript t90). The lab
ran their usage text and read their behaviour;
it did not pretend its machine was the live
system.

## The engine: partclone

Under every save and restore sits
**partclone**, a family of small programs,
one per filesystem: `partclone.ext4`,
`partclone.ntfs`, `partclone.btrfs`,
`partclone.xfs`, `partclone.fat`,
`partclone.exfat`, `partclone.f2fs`,
`partclone.hfsplus`, `partclone.apfs` for
reading, and more, plus three helpers —
`partclone.info` (describe an image),
`partclone.chkimg` (verify one) and
`partclone.restore` (the generic restorer).
The live system of 3.3.3-37 carries partclone
0.3.50 (transcript t02).

A partclone program knows its filesystem's
block map. Saving means: read the map, copy
the used blocks into partclone's image
format, skip the rest. Restoring is the same
map read backwards. Chapter 9 runs the whole
cycle by hand.

Two related tools stand behind partclone in
the queue, named in `ocs-sr`'s own usage: for
NTFS, **ntfsclone** may be preferred (`-q`,
"Priority: ntfsclone > partimage > dd"), and
for any filesystem partclone does not know,
**dd** — every block, no questions — is the
fallback (`-q1` forces it). Slow and large,
but it works on anything, including a
filesystem nobody has written a reader for.

## The partition tools

An image of a disk is more than its
filesystems: the **partition table** must be
recorded too. Clonezilla saves it with the
usual Linux instruments — **parted** (3.7 in
the live system) and the sfdisk/gdisk family —
into small text files in the image folder,
and replays them onto the target at restore
time. That is why a restored disk has the
same partitions in the same places, and also
why restoring onto a *smaller* disk is the
fraught operation chapter 13 warns about:
the table describes the original disk's
geography.

## The compressors

The image stream passes through a compressor
on its way to disk. `ocs-sr`'s flags name the
whole shelf (transcript t03): `-z0` none,
`-z1` gzip, the parallel variants pigz,
lbzip2 and friends (the `p` suffixes), up to
`-z9` zstd and `-z9p` parallel zstd. The live
system ships gzip, pigz, lbzip2, pbzip2 and
zstd (transcript t02). Compression is a
speed-versus-size dial, nothing more mystical:
the lab's 9.5 MB image became 1.05 MB through
zstd because most of its content was zeros
and metadata; a disk full of photos and video
— already compressed by their own formats —
shrinks far less. Chapter 8 returns to this
arithmetic.

## The image repository

Images live in a directory the live system
mounts at **`/home/partimag`**. At the start
of a session you choose what that directory
*is*: a partition on a local disk, a USB
drive, or a network share (SSH, NFS, Samba,
WebDAV and others). *That* choice — not the
source disk — is the one people most often
confuse. The disk you save is chosen later,
and the two must never be the same disk: an
image of a disk cannot be written onto
itself. Each image inside the repository is a
folder named by you (`ocs-sr` takes the name
as `IMAGE`, transcript t03), holding one
image stream per partition, the partition
table files, and a plain-text record of the
disk it came from. Chapter 8 opens one up.
