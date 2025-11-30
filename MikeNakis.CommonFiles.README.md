# MikeNakis.CommonFiles<br><sup><sub>Common files shared among all of my dotnet projects.</sub></sup>

<p align="center">
  <img title="MikeNakis.CommonFiles Logo" src="MikeNakis.CommonFiles-Logo.svg" width="256" />
</p>

Note: this file is `MikeNakis.CommonFiles.README.md`. It is pointed by a symlink called `README.md`. For an explanation of why I am doing this, see [Of Visual Studio, GitHub, README files, and symlinks](Of-Visual-Studio,-GitHub,-README-files,-and-symlinks.md).

This repository contains some files that are used by all (or almost all) of my projects. For example:

- `.editorconfig`
- `.gitattributes`
- `.gitignore`
- `AllCode.globalconfig`
- `AllProjects.proj.xml`
- `BannedSymbols.txt`
- `ProductionCode.globalconfig`
- `BannedApiAnalyzers.proj.xml`
- `TestCode.globalconfig`

This repository contains a C# project which does nothing, it does not even build any targets. The project simply exists in order to trick Visual Studio into showing the files it the Solution Explorer.

Each of my other projects that needs files from this project simply contains a script that can be manually launched to copy the necessary files over.

The `copy_file.bash` script copies a single file from this project to another.
The `copy_files_for_all_projects.bash` script copies all files for all of my other projects.

### History

In its first incarnation, this repository used to build a NuGet package with a `build/.props` file, so that any projects that needed files from this project could reference the package. That was immensely complex, held together by shoestrings, and ultimately unmaintainable, so I abandoned it.

In its second incarnation, this repository started following a different strategy: it did not build anything, it only contained filas, and each of my other projects contained hard-links to files of this project. This worked, since a hard-linked file turns into an individual file when committing via git, but it was still quite chaotic and unmaintainable, so I abandoned it, too.

So, I arrived at the current, third incarnation.

## License

See [LICENSE.md](LICENSE.md)
