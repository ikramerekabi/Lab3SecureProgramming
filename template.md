---
title: Time your programs
subtitle: Laboratory 3
author: Ikrame Rekabi and Natalia Serra
date: 29 November 2024
geometry: top=1.5cm,left=2cm,right=2cm,bottom=2cm
license: CC0 1.0
numbersections: true
highlightstyle: pygments
header-includes:
    - \usepackage{package_deps/comment}
    - \usepackage{multicol}
    - \usepackage{lmodern}
    - \newcommand{\hideFromPandoc}[1]{#1}
    - \hideFromPandoc{
        \let\Begin\begin
        \let\End\end
      }
colorlinks: true
lang: en-GB
---

<!-- Remplacer 'en-GB' par 'fr' pour un document en français -->

<!-- 
	Markdown is a minimalistic HTML-based language
	
	The restricted set of functionalities is BY DESIGN,
	It is useful in any course context to restrict report formatting.
	You SHALL NOT try to circumvent how it works. You must CONFORM to the format. 
	Any text editor will work, since Markdown is just plain text.
	
	Visual Studio Code has nice basic support and previewing capabilities,
	and support several extensions that enhance the writing experience.
	You are stroongly advised to use them.

	The template is commented to guide you through the format,
	but you should *read* the comments to understand.

	Note that line breaks do not exist. You cannot skip a line, 
-->

<!-- Sections are denoted with a "#" at the very beginning of the line. Do not number the sections! Pandoc will handle that part -->
# Introduction

The present laboratory project explores the functionalities, vulnerabilities and mitigation techniques of the `project_v0` program, while also diving a bit into the general idea and security implementations of the `project_v1` program. The analysis was done by first looking at the source code provided to understand the general functioning of both programs. Then, some vulnerabilities for `project_v0` were found, like the ability to do symbolic linking and  the time-of-check to time-of-use threat. For the `project_v1` program there were some technical issues regarding the lack of packages and tools to successfully exploit it. Therefore, the source code was studied and vulnerabilities were detected. These are discussed as well as some constraints implemented compared to `project_v0`. The exploitation of the `project_v0` program was made through the command line and it is further described in this paper. Finally, we present some mitigation techniques that could be used to avoid the exploitation presented in this project.

<!-- Each new "#" denote a lower section level, "##": subsection; "###": subsubsection; and so on. -->
# Programs

Two programs are under analysis in this paper.

## Project_v0

This is a file copier program compiled with a main function, some helper functions and hidden functions. The main purpose of this program is to get two files from the user, from which it reads the contents of one and writes these into the other file. The execution of this program is denoted as:

```
./file_copier -i input_file.txt -o output_file.txt
```

The flags `-i` and `-o` are there to explicitly declare the input and output file of the user. The main.c (see Fig. 1), copies the contents of an input file to an output file in a secure manner, entailed by the `secure_copy_file()` function. It implements error handling and managing resources appropriately. It starts by parsing and validating the command line arguments via the `parse_options()` function, filling the pointers input and output with the respective file paths. If there are any parsing errors, the program frees any allocated memory for input or output before exiting with a failure status. If the inputs are validated, the program continues to the `secure_copy_file()` function to copy the contents of the input file to the output file. After copying, the program frees the allocated memory to avoid memory leaks and returns the result of the copying operation, which can either be a success or a failure. This is done ensuring errors are handled correctly.

![Figure 1: source code for main.c for project_v0](images/main.v0.png){ width=60% }

On the other hand, the `functions.c` file is a secure file copy utility that is designed to take user input and output file paths, validate them, and "securely" copy the contents from the input file into the output file. It uses the function `parse_options()` to handle the command line arguments via the library `getopt()`, considering `-i` and `-o` flags to identify the input and output file paths, respectively. If valid files are detected, memory is allocated to store these file paths, and the values are copied using the `strcpy()` function. In case of any errors, such as ambiguous or unknown options, the program has error handling and exits with a failure status, hence providing secure failing in case of incorrect user input.

Furthermore, in this file we can find the `secure_copy_file()` function used in the `main.c`. The "secure" part comes from the fact that it implements some security checks while performing the copy. First, using the `access()` function, it checks whether the input file is readable and the output file is writable. If this is not the case for any of the files, an error handling case occurs and the program is terminated. If the files are validate, the function proceeds to call the `wait_confirmation()` hidden function to ask the user for confirmation before copying. The actual operation of copying is done by another hidden function which is called only if the user confirms the action. his layered approach ensures that file access permissions are checked, user intent is verified, and potential security risks, such as overwriting or reading critical files without consent are avoided (to some extent).

![Figure 2: source code for functions.c for project_v0](images/functions.v0.png){ width=60% }

The last `.c` file contains the hidden functions of the program `copy_file()` and `wait_confirmation()`. `copy_file()` does the copying functionality previously described using the input and output files provided by the user, processing the data in chunks of 2048 bytes. The reading and writing on each file is done in read mode and write mode, respectively, closing them after usage. During the copying operation, the function checks for read or write errors and makes sure the data is successfully written into the output file, while also using assertion to handle unexpected behavior.

The `wait_confirmation()` is a crucial function for the exploit presented in this paper. It is a function that tries to enhance security by adding a confirmation step to the user's action. It performs this action by asking for the confirmation, with a timeout after 3 seconds, using `poll()` function to check whether standard input is available. If the user takes too long or enters anything other than 'y' or 'Y', the function will provide an error and abort its copy operation. This was intended to defend against accidentally copying the files and ensuring an affirmative choice by the user.

![Figure 3: source code for hidden_functions.c for project_v0](images/hiddenfunctions.v0.png){ width=60% }

## Project_v1

For this program, this `main.c` file is used for "securely" hashing the contents of an input file and storing the result in the output file. It begins by declaring pointers for the input and output file paths, which are taken through the `parse_options()` function. This function, as explained, processes command line arguments and validates that both -`i` and `-o` options are provided; if not, or if an error occurs, the program frees up any allocated memory and exits with a failure status. If the files are validated the program behaves similarly to the one presented before, it calls the `secure_hash_file()` to "securely" hash the contents of the input file to then write it into the output file. Once the operation is complete, the program releases any dynamically allocated memory for the file paths and returns the result of the hashing operation.

![Figure 4: source code for main.c for project_v1](images/main.v1.png){ width=60% }

The file depicted in Fig. 5 provides functionality for parsing command line arguments and securely hashing the contents of an input file into an output file. The function `parse_options()` processes the arguments provided by the user, ensuring that the input `-i` and output `-o` paths are provided. Both paths are dynamically allocated, with error checking to catch invalid or missing arguments. If there are no errors, the program will hash the input file using the `secure_hash_file()` function.

In the `secure_hash_file()` function, the first thing the program does is to ensure that the output file exists, creating an empty one if it does not. Then it checks if the input file has permissions to read and the output file has permissions to write into. If both files pass their respective permission checks, the program computes the hash for the input file by utilizing the `compute_confirmation()` function and writes said hash to the output file with `write_file()`. It implements comprehensive error handling, which reports on issues such as missing read or write permissions and ensures file operations are handled gracefully.

![Figure 5: source code for functions.c for project_v1](images/functions.v1.png){ width=60% }

Lastly, on Fig. 6 we can see the contents of the `hidden_functions.c` file which help compute the SHA-256 hash of a file's content and save the hash value to an output file, in this case, provided by the user. The `compute_confirmation()` function handles the hash calculation by reading the entire content of the input file, using the `SHA256()` function from the OpenSSL library to compute the hash. This is done by opening the input file, determines its size using `fseek()` and `ftell()`, and reads the content into a dynamically allocated buffer. After computing the hash, it frees the allocated memory and closes the file. The second part of the C source code shows the `write_file()` function which is responsible for writing the computed hash to the specified output file in hexadecimal format. Here, each byte of the hash is printed as a two-digit hexadecimal value, and the result is followed by a newline character. At the end, the function ensures the output file is properly closed after writing to maintain the integrity of the operation.


![Figure 6: source code for hidden_functions.c for project_v1](images/hiddenfunctions.v1.png){ width=60% }


# Analysis

## Project_v0: issues and exploitations

The vulnerability in the given code stems from improper handling of symbolic links during file operations, combined with a **race condition** introduced by the `wait_confirmation` function. Specifically, the program does not properly validate whether the input file is a symbolic link before performing the file copy operation, which allows to exploit the program by using symbolic links to redirect the input file to sensitive files on the system, such as `/etc/shadow`.

The `wait_confirmation` function is key to this vulnerability because it introduces a **3-second delay** to give the user a chance to confirm or reject the operation. During this waiting period, we can manipulate the input file by creating a symbolic link to a sensitive file before the program asks for user input. This allows to trick the program into copying the contents of a critical file, such as `/etc/shadow`, instead of the intended input file.

To demonstrate the exploitation of this vulnerability, a symbolic link was created using the `ln` command, linking a file named `test_in2.txt` to the sensitive `/etc/shadow` file on the system. The exploit was carried out on the university's server, where both the malicious `ln` command and the vulnerable `file_copier` program were executed in parallel using `tmux`. This setup allowed for precise timing, as the symbolic link had to be created before the 3-second timeout expired in the `wait_confirmation` function, which was responsible for the race condition. By linking the input file to `/etc/shadow` just before the timeout expired, the attacker could confirm the operation (by pressing "y") and successfully copy the contents of `/etc/shadow` to the output file.

The command used to exploit the vulnerability was:
```
ln -s /etc/shadow test_in2.txt
```
This command creates a symbolic link, test_in2.txt, pointing to the system's shadow file. The vulnerable file_copier program was then run with the following command:
```
./file_copier -i test_in2.txt -o test_out.txt
```
Since the input file `test_in2.txt` was a symbolic link, the program followed the link and tried to copy the contents of `/etc/shadow`, instead of `test_in2.txt`. The program did not validate the symbolic link, and the malicious redirection of the file copy operation succeeded.

To illustrate the exploit; the end goal was to copy the content of `/etc/shadow` into the `test_out.txt`

The following screenshots demonstrate the exploit:


We first run the program with two test files; an input test file `test_in2.txt` and an output test file `test_out.txt`

![Figure 7: Running the Program](images/attack.png){ width=60% }

We then run the ln command at the same time as the program is running before returning `y` into the original program running.

![Figure 8: The ln command](images/commandranforexploit.png){ width=60% }

To check the linking, we run the ll command output in the directory, and it shows that that test_in2.txt is indeed a symbolic link pointing to `/etc/shadow`.

![Figure 9: The ll command](images/llrights.png){ width=60% }

Then, we check the content of `test_out.txt`, and it shows the content of `/etc/shadow`, which proves that the vulnerability succeeded.

![Figure 10 The ll command](images/proofetcshadowcopied.png){ width=60% }



## Project_v1: issues

After close analysis of the functionality of this program, while we were not able to exploit it we wanted to comment on its vulnerabilities. This is common in programs where there is improper handling of inputs, insufficient checks on memory and file operations, and potential flaws in the way resources are managed. Some of the vulnerabilities encountered are:

- The `parse_options()` to allocate the path names for the input and output files calculates the size without considering the extra byte for the null terminator, which may lead to a buffer overflow when `strcpy()` is used to copy the input strings. The program does not check or sanitize the file path from the user input at all, so it would be vulnerable to directory traversal attacks, symbolic link attack, or allow access to critical files.
- The `secure_hash_file()` function has several file access-related bugs. For example, there is a Time-of-Check-to-Time-of-Use (TOCTOU) bug after the access check that is supposed to ensure that the permissions of the file are handled properly. An attacker could switch the file out (e.g., through symbolic links) to point to a sensitive or unintended location during the gap between the check of access permissions and the actual opening or writing to the file. This can result in unauthorized overwriting of files, data corruption, or leakage of sensitive information. Additionally there are risks withing the functions `fopen()` in `secure_hash_file()`, `write_file()`, and `compute_confirmation()`, which lack error checking to verify the if the file modifications were successful. For example, if the file descriptor is NULL, the program's behavior may be undefined.
- The way `compute_confirmation()` handles the user files provided, it does not account for excessively big files, which could enable attacks like DoS or heap exhaustion. Also, there might be some pathways were memory is not freed, which could lead to memory leakage. 
- The lack of validation on the output file introduces the risk of symbolic links being exploited to redirect writes to files not intended for writing. This vulnerability is more risky by the TOCTOU vulnerabilities described earlier, in which access checks occur in a different step than actual file operations. This allows an advert to attack these gaps to overwrite systems or applications that use critical files.

# Solutions

Given the exploit, some mitigation tehcniques of the vulnerability in the `file_copier` program needs to be done by implementing strong defenses against symbolic link exploitation and race conditions, along with enhancing general security practices in file handling. The following can prevent this kind of exploit and make the program more resilient:

- One of the major vulnerabilities in the program is that it does not check whether an input file is a symbolic link. To handle this, `lstat` system calls among others that will have to be used instead of `stat` to make a proper difference between a regular file and a symbolic link. The idea would be to refuse the symbolic links as an input in order not to allow attackers to redirect file operations to some sensitive system files. For instance, prior to opening the input file, the program can perform an `lstat` check, making sure the file is of regular type or is explicitly authorized.
- The delay imposed by the `wait_confirmation()` function enhances the possibility of a TOCTOU vulnerability. The best way of mitigating this is immediately after validating the input and output paths, opening them and using the file descriptors throughout the program so it can operate on the exact files that were intended for operation in case the filesystem changes during execution. Additionally, the program can use the O_NOFOLLOW flag when opening files to prevent symbolic links.
- To minimize the attack surface, the program should limit input and output files to specific, authorized directories. For instance, if the program can only have all files reside in a known working directory, exploitation of sensitive system files would be prevented. Another possible solution for directory attacks involves path sanitization and validation, such that they do not contain components like symbolic links that reference outside the allowed directory.
- The program should be more strict regarding privileges when reading and writing a file. If the program is running from elevated privileges, the program should ignore such privileges to enfore the least privilege principle, disabling the possibility of an attacker of accessing root. 
- In order to remove the race condition brought about by `wait_confirmation()` the prompt for confirmation should be done prior to any file validation or operations. In this way, user confirmation does not give an opportunity for attackers to act on the file system. Another solution is allowing the program to lock files using advisory or mandatory file-locking mechanisms to ensure that no modifications occur between validation and operation.

Other improvements to the program addressing developers, users and stakeholders' interests include:

- By implementing thorough logging within the `file_copier` program, it could help trace malicious behavior or attempts to exploit vulnerabilities. For example, logs can record details of the file paths, file attributes, and operations performed. Such monitoring of logs can be done by administrators to detect and respond to suspicious activities like repeated attempts at trying to access restricted files.
- Static analysis tools for finding vulnerabilities, such as unchecked symbolic links, TOCTOU vulnerabilities, or unsafe memory handling, can be done to handle problems actively. Vulnerabilities in the code also need regular reviews and security audits to ensure that secure coding practices are followed.
- The user can also be informed about potential misuse to improve security awareness. For instance, it might include warnings about not copying sensitive files and provide tips on how to handle files securely.

# Patched vulnerability

## Primary Patch

The primary patch for the vulnerability involves better handling of symbolic links. Specifically, it checks whether the files passed as arguments are symbolic links or regular files, preventing potential exploitation through symbolic link attacks. 

This is achieved by adding two functions to the code.

- **`is_symlink` Function**

The `is_symlink` function checks if a given file is a symbolic link. A symbolic link is a special type of file that points to another file or directory, allowing for redirection of operations.

To understand how the `is_symlink` function works, we first need to explain how the `lstat` system call operates. `lstat` is used to retrieve information about a file without following symbolic links. It populates a `stat` structure with various data, such as the file's size, permissions, and type. The most important aspect here is the `S_ISLNK` macro, which checks if the file type is a symbolic link by inspecting the `st_mode` field in the `stat` structure.

If the file is a symbolic link, `lstat` returns `0` (success). If the file is not a symbolic link, `lstat` returns `-1` and sets `errno` to indicate the error (e.g., the file does not exist).

Now that the `lstat` is well defined, we can explain how the `is_symlink` Function Works:

First, the function calls the `lstat` system call on the provided file path. The `stat` structure returned by `lstat` contains various file attributes, including the file type and the `S_ISLNK` macro which is used to check if the file type is a symbolic link by evaluating the `st_mode` field of the `stat` structure.
If the file is a symbolic link, the function returns `1`. If it is not a symbolic link, it returns `0`. And, if `lstat` returns `-1`, indicating an error (e.g., if the file does not exist), the function prints an error message and returns `-1`.

![Figure 11 The `is_symlink` function](images/issymlink.png){ width=60% }

- **`is_invalid_symlink` Function**

The second function, `is_invalid_symlink`, enhances the validation of symbolic links by resolving the actual path of the symbolic link using the `realpath` function. It then checks if the resolved path points to restricted directories, such as `/etc` or `/root`. If the resolved path starts with any of these restricted directories, the function returns `1`, indicating that the symbolic link is invalid and should not be allowed. This helps ensure that sensitive system files are not inadvertently exposed through symbolic links.

The `realpath` function resolves the absolute path of a symbolic link or file by following all symbolic links in the path and returning the final target. It provides the canonicalized absolute pathname of the file, eliminating any symbolic links or relative paths (like `.` or `..`) and resolving them to their actual destination. If `realpath` encounters an error (for example, if the symbolic link points to a non-existent target), it returns `NULL` and sets `errno`.

In the `is_invalid_symlink` function, `realpath` is called first to resolve the symbolic link to its absolute, canonical path. This means `realpath` follows the symbolic link and returns the actual target file or directory that the symbolic link points to. The resolved path is then compared to a list of restricted directories, including `/etc` and `/root`. If the resolved path starts with any of these restricted directories, the symbolic link is considered invalid and the function returns `1`. If the symbolic link is valid, meaning it does not point to a restricted directory, the function returns `0`. This function plays a critical role in improving security by preventing symbolic links that point to sensitive or system-critical directories.

![Figure 12 The `is_invalid_symlink` function](images/isvalidslink.png){ width=60% }

The `secure_copy_file` function is updated to include the previous 2 functions. So that before proceeding with the copy, it first checks if the input and output files are symbolic links and whether they point to restricted directories. If either the input or output file is a symbolic link pointing to a restricted directory, the function aborts the operation and prints an error message. If no issues are found, it proceeds with the usual file read/write operations and the confirmation step.

![Figure 13 The `secure_copy_file` function](images/updated_copyfile.png){ width=60% }

The following screenshot illustrates the result of running the command with a symbolic link to /etc/shadow, which is restricted by the patch.

In this screenshot, we attempt to create a symbolic link `(symlink_to_etc.txt)` pointing to /etc/shadow, a sensitive system file.
We run the `ln` command to create the symbol link `(symlink_to_etc.txt)` pointing to /etc/shadow. Then, when attempting to run the file_copier command, the program correctly detects that the symbolic link points to a restricted directory `(/etc)` and prevents the file copy operation. The error messages confirm that symbolic links to restricted directories are disallowed, and the contents of `test_out1.txt` remain empty, as the copy operation was blocked.

![Figure 14 Running the patched code](images/the_patch.png){ width=60% }

## Other patches

Other patches can be made (but are not included in the code to avoid adding more than one functionality in the same code). For example:

- Locking Mechanism to Prevent Race Conditions:
  
We can modify the file copy mechanism by adding this functionality, which ensures that the symbolic link cannot be altered while the confirmation prompt is waiting for user input. A file lock is acquired before the file copy operation begins, and the lock is released only after the operation is complete. This prevents malicious interference during the crucial validation step.
The function to be added can look like this:
	int lock_file(const char *file_path) {
	    int lock_fd = open(file_path, O_RDONLY);
	    if (lock_fd == -1) {
	        perror("Failed to lock file");
	        return -1;
	    }
	
	    if (flock(lock_fd, LOCK_EX | LOCK_NB) == -1) {
	        perror("Failed to acquire lock");
	        close(lock_fd);
	        return -1;
	    }
	
	    return lock_fd; // Lock successful
	}

- Timeout Handling for User Confirmation:
  
The current system relies on a fixed 3-second timeout to confirm the user's intent. This patch modifies the logic to handle timeouts more effectively. If the user fails to respond within the specified time, the operation is aborted automatically.

The modified wait_confirmation function can be modified as follows to ensure that the program exits if the user does not confirm within the designated timeout period:

	int wait_confirmation(const char *in, const char *out) {
	    time_t start_time = time(NULL);
	    int confirmation_timeout = 3; // 3 seconds timeout
	
	    printf("You are about to copy file %s in %s. Are you sure? (y/N)\n", in, out);
	
	    while (1) {
	        char user_input = getchar();
	
	        if (user_input == 'y' || user_input == 'Y') {
	            return 0; // Proceed with file copy
	        } else if (user_input == 'n' || user_input == 'N') {
	            return 1; // Cancel the operation
	        }
	
	        // Check if timeout has expired
	        if (time(NULL) - start_time > confirmation_timeout) {
	            fprintf(stderr, "Timeout reached. Operation aborted.\n");
	            return 2; // Timeout expired
	        }
	    }
	}

# Conclusions

This laboratory project discussed two programs handling files, namely `project_v0` and `project_v1`, with regard to their respective functionalities, possible vulnerabilities, and mitigation techniques. By analyzing their source codes and attempting to exploit them in practice, several critical security flaws were identified, especially in the `project_v0` program. The main weakness in `project_v0` was related to symbolic link handling and the existence of a race condition allowed us to exploit that could be used to redirect file operations targeting sensitive system files, like `/etc/shadow`. This was able to be exploited due to the lack of validation in symbolic links before file operations and the introduction of a delay in the function `wait_confirmation()` that allowed time for malicious action within the temporary window of vulnerability.

The `project_v1` tried to enhance security by hashing contents, but it did not mitigate all vulnerabilities. These included improper buffer management, insufficient input validation, and the presence of TOCTOU issues. The lack of more thorough error checking in file operations and inadequate protection against symbolic link attacks made it vulnerable to similar exploits as `project_v0`. Furthermore, the presence of memory leaks and DoS attacks that could be based on excessively large file sizes was identified as a major point of concern to improve resource management and input handling.

For the vulnerabilities, we have proposed some mitigation techniques for the `project_v0` program. We advised the use of `lstat` for checking symbolic links, immediate operations on files to avoid race conditions, and better sanitization of input to prevent directory traversal or other unauthorized file access. Out of all the mitigation techniques proposed, the most severe was not filtering the files provided to check if they were symbolic links, as this vulnerability combined with the TOCTOU attack would allow an elevation of privilege. Therefore, this was the mitigation implemented in the program.

From the analysis in both programs, it is noticed that proper file handling, input validation, and race condition mitigation strategies play an important role in software development. Regular security audits along with the use of static analysis tools would significantly help enhance the overall security posture for such programs, especially when working in teams. Potential issues need to be watched and planned for, with every development step taken securely in accordance with best practices in coding. By following these recommendations, such as the ones listed previously for `project_v0`, potential vulnerabilities could be reduced against the presented types of attacks while giving users a more secure experience.
