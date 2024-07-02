---
"lang": "en",
"title": "Hello World",
"subtitle": "The first program in C",
"authors": ["Souvik Sarkar"],
"date": "2 July 2024",
"description": "Hello World in C language",
"tags": ["C","Programming"]
---
### Abstract

This is the famous `Hello, World!` program in C.

## Code

```c
#include <stdio.h>

int main()
{
    printf("Hello, world!\n");
    return 0;
}
```

## Compilation

Using the GNU C compiler on a Linux system, you can compile the program by running the following command:

```bash
$ gcc hello.c -o hello
```