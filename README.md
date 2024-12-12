# MikeNakis.AnalysisRules<br><sup><sub>My very own™ code analysis rules for DotNet.</sub></sup>

<!--- Note: This image looks fine in most markdown renderers, 
            but not in Visual Studio, whose built-in markdown renderer is broken nowadays. 
			Someone has brought it to their attention, (https://developercommunity.visualstudio.com/t/10774870)
			and last I checked they were "investigating". -->
<p align="center">
  <img title="MikeNakis.AnalysisRules Logo" src="MikeNakis.AnalysisRules-Logo.svg" width="256" />
</p>

[![Build](https://github.com/mikenakis/MikeNakis.AnalysisRules/actions/workflows/github-workflow.yml/badge.svg)](https://github.com/mikenakis/MikeNakis.AnalysisRules/actions/workflows/github-workflow.yml)

This package supplies the following files to projects that reference it:

- `.editorconfig`
- `AllCode.globalconfig`
- `ProductionCode.globalconfig`
- `TestCode.globalconfig`

The new files appear in a subdirectory called `MikeNakisAnalysisRules` under the project directory, and they are all
read-only.

The package also supplies a `MikeNakisAnalysisRules` property which points to the directory where the supplied files are 
located, so they can be included as follows:

```xml
<ItemGroup>
	<!-- PEARL: If any .globalconfig files are not found, we get silent failure. Supposedly, 
	     there is a ContinueOnError="ErrorAndStop" attribute, but it makes no difference. -->
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisAnalysisRules)AllCode.globalconfig" />
	<GlobalAnalyzerConfigFiles Include="$(MikeNakisAnalysisRules)ProductionCode.globalconfig" />
</ItemGroup>
```

Unfortunately, the `.editorconfig` file _**cannot**_ be included like that, so it is (automatically) copied from 
`MikeNakisAnalysisRules` into the project directory. The copy is writable, so be careful not to modify it because any 
edits you make to it will be lost next time the package is restored.

It is best to refrain from adding `.editorconfig` to `.gitignore`, so that if you ever change `.editorconfig` you have a
chance to take notice. Even if `.editorconfig` gets accidentally committed, next time the package is restored it will 
appear as modified again, so you have more chances to take notice, and when you do eventually notice that you have been 
losing the changes you have been making to it, you might still be able to find your lost changes in the git commit
history.

## License

See [LICENSE.md](LICENSE.md)
