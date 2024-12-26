Please see the real README file: [MikeNakis.CommonFiles.README.md](MikeNakis.CommonFiles.README.md)

----------------------------

Explanation:

PEARL: Visual Studio suffers from a monstrous, insidious bug where the spell checker goes haywire if you have
two files with the same name in the solution.

To work around this bug, it is possible to give unique filenames to the vast majority of files in a
solution, but then there are some stupid tools that require certain fixed filenames	for certain things.

One such stupid tool is GitHub, and its requirement that the README file must be called README.

The solution to this problem is to prefix the filename of the README file with the name of the project, i.e. 
MyProject.README.md. (This has the added benefit of also making it easier to locate among editor tabs.) Then, we must
have a fake README.md file for exclusive use by GitHub which only contains a link to MyProject.README.md. (This is what 
this README.md file is, plus this whole text explaining why we are in this preposterous situation.)

- It is not possible to copy MyProject.README.md as .github/README.md, because then all relative links in it would be
broken.
 
- It is not possible to create a symbolic link called README.md pointing to MyProject.README.md, because GitHub is so 
special that it refuses to follow the symbolic link; instead it renders the content of the symbolic link, which is the 
filename of the target file, and it is plain text, not a link.

I will have a normal README file when either Visual Studio or GitHub fixes their shit. (And I am not holding by breath for that.)
