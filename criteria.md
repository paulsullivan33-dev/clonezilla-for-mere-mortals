# Writing Criteria

Every guide in this repo is written to the same
standard. If you're adding or editing a guide —
human or AI — hold it to these.

1. **Plain words, real ideas.** Simple language,
   never dumbed-down concepts. Explain jargon on
   first use; collect terms in the glossary.
2. **No hype.** No marketing adjectives, no
   "revolutionary," no promises about what
   something will do for the reader.
3. **Honest about limits.** Say what the thing
   *can't* do. State uncertainty instead of
   smoothing it over. Validation notes include
   what remains unverified.
4. **No invented numbers.** Benchmarks, defaults,
   and specs are either measured or qualified with
   "depends on your setup." If it wasn't tested,
   say so.
5. **Checkable.** Commands are meant to be run,
   with "Check:" blocks showing what success looks
   like. Sources are linked, not asserted.
6. **Respect the reader's setup.** Call out
   Windows/Mac/Linux differences. Don't assume a
   GPU, a budget, or prior experience.
7. **Safety isn't skipped.** Real risks get
   stated plainly, not buried.
8. **Scoped.** Each guide says what it covers and
   points elsewhere for the rest. No guide
   pretends to be the whole subject.
9. **Structure over prose.** Tables, before/after
   examples, symptom → fix. Scannable beats essay.

## Verification notes for this guide

Built and verified 2026-10-24 against the
real release — **Clonezilla live 3.3.3-37**
(Debian-based stable, amd64) — and against
the engine installed on the lab machine,
Ubuntu 24.04's **partclone 0.3.27** and
**clonezilla 5.5.25** packages, on a
2-CPU, 7.7 GB sandbox running Ubuntu
24.04. Where the live system carries
newer builds (clonezilla 5.18.11-drbl1,
partclone 0.3.50; transcript t02), the
chapters say so.

**Primary sources read, not remembered:**
Clonezilla's official site and downloads
page (current stable 3.3.3-37, the
alternative stable, the testing line);
the project's official
Clonezilla-live documentation for the
save and restore dialogs (chapters 5, 6);
the release's own files — its CHECKSUMS,
menus, version record and package list;
and the tools' own usage text, captured
from the installed packages and from the
ISO's extracted system (transcripts t01
to t03, t07). Dialog details in chapters
4 to 7 follow the project's
documentation, and those chapters carry
the documented-only notice.

**The sandbox, declared.** The lab
machine has no spare or scratch block
device, cannot create loop devices (no
/dev/loop* nodes; `losetup -f` reports
"cannot find an unused loop device",
transcript t90), and cannot boot a live
system: no virtual display, and no
permission to write to a real device
even if one were offered. No imaging
tool was ever pointed at a real block
device of the sandbox. Within those
limits the lab worked with the real ISO
and ran the real engine on filesystem
images held in ordinary files — the
sandbox's properties, not Clonezilla's,
and chapters 4 to 7 are labelled
documented-only on exactly those terms.

**Ran for real** (transcripts in
`clonezilla-lab/transcripts/`):

- t00 — the official ISO downloaded
  (505,413,632 bytes); its SHA-256
  `3079458d…` and MD5 match the
  project's published CHECKSUMS.TXT
  exactly.
- t01 — the ISO inventoried without
  mounting it: a 420 MB squashfs system,
  initrd and kernel, signed EFI loaders,
  isolinux and GRUB menus (chapter 4's
  menu table is built from these files);
  the version file records the ISO was
  built by `ocs-iso`.
- t02 — the squashfs unpacked and read:
  Debian forky/sid, a 47,500-file root
  with 83 ocs-* programs, clonezilla
  5.18.11-drbl1, drbl 5.11.9-drbl2,
  partclone 0.3.50 and the full
  partclone family; the lab's own
  installed versions alongside.
- t03 — `ocs-sr`'s usage captured: the
  savedisk/saveparts/restoredisk/
  restoreparts grammar, the `-z0`…`-z9p`
  compression shelf and the checksum
  and encryption flags; `partclone.ext4
  --help` and `--version` (0.3.27).
- t04 — the practice filesystem built
  with `mkfs.ext4 -d` from a six-file
  invented tree (each file
  checksummed): 64 MiB, label
  FIELDNOTES, 2,331 of 16,384 blocks in
  use; `debugfs` lists the tree inside
  the unmounted image.
- t05 — `partclone.ext4 -c` saves it:
  9,549,978 bytes plain; 1,050,876
  bytes through zstd; `partclone.info`
  reads the image's own header back
  (2,331 blocks in use, format 0002);
  `partclone.chkimg` passes.
- t06 — restores to fresh files, plain
  and zstd-piped, both pass
  `e2fsck -fn` with the source's exact
  shape; every file extracted with
  `debugfs` and checksummed — all six
  SHA-256s identical to the originals.
- t07 — usage captured for `ocs-chkimg`,
  `ocs-cvtimg-comp`, `ocs-encrypt-img`
  and `ocs-decrypt-img`.

**Errors hit and diagnosed for real:**
partclone's restore refused an existing
target file until `-O` authorised the
overwrite — kept in full in t06 and
written up in chapters 9 and 14; the
ocs-* entry points refuse to run
outside the live system ("This program
is intended to be run in Clonezilla
Live!", t90), so their work — as
opposed to their usage text — is
documented-only here.

**Documented only, and labelled as
such in the chapters:** booting the
live system; writing it to a stick or
other medium; the full dialog-driven
save (chapter 5) and restore (chapter
6); device-to-device cloning (chapter
7); booting a machine restored from an
image; multicast and server-edition
behaviour (pointed at in chapter 12);
and running the ocs-* wrappers against
a real disk or a full Clonezilla image
(their usage was run; their work was
not). What a save dialog offers is
quoted from the project's
documentation and from the tools' own
usage text, never invented.

**Fixtures:** everything the lab made
up is small and generic — a workshop
field-notes folder (a readme, a manual
page, a CSV of invented readings, a
random-data file, a zero file, an empty
file) used to give partclone something
known to copy. Nothing in the lab is
modelled on any real person,
organisation or event.
