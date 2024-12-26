# MikeNakis.CommonFiles<br><sup><sub>Common files shared among all of my dotnet projects.</sub></sup>

<!--- Note: This image looks fine in most markdown renderers, 
            but not in Visual Studio, whose built-in markdown renderer is broken nowadays. 
			Someone has brought it to their attention, (https://developercommunity.visualstudio.com/t/10774870)
			and last I checked they were "investigating". -->
<p align="center">
  <img title="MikeNakis.CommonFiles Logo" src="MikeNakis.CommonFiles-Logo.svg" width="256" />
</p>

[![Build](https://github.com/mikenakis/MikeNakis.CommonFiles/actions/workflows/github-workflow.yml/badge.svg)](https://github.com/mikenakis/MikeNakis.CommonFiles/actions/workflows/github-workflow.yml)

This project compiles into a nuget package which supplies the following files to projects that reference it:

- `.editorconfig`
- `AllCode.globalconfig`
- `ProductionCode.globalconfig`
- `TestCode.globalconfig`

The new files appear in a subdirectory called `MikeNakisCommonFiles` under the project directory, and they are all read-only.

The package also supplies a `MikeNakisCommonFiles` property which points to the directory where the supplied files are 
located, so they can be included as follows:

```xml
<ItemGroup>
	<!-- PEARL: If any .globalconfig files are not found, we get silent failure. -->
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisCommonFiles)AllCode.globalconfig" />
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisCommonFiles)ProductionCode.globalconfig" />
</ItemGroup>
```

Unfortunately, the `.editorconfig` file _**cannot**_ be included like that, so it is (automatically) copied from 
`MikeNakisCommonFiles` into the project directory. The copy is writable, so be careful not to modify it because any 
edits you make to it will be lost next time the package is restored.

## License

See [LICENSE.md](LICENSE.md)
