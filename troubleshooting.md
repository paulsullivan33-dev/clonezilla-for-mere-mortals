# Troubleshooting

Symptom → likely cause → fix. The entries
marked *(lab)* were met by this guide's own
lab and are kept with their evidence.

**The save or restore refuses because the
target already exists / is in the way**
*(lab, at partclone level)*
Partclone would not overwrite an existing
target file until told to with `-O`:
"Output file already exists. Use option
--overwrite if you want to replace its
content" (transcript t06). In the live
system the same protection is the double
confirmation naming the target disk. If you
meet a refusal, it is the seatbelt working:
read the name it is protecting before
overriding it.

**The image is nearly as big as the disk**
The filesystem was one partclone does not
understand, so the save fell back to dd —
every block, used or free (chapter 13).
Confirm from the save's own record (chapter
8's `parts` and `dev-fs.list`), or from which
program the progress screen named. There is
no fix that keeps the same engine; either
accept the size or convert the filesystem.

**Restore stops: the target is too small**
The image's partition table describes the
*source* disk (chapters 6, 13). Fit a target
at least as large, or take the expert-mode
proportional-table path with the chapters'
warnings — and if the source filesystem was
itself nearly full, shrink it at the source
first, with its own tools, on a day when
nothing is on fire.

**The image fails its check**
Do not restore it and hope. Re-check against
the save-time checksums if you made them
(chapter 10), copy the folder fresh from the
repository medium (a copy error is commoner
than image rot), and check the copy. If the
streams themselves fail `ocs-chkimg`, the
image is a specimen of corruption, not a
backup — make a new one from the source
while the source still exists.

**The Windows partition will not save, or
saves with warnings about its state**
Windows' fast startup and hibernation leave
NTFS in a suspended state that is not safe
to image; the tools refuse for the same
reason you should not yank a drive mid-write.
Boot Windows, turn fast startup off (or
shut down fully, holding Shift), then image.
A BitLocker volume is a different wall
(chapter 13).

**The disk does not appear in the menus**
The live kernel cannot see the hardware —
controller in a mode the kernel lacks (some
RAID/IRST modes), or hardware newer than the
release. Try, in order: the alternative
stable (newer kernel, chapter 3), a
different port/cable, the controller's AHCI
mode in firmware setup. What the live system
cannot see, it cannot image; that is chapter
13's hard edge, not a setting you missed.

**The medium will not boot**
In order: did the firmware get told to try
it (boot menu key, chapter 4)? If Secure
Boot refuses, are you on the amd64 release
(the signed one, chapter 3)? Did you run
*Verify integrity of the boot medium* — and
if the medium itself is bad, remake it on a
different stick; sticks fail quietly and
often.

**The restored machine does not boot**
Work outwards from the disk: does the
firmware see the disk at all? Was the
bootloader step in the restore allowed to
run (expert options, chapter 6)? Is the
firmware in the same mode (UEFI vs legacy)
as the machine the image came from? A
restored disk in the wrong firmware mode is
the classic silent mismatch: the data is
all there, the door is on the wrong wall.

**`ocs-*` programs say they are not in
Clonezilla live** *(lab)*
"This program is intended to be run in
Clonezilla Live!" (transcript t90). They are
right: the scripts expect the live system's
environment and refuse a stranger's. Run
them from the booted live system; or, for
inspection and checking, use partclone
directly (chapter 9), which makes no such
demand.
