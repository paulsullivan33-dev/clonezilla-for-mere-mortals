# Device to Device

> **Documented-only in this guide**, on the
> same terms as chapters 5 and 6: no live
> session was run (transcript t90); this
> follows the project's documentation.

Sometimes there is no image. A disk is being
replaced *now* — new disk in hand, old disk
still readable — and the detour through an
image folder buys nothing. Clonezilla's
**device-device** mode clones one attached
disk straight onto another: same conductor,
same engine (chapter 2), no repository, no
`/home/partimag`.

Start Clonezilla, choose **device-device**
at the first fork instead of device-image,
then beginner mode, then **disk_to_local_disk**.
You name a **source** disk and a **target**
disk — and the chapter-5 discipline applies
with double force, because:

- **There is no image.** Nothing is kept. If
  the clone goes wrong or the source dies
  mid-copy, there is no folder to fall back
  to — you have a half-written target and a
  failing source.
- **The target is overwritten** exactly as in
  a restore (chapter 6), with the same double
  confirmation. Same rule about size: the
  target must be at least as large as the
  source (chapter 13).
- The copy is partition by partition, used
  blocks only where partclone knows the
  filesystem — so a device-device clone of a
  mostly empty disk is barely slower than an
  image save of it.

## When the direct clone is the right shape

- **A planned disk swap**: healthy source, new
  disk installed alongside, one sitting, done.
- **Duplicating a machine** onto identical
  hardware that is sitting next to it.

## When it is not

- **The source is failing.** A dying disk may
  not survive being read twice, and device-device
  keeps no intermediate. Save an image first
  (chapter 5) — better, read chapter 11's
  dying-disk recipe and meet ddrescue, whose
  whole design is failing hardware — then
  restore the image at leisure (chapter 6).
- **You want a checkpoint.** The image *is*
  the point of chapters 5 and 8: a clone made
  today and restored next month. A direct
  clone only ever describes today, on the
  target, once.
- **The two disks cannot be attached at
  once** — one bay, one cable. Images travel;
  direct clones do not.
