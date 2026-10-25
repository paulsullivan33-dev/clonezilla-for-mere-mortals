# The Image Itself

An image is a folder. That plain fact is worth
a chapter, because everything about trusting,
moving and checking an image follows from it:
you can list it, measure it, copy it, and read
its own account of what it holds — from any
system, without booting Clonezilla at all.

## What the folder holds

For an image named, say, `workshop-laptop`,
saved by `ocs-sr savedisk` (grammar in
transcript t03), the repository folder
contains, per the project's documentation:

| File pattern | What it is |
| --- | --- |
| `<disk>-pt.sf`, `<disk>-gpt.gdisk` (as applicable) | The partition table, as text the tools can replay |
| `<disk>-mbr` | The disk's first sector — boot code and the table's other half |
| `<part>.<fs>-ptcl-img.<comp>[.aa, .ab, …]` | One partclone image stream per partition — e.g. `sda1.ext4-ptcl-img.zst.aa` — split into lettered volumes if splitting was set |
| `parts`, `dev-fs.list` | Plain-text records of the partitions saved and their filesystems |
| `Info-img-id.txt`, `dumpe2fs-<part>.info` and kin | Notes the save wrote about the source: sizes, filesystem reports |
| `md5sum`/`sha1sum` files (if requested) | The image's checksums, for chapter 10's checks |
| `blkdev.list`, `ocs-img-info.txt` | The source disk's identity: model, size, layout |

Names vary a little with options and versions;
the anatomy does not: **table files, one
stream per partition, and text records saying
what it all was.** Nothing in the folder is
magic, and none of it is hidden.

## Why it is smaller than the disk

Two savings stack:

1. **Used blocks only.** Partclone's image
   stream contains the blocks the filesystem
   says are in use, plus a bitmap saying
   where each belongs (chapter 9 runs this by
   hand). `partclone.info` reads an image's
   own header; the lab's example (transcript
   t05):
   *Device size 67.1 MB = 16384 blocks; Space
   in use 9.5 MB = 2331 blocks; image format
   0002; bitmap mode BIT.*
2. **Compression.** The stream is squeezed by
   the compressor chosen at save time
   (chapter 2). How much that wins depends on
   what the used blocks *are*: zeros and
   documents compress hard; photos, video and
   already-compressed files barely at all.
   The lab's image: 9.5 MB raw partclone,
   1.05 MB through zstd — and most of that
   1.05 MB was the one incompressible file in
   the fixture (transcript t05).

So an image's size on disk tells a truthful
story: *about how much data the source really
held, squeezed by about how squeezable it
was.* A 500 GB disk with 60 GB used does not
make a 500 GB image; it makes something in
the parish of 60 GB, less whatever
compression wins.

## An image is a specimen, handle it like one

- **It is a folder of ordinary files.** Copy
  it with ordinary tools; a bit-for-bit copy
  is a perfect copy. Back up the images
  themselves if they matter (chapter 13 on
  why the image is not its own backup).
- **Do not rename the parts.** The restore
  finds partitions by their filenames; the
  folder's name is yours to choose, the
  contents' names are the tools'.
- **Do not edit the streams.** There is a
  supported way to look inside an image
  without restoring it — chapter 9 — and it
  is read-and-extract, not edit-in-place.
- **Keep the text records.** The small files
  (`parts`, the info notes) are how future
  tools — and future you — know what this
  folder claims to be. They are also what
  chapter 10's checkers read first.
