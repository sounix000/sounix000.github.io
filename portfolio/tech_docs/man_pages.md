---
"lang": "en",
"title": "Man pages in Linux",
"subtitle": "A short introduction to its different types",
"description": "Man pages in Linux"
---

## Overview

When installed along with packages or manually, the `man` pages are invaluable source of accurate, precise, and terse information about various files available in your Linux system. However, for beginners, the types of `man` pages are often confusing. This article encourages you to explore the types of `man` pages, with simple examples.

## Read the man page about the `man` command

1. Reading and understanding the documentation about `man` is the first logical and essential step. In your terminal application, execute the following command:

```bash
$ man man
```

2. You may be prompted to provide an appropriate option. Provide `1`.

3. Notice that at the start of the information displayed, `MAN(1)` is written. The associated number within the parenthesis indicates the type of man page information displayed. You will learn more about the meaning of different numbers in the next step.

4. Read the `DESCRIPTION` in the information displayed, and focus on the following excerpt:

```bash
The  table  below  shows  the section numbers of the manual followed by the types of pages they contain.

       0   Header files (usually found in /usr/include)
       1   Executable programs or shell commands
       2   System calls (functions provided by the kernel)
       3   Library calls (functions within program libraries)
       4   Special files (usually found in /dev)
       5   File formats and conventions eg /etc/passwd
       6   Games
       7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
       8   System administration commands (usually only for root)
       9   Kernel routines [Non standard]
```

5. Quit the man page by typing `q`.


As you have probably guessed by now, `MAN(1)` at the top of the page means the information displayed in the man page is about the the executable program or shell command `man`.

## Test the man page types with examples

Equipped with the basic concept of the types of man pages, let us now run some commands to validate the correctness of our mental model. We will use two variations of `systemd` as our examples; feel free to replace it with any other suitable string and follow along.

1. In your terminal appliction, run the following command:

```bash
$ man systemd
```

2. At the top of the man page displayed, notice `SYSTEMD(1)`. It means that the man page is about `systemd`, and the kind of information displayed are very similar to executable programs or shell commands. The man page of type `1` is also the most common type of man page. Quit the man page by pressing `q`.

3. In your terminal application, run the following command:

```bash
$ man systemd.service
```

4. At the top of the man page displayed, notice `SYSTEMD.SERVICE(5)`. Recall that `5` represents the type `File formats and conventions`. Now, if you read the information provided in the man page, you will realize that it is indeed about file configuration. Quit the man page by pressing `q`.

5. You can see the same information as displayed by the above command, if you directly pass on the number `5` while invoking the man page. Run the following command and verify it:

```bash
$ man 5 systemd.service
```

6. However, if you pass on an inappropriate number such as `1`, you get an error, because no man page of type `1` is unavailable for `systemd.service`.

```bash
$ man 1 systemd.service
No manual entry for systemd.service in section 1
```

## Conclusion

Therefore, you can conceptualize the general theme in the following manner: *Running the `man <STRING>` command opens up the man page, if available or installed. The top of the displayed information contains `<STRING>(N)`, where `N` an integer from `0` to `9`. The number `N` denotes the section number, or the type of man page information that is displayed.*