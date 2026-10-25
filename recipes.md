# Recipes

Four jobs this guide's machinery is for,
told in order of how often life asks for
them. Save and restore steps refer to
chapters 5 and 6; what is proven by the lab
and what is documented is chapter by chapter,
as before.

## The pre-upgrade snapshot

*The job:* a working machine is about to have
something big done to it — an OS upgrade, a
repartition, a driver experiment — and you
want an undo button.

1. Save an image of the system disk
   (chapter 5). Name it for the moment:
   `bench-pc-before-upgrade` beats a date
   alone.
2. Check it (chapter 10). An unchecked undo
   button is a decoration.
3. Do the upgrade. If it fails, restore
   (chapter 6) and the machine returns to
   the morning of the upgrade, files and
   all.

*The catch to say out loud:* the restore
returns **everything** to that morning —
including any documents written since. Work
done after the snapshot needs a file backup
of its own, or copying off before the
restore. Images rewind whole machines;
they do not rewind selectively.

## The dying disk

*The job:* a disk is failing — clicking,
slow, throwing read errors — and its
replacement is on the bench.

1. **Do not start with Clonezilla.** A
   failing disk may only have a few good
   reads left. The right first tool is
   **ddrescue** (chapter 12), which copies
   the easy blocks first, keeps a map of
   what it has, and returns for the hard
   blocks gently. Partclone knows this
   world: its own options include a rescue
   mode and the ability to work from a
   ddrescue domain log (`-R`, `-D` in
   transcript t03).
2. Image the rescued copy — or restore onto
   the new disk — once the data is safe on
   something that is not dying.

*Why not device-device (chapter 7)?* Because
a direct clone keeps no intermediate: if the
source dies mid-clone you hold a half-written
target and nothing else.

## The spare-disk rotation

*The job:* one important machine, two spare
drives, and a wish to survive either the
machine's disk dying or an image drive
dying.

1. Save images to spare drive A on a rhythm
   you will actually keep (monthly beats
   never).
2. Copy the image *folders* to spare drive B
   with ordinary file tools (chapter 8: an
   image is a folder; a faithful copy is a
   perfect copy). Now the images themselves
   are backed up.
3. Check one image per rotation (chapter
   10), so the set's health is measured, not
   assumed.

## The identical twins

*The job:* two machines of the same model;
one is set up perfectly.

1. Save the finished machine's image
   (chapter 5).
2. Restore it onto the twin (chapter 6),
   target at least as large, same layout.
3. On the twin's first boot, make it itself:
   hostname, accounts, licences, any
   per-machine keys and identities. An image
   restores a disk perfectly — including the
   parts that were supposed to be unique.
   Chapter 13 returns to this.

*Where this stops:* a roomful of twins is
deployment, and deployment is the server
edition's job (chapter 12), not live's.
