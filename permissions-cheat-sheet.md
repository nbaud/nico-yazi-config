|  Octal | Special Bit | Owner | Group | Others | Symbolic     | Meaning / Typical Use |
| -----: | ----------- | ----- | ----- | ------ | ------------ | --------------------- |
| `0000` | –           | ---   | ---   | ---    | `----------` | no access             |
| `0644` | –           | rw-   | r--   | r--    | `rw-r--r--`  | normal file           |
| `0664` | –           | rw-   | rw-   | r--    | `rw-rw-r--`  | shared group file     |
| `0600` | –           | rw-   | ---   | ---    | `rw-------`  | private file          |
| `0700` | –           | rwx   | ---   | ---    | `rwx------`  | private executable    |
| `0755` | –           | rwx   | r-x   | r-x    | `rwxr-xr-x`  | programs / dirs       |
| `0775` | –           | rwx   | rwx   | r-x    | `rwxrwxr-x`  | shared directory      |
| `0777` | –           | rwx   | rwx   | rwx    | `rwxrwxrwx`  | ⚠️ world-writable     |


| Special    | Octal  | Effect                       | Symbol            |
| ---------- | ------ | ---------------------------- | ----------------- |
| **setuid** | `4xxx` | run as file owner            | `s` in owner `x`  |
| **setgid** | `2xxx` | run as group / inherit group | `s` in group `x`  |
| **sticky** | `1xxx` | only owner can delete        | `t` in others `x` |


|  Octal | Symbolic    | Applies To | What It Does                    |
| -----: | ----------- | ---------- | ------------------------------- |
| `4755` | `rwsr-xr-x` | binary     | run as **root** (e.g. `passwd`) |
| `2755` | `rwxr-sr-x` | directory  | files inherit **group**         |
| `1777` | `rwxrwxrwt` | directory  | shared, but safe (e.g. `/tmp`)  |
| `2775` | `rwxrwsr-x` | directory  | group-shared project dir        |
| `4711` | `rws--x--x` | binary     | restricted privileged exec      |

