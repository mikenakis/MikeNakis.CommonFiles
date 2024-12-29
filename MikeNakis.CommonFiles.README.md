# MikeNakis.CommonFiles<br><sup><sub>Common files shared among all of my dotnet projects.</sub></sup>

<!--- Note: This image looks fine in most markdown renderers, 
            but not in Visual Studio, whose built-in markdown renderer is broken nowadays. 
			Someone has brought it to their attention, (https://developercommunity.visualstudio.com/t/10774870)
			and last I checked they were "investigating". -->
<p align="center">
  <img title="MikeNakis.CommonFiles Logo" src="MikeNakis.CommonFiles-Logo.svg" width="256" />
</p>

[![Build](https://github.com/mikenakis/MikeNakis.CommonFiles/actions/workflows/github-workflow.yml/badge.svg)](https://github.com/mikenakis/MikeNakis.CommonFiles/actions/workflows/github-workflow.yml)

This project compiles into a NuGet package which supplies the following files to projects that reference it:

- `.editorconfig`
- `AllCode.globalconfig`
- `ProductionCode.globalconfig`
- `TestCode.globalconfig`
- `AllProjects.proj`
- `ProductionProjects.proj`
- `TestProjects.proj`

The new files appear in a subdirectory called `MikeNakisCommonFiles` under the project directory. Visual Studio makes
these files read-only, which is fine, because they are not supposed to be edited.

The package also supplies a `MikeNakisCommonFiles` property which points to the directory where the supplied files are 
located, so they can be included as follows:

```xml
<ItemGroup>
	<!-- PEARL: If any .globalconfig files are not found, we get silent failure. -->
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisCommonFiles)\AllCode.globalconfig" />
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisCommonFiles)\ProductionCode.globalconfig" />
</ItemGroup>
```

Unfortunately, the `.editorconfig` file _**cannot**_ be included like that, so the `MikeNakis.CommonFiles` package 
automatically creates a symbolic link in the referencing project's directory pointing to the `.editorconfig` file in
`MikeNakisCommonFiles`.  Unfortunately, the symbolic link circumvents the read-only protection provided by Visual 
Studio, so the file becomes writable. Be careful not to modify `.editorconfig` in a project which references the
`MikeNakis.CommonFiles` package, because your edits will be lost next time the package is restored.

This project also has another useful feature: If the source directory of the `MikeNakis.CommonFiles` project is 
accessible in the filesystem from the directory of the referencing project, then the `MikeNakisCommonFiles` property
is set to point directly into the source directory of `MikeNakis.CommonFiles`, so that any changes made to 
`.editorconfig` or to any other file will appear as git changes in the `MikeNakis.CommonFiles` project.

## License

See [LICENSE.md](LICENSE.md)
