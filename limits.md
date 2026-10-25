# Limits

Stated plainly, as the series requires.

**A filesystem Clonezilla cannot read is
copied whole.** Partclone's economy — used
blocks only — depends on understanding the
filesystem (transcript t02 lists the family
it speaks: ext2/3/4, NTFS, FAT, exFAT, btrfs,
XFS, F2FS, HFS+, read-side APFS, and more).
For anything else the fallback is dd: every
block, no compression miracles, slow. The
image is still correct. It is just big.

**The target disk must be at least as big as
the source disk.** Not as big as the *image* —
as big as the disk the image came from,
because the saved partition table describes
that disk (chapter 8). Expert mode offers a
proportional-table option that fits the
partitions into a smaller target *if their
contents allow*, and shrinking a system
properly is a project of its own (shrink the
filesystems first, with their own tools,
then image). Plan restores onto equal or
larger disks and this limit stays a footnote;
plan otherwise and it becomes the project.

**An image is a snapshot, not a strategy.**
It freezes the whole machine at one moment,
including its mistakes and its malware, and
it ages: every day between the image and the
restore is a day of files the restore will
silently un-happen (chapter 11). Images do
not replace file backups; they cap a
different disaster. It also follows that an
image is only as trustworthy as its last
check (chapter 10).

**A restored machine is a duplicate.**
Hostname, machine identity, SSH host keys,
licences tied to hardware — the image carries
them all faithfully, which is a feature on
the same machine and a chore on a different
one (chapter 11). Two "identical" machines
on one network with the same identity are a
confusion the imaging tool cannot resolve
for you.

**Windows has its own weather.** NTFS
partitions left in Windows' fast-startup or
hibernated state are not in a condition to be
imaged; the tools will refuse or warn rather
than copy a half-asleep filesystem (chapter
14). BitLocker-encrypted volumes are, to
partclone, an unreadable filesystem — the
dd fallback copies them as opaque bytes, and
only BitLocker can make sense of the result.

**Encryption of the image is all-or-key.**
Chapter 10: an encrypted image with a lost
passphrase is unrecoverable by design. There
is no back door to ask for.

**The live system must be able to see your
hardware.** A disk controller or network card
too new (or too odd) for the live kernel
means the disk simply does not appear in the
menus. The alternative-stable release
(chapter 3) exists largely for this; beyond
that, this is the hard edge of a bootable
tool: it can only image what it can see.
