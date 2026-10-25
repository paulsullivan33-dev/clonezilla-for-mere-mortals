# Partclone by Hand

Everything Clonezilla does to a partition, it
does by running partclone (chapter 2). The
corollary is worth a chapter: **you can run
partclone yourself**, from any Linux system,
without booting anything. The live system is
a convenience and a safety harness; the
engine is a command-line program.

Why you would:

- **Inspect an image** — read its header, ask
  what it holds — without restoring it.
- **Rescue files from an image** — restore it
  into a file, not a disk, and read the
  filesystem inside at your leisure.
- **Understand what the wizard did** — the
  lab found that one honest save-and-restore
  by hand taught more than any diagram.

What follows is the lab's own run, end to
end. Its sandbox had no disk it could image
(transcript t90), so it built a filesystem
inside a file — a trick worth learning in
itself, because it turns any imaging
experiment into a safe one.

## Making a filesystem inside a file

`mkfs.ext4` will populate a filesystem from a
directory as it creates it (the `-d` option)
— no loop device, no mount:

```
$ truncate -s 64M src.img
$ mkfs.ext4 -q -F -L FIELDNOTES -d src-tree src.img
```

The lab's `src-tree` held six invented files
— a readme, a manual page, a CSV of made-up
readings, a megabyte of random data, two
megabytes of zeros and an empty file —
checksummed before imaging (transcript t04).
The result: a 64 MiB ext4 filesystem, label
`FIELDNOTES`, 2,331 of its 16,384 blocks in
use. `debugfs` reads such a file directly —
listings and file extraction with no mount —
and the lab used it as the microscope for
everything that followed.

> **Check:** `dumpe2fs -h src.img` reports the
> shape: block count 16384, free blocks
> 14053, block size 4096 (transcript t04).

## Saving, the way Clonezilla saves

```
$ partclone.ext4 -c -s src.img -o src.pcl
Partclone successfully cloned the device (src.img) to the image (src.pcl)
```

`-c` clone (save), `-s` source, `-o` output.
The program walks the filesystem's block map
and writes the 2,331 used blocks: the image
is 9,549,978 bytes for a 67.1 MB filesystem.
With Clonezilla's usual plumbing — the image
stream passed through a compressor (chapter
2's `-z` shelf):

```
$ partclone.ext4 -c -x zstd -s src.img -o src.pcl.zst
```

`-x` names the command the stream is piped
through: 1,050,876 bytes. Both numbers, and
what they are made of, are chapter 8's
arithmetic (transcript t05).

Ask the image about itself before trusting
it — `partclone.info` reads the header, and
`ocs-chkimg`'s engine is partclone's own
checker:

```
$ partclone.info src.pcl
File system:  EXTFS
Device size:   67.1 MB = 16384 Blocks
Space in use:   9.5 MB = 2331 Blocks
Free Space:    57.6 MB = 14053 Blocks
Block size:   4096 Byte
image format:    0002

$ partclone.chkimg -s src.pcl
Partclone successfully checked the image (src.pcl)
```

## Restoring, and the refusal that teaches

```
$ truncate -s 64M dst.img
$ partclone.ext4 -r -s src.pcl -O dst.img
Partclone successfully restored the image (src.pcl) to the device (dst.img)
```

`-r` restore. Note `-O`, capital: the lab's
first attempt used `-o` against a target file
that already existed, and partclone refused —
*"Output file already exists. Use option
--overwrite if you want to replace its
content"* (transcript t06, kept in full).
The flag is the point: this program writes
disks for a living, and it will not replace
anything uninvited. On the live system the
same instinct appears as chapter 6's double
confirmation.

The compressed image restores by piping the
decompressor into partclone's standard input
— the same plumbing, mirrored:

```
$ zstd -dc src.pcl.zst | partclone.ext4 -r -s - -O dst2.img
```

## Proving it

Trust is a checksum comparison, not a
feeling. Both restored filesystems were
checked with `e2fsck -fn` (clean; 2331/16384
blocks, the source's exact shape), and every
file was extracted with `debugfs` and
checksummed:

```
$ sha256sum (files extracted from the restores)
4e1970fe...  data/blob.bin
e3b0c442...  data/empty.txt
30fadd62...  data/measurements.csv
5647f05e...  data/zeros.bin
bb9d18d1...  documents/manual.md
b323cb7e...  readme.txt
```

…identical, all six, to the originals, from
both restores (transcript t06). Whatever was
on the *rest* of the target file — the 86%
of blocks the filesystem calls free — the
image never claimed to describe, and the
restored filesystem correctly does not
either. That is the whole contract of a
partclone image, demonstrated end to end.

## The honest boundaries of doing it by hand

- Partclone alone knows nothing of
  **partition tables**. Clonezilla wraps it
  with parted/sfdisk bookkeeping (chapter 2);
  by hand, a whole-disk job means saving and
  restoring the table and each partition
  yourself, in the right order, at the right
  offsets.
- A partclone image of a partition is written
  **to a partition (or file) of at least the
  original's size** — the bitmap places blocks
  at their original addresses.
- Reading files out of a restored-to-file
  image needs filesystem tools for the
  filesystem in question (`debugfs` here);
  there is no universal "open image" button —
  which is chapter 1's "not a file tool",
  wearing work clothes.
