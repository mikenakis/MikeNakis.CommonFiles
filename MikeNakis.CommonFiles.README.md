# MikeNakis.CommonFiles<br><sup><sub>Common files shared among all of my dotnet projects.</sub></sup>

<p align="center">
  <img title="MikeNakis.CommonFiles Logo" src="MikeNakis.CommonFiles-Logo.svg" width="256" />
</p>

CAUTION: This file is `MikeNakis.CommonFiles.README.md`, and it is also pointed by a symlink called `README.md`. Never edit `README.md`; only edit `MikeNakis.CommonFiles.README.md`. For an explanation, see [Of Visual Studio, GitHub, README files, and symlinks](Of-Visual-Studio,-GitHub,-README-files,-and-symlinks.md).

This repository contains some files that are used by all (or almost all) of my projects.

- `.editorconfig`
- `.gitattributes`
- `.gitignore`
- `AllCode.globalconfig`
- `AllProjects.proj.xml`
- `BannedSymbols.txt`
- `ProductionCode.globalconfig`
- `BannedApiAnalyzers.proj.xml`
- `TestCode.globalconfig`

The files are meant to be hard-linked by each project that needs them.

This repository used to build a NuGet package with a `build/.props` file, so that any projects that need these files could reference the package instead of having to hard-link the files, but that was immensely complex, held together by shoestrings, very fragile, and ultimately unmaintainable.

## License

See [LICENSE.md](LICENSE.md)
