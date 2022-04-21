This is a Preprocessor for RISC-V Assembly that works on Ripes Simulator.

[GitHub - mortbopet/Ripes: A graphical processor simulator and assembly editor for the RISC-V ISA](https://github.com/mortbopet/Ripes)

### What you can do with the Preprocessor

- Work with multiple files

- Let the Preprocessor handle the logic needed for 'ra' register when calling a procedure

- Let the Preprocessor handle the push and pop on the stack of the registers used by procedures

### Instructions on how to use the Preprocessor

1. You will need a Main file. It MUST start with the line '#! <entry_point>'. In this case the, so called, 'entry_point' is the name of the procedure you want to run. Think of it like 'main' in C.

2. Every file can have a '.data' and '.text' section. Be careful to use unique names all over the files because they will end up in the same one at the end so you have to make sure you will not fall in same naming conflicts.

3. After this first line you can start including other files to main. You can only include files in the 'main' file, otherwise an error will be raised. The syntax to do so is the following: '#!include <file_name>.s' (.s is the extension of the file, if you are using a different one just change it in here)
   
   1. Be careful that there is NOT a space between '!' and 'include'

4. main file MUST have a '.text' to notify the end of '.data' (even if there's no '.data') BUT you can't place any code in '.text' that is outside of a procedure. You have to put all of the code inside the ''. (The Preprocessor will take care of reaching it, don' worry)

5. Every procedure (apart from 'main' procedure) has to be written in a specific way. 
   
   1. <name_of_the_proc>: 
      
      1. make sure not to put anything after ':' (not even comments, if you absolutely need them you can place them before the procedure)
   
   2. #! a0 a1 t0 t1 ... 
      
      1. this MUST be the first line after the procedure name. It contains all the registers (separated by a single space) that are used by the procedure. You can choose to place here only the register that are going to be modified inside the procedure. 
   
   3. #! manage_ra 
      
      1. this is not mandatory but, if you want to use it, it MUST be the second line after the procedure name. With this line, you tell the Preprocessor to handle the logic behind the 'ra' register. If you don't know what that is or what are the problems behind it, just place that line.
   
   4. <body_of_the_procedure>
      
      1. nothing special here, just the code you need
   
   5. #! end
      
      1. this MUST be the last line of the procedure. it maps to the instruction 'jr ra' so you don't have to put that. In case you put also '#! manage_ra' the Preprocessor is going to manage the 'ra' register, otherwise it's your job to make everything work. This is needed by 'main' proc too!

6. #! precall(<name_of_procedure>)
   
   1. this is where the magic happens, earlier I explained that you need to explicitly tell wich registers are used by each procedure. its role was to be able to use '#! precall'. 
   
   2. What it does is pushing the used registers to the stack. this way you don't have to do it manually, which can lead to problems hard to identify during debugging.
   
   3. All you have to do is place ''#! precall(<name_of_procedure>)' before your usual 'jal <name_of_procedure>'.

7. #! postcall(<name_of_procedure>)
   
   1. the same goes for this one.
   
   2. you have to place this after you call the procedure, this way the Preprocessor will place here the code needed for retrieving the register that you just pushed to the stack

An example is provided in the repository.

### Installation

```bash
git clone https://github.com/LBartolini/RISCV-Preprocessor.git
cd RISCV-Preprocessor
pip3 install -r requirements.txt
```

The installatio process is very easy. Just clone the repository and install the required packages via PIP. (You have to use Python3 as shown by the pip3 command)

### Usage

```bash
python ../RISCV-Preprocessor/main.py -s main.s -o output.s
```

This is an example of how to use the program. 

In this example the folders are constructed like this.

- MyBeautifulFolder
  
  - RISCV-Preprocessor
    
    - ...
    
    - main.py
    
    - ...
  
  - MyNewAssemblyProject (executing that command from inside this folder)
    
    - ...
    
    - main.s
    
    - ...

##### Parameters

- **-s**, expects the entry file of you assembly project. I have already covered the specifics of the *main.s* file

- **-o** (optional if you set *-cc*), expects the output file.

- **-cc** (optional if you set *-o*), this is a boolean which means you just have to put it in the command without any other string after it (*python main.py -s main.s -cc*). This is going to copy to the clipboard the whole program so that you can easily paste inside Ripes when debugging your code.

These are the standard parameters. At the moment I'm writing this docs the latest non-stable release of Ripes is [Ripes-v2.2.4-47-g48047b7](https://github.com/mortbopet/Ripes/releases/download/continuous/Ripes-v2.2.4-47-g48047b7-mac-x86_64.zip) that includes support for CLI. If you have this version, or newer, you can use some other parameters to the Preprocessor that will allow you to run directly your code in the terminal without having to copy-paste to the Ripes GUI.

- **-exe**, boolean (as like *-cc*) that tells the preprocessor that you are willing to execute the program directly from the Command Line.

- **-rp**, expects the path to the Ripes executable. You can provide a relative path or an absolute path. What is suggest is to export an environment variable (like this *export RIPES_PATH=<path_to_executable>*) to store the absolute path and pass it as argument (just like this *python main.py -s main.s -exe -rp $RIPES_PATH*) 



### Contacts

For any specific request don't hesitate to contact me at:

- [l.bartolini02@gmail.com](mailto:l.bartolini02@gmail.com)
