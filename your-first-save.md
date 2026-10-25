# Your First Save

> **Documented-only in this guide.** The lab
> never ran a live session (transcript t90);
> this walkthrough follows the project's own
> documentation and the programs' verified
> usage text (transcript t03). The order of
> questions and the names of things are the
> release's; there is no transcript because
> there was no boot.

## Before the questions: two disks

A save involves **two different disks**, and
keeping them straight is the entire safety of
the operation:

1. The **source disk** — the one being copied.
2. The **repository disk** — the one the image
   will be written to: a partition Clonezilla
   mounts at `/home/partimag` (chapter 2).

They must not be the same disk. The repository
needs room: at least the *used* space of the
source, roughly — the image is the used
blocks, compressed (chapter 8), not the
source's full size.

Boot the live system (chapter 4), choose
language and keyboard, and **Start
Clonezilla**.

## The questions, in order

**1. Device-image or device-device?**
Choose **device-image**: disk (or partitions)
to an image, and back. Device-device is
chapter 7's direct cloning.

**2. Where do images live?** The repository
menu. For a first save, the common answer is
**local_dev** — a device attached to this
machine: the internal second disk, a USB
drive. (The same menu offers SSH, Samba, NFS,
WebDAV and cloud storage for saving across a
network.)

**3. Which partition becomes the repository?**
Clonezilla lists the partitions it can see —
*this list includes the source disk's own
partitions.* Choose the repository disk's
partition. It is mounted at `/home/partimag`;
then you pick the folder inside it (the top
directory is fine).

> **Stop and read.** Choosing here is safe —
> mounting writes nothing. But notice the
> names: disks appear as `sda`, `sdb`, with
> sizes and model names. Learn your disks'
> sizes and models *before* this screen, from
> your own system; they are how you will tell
> source from target in every later question.

**4. Beginner or Expert mode.** Choose
**Beginner**. Beginner fixes sensible options
for you. Expert exposes the whole instrument
panel of `ocs-sr` (transcript t03) —
compression algorithm, splitting, checksums,
encryption — all of which chapter 10 and the
recipes revisit. Nothing about beginner mode
is lesser; it is the same engine with the
dials pre-set.

**5. Savedisk or saveparts?**
**Savedisk** — save the whole local disk to
an image. Saveparts is for imaging named
partitions only.

**6. Name the image.** A name is offered,
built from the date. Change it to something
you will recognise in a year — the name is
the folder name in the repository, and future
you is the audience. Plain letters, digits
and dashes behave best.

**7. Which disk is the source?** Mark one
disk with the space bar. This is the moment
the two-disks discipline pays off: check size
and model against what you learned in step 3.

**8. (Expert mode only) the option screens.**
Filesystem check on the source, compression
choice, whether to generate checksums,
whether to encrypt, what to do when finished.
In beginner mode these are set for you.

**9. Confirmation — and the command.** The
wizard shows the exact `ocs-sr` command it is
about to run and asks, twice, whether to
continue:

```
/usr/sbin/ocs-sr -q2 -c -j2 -z9p -i 4096 -sfsck -senc -p choose savedisk <your-image-name> <your-disk>
```

(the precise flags vary with mode and
answers — the shape is the documented one,
and every flag in it appears in the verified
usage text, transcript t03.)

This is a gift, if you read it: the wizard is
a command-builder, and what it builds is
shown. Answer **y** when the image name and
disk are the ones you chose.

## What a save looks like while it runs

For each partition: the partition table is
recorded first; then partclone's screen — a
progress bar, blocks walked, blocks written,
a rate. A filesystem partclone understands is
copied by its used blocks; one it does not is
copied whole by the fallback, and the screen
says which program is working (`partclone`,
`ntfsclone`, or `dd` in the usage text's
priority). At the end, a summary and your
chosen post-action — the default offer is to
choose again among power off, reboot, command
line, or starting over.

> **Check:** afterwards, in the repository,
> there is a new folder with your image's
> name. Its size should be in the parish of
> the source's *used* space, compressed —
> nowhere near the source disk's capacity.
> Chapter 8 opens that folder properly.
> Before you trust it with anything that
> matters, chapter 10's check is the next
> job.
