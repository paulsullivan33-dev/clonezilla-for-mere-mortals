# Checking and Converting Images

An image you have never checked is a hope,
not a backup. Clonezilla knows this about
itself and ships the instruments; this chapter
is about using them on a quiet afternoon
instead of a bad one. The partclone-level
tools were run by the lab (transcript t05,
t06); the `ocs-*` wrappers' usage was run and
is quoted (transcript t07); running them
against a full Clonezilla image inside the
live system is documented-only here, as it
was in chapter 6.

## Checking an image

**`ocs-chkimg IMAGE DEVICE`** walks an
image's partition streams and test-restores
them — checking that each partclone stream is
whole and restorable, against the checksums
partclone builds into its format (its usage
is transcript t07). In the live system this
is also offered as a menu step before a
restore; chapter 6's expert path can check
first and restore second. Underneath,
`partclone.chkimg` does the same for a single
stream, and the lab ran it for real:

```
$ partclone.chkimg -s src.pcl
Partclone successfully checked the image (src.pcl)
Checked successfully.
```

Two related habits, both cheap at save time
(chapter 5, expert options):

- **Generate checksums with the image**
  (`ocs-sr -gm` for MD5, `-gs` for SHA1) so a
  later restore can verify before it writes
  (`-cm` / `-cs` in the same usage text).
- **Check the files inside the device**
  (`-gmf`, verified at restore with `-cmf`) —
  a deeper promise: not just "the image is
  whole" but "the restored files hash to what
  the source's files hashed to". The lab's
  hand-check in chapter 9 — extract, checksum,
  compare — is this idea done manually, and
  its result is the standard to hold the
  automatic version to.

## Converting the compression

An image saved through gzip can later become
a zstd image, or an uncompressed one, without
touching the original disk: **`ocs-cvtimg-comp
SRC_IMAGE DEST_IMAGE`** re-streams the image
through a different compressor, choosing from
the same `-z0`…`-z9p` shelf (transcript t07),
and — unless told to skip it with `-sc` —
checks the converted image is restorable.
Why convert: an archive drive where space
matters more than time (towards zstd/xz), or
a restore on a weak machine where
decompression speed matters (towards none).
The conversion touches only the wrapping;
the used-blocks payload is identical either
way, as chapter 9's plain-versus-zstd
restores — both byte-identical — demonstrate
at partclone scale (transcript t06).

## Encrypting an image

A disk image is the whole machine: documents,
keys, browser state, everything. Left plain,
it is exactly as private as the drive it sits
on. Two doors to encryption:

- **At save time**: expert mode's encryption
  option, or `ocs-sr -enc` with `-pe` to pass
  the passphrase. The image is written
  encrypted from the start.
- **After the fact**: **`ocs-encrypt-img
  SRC DEST`** wraps an existing image under a
  passphrase (and by default *keeps* the
  plain original — deleting it is a separate,
  deliberate `-d`; transcript t07).
  **`ocs-decrypt-img`** reverses it.

The honest cost, stated in the project's own
terms and worth repeating: lose the
passphrase and the image is not "harder to
restore", it is *gone* — that is what
encryption means. An encrypted image plus a
forgotten passphrase is a very secure way to
own nothing. Keep the passphrase where you
keep the other keys to the machine, not in
the same bag as the image.

> **Check:** an image's health has three
> levels, and they are not interchangeable —
> the folder copies (any file tool), the
> streams check (`ocs-chkimg` /
> `partclone.chkimg`), and the contents hash
> (`-cmf`, or chapter 9 by hand). Know which
> level each of your images has actually
> passed.
