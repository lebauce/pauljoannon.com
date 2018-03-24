---
title: Du F# dans Godot Engine
date: 2018-03-24
tags: gamedev, programmation
description: Depuis la sortie de sa version 3, le moteur de jeu Godot permet d'écrire ses scripts en C#. Mais ce qu'on veut vraiment c'est écrire du F#.
---

Depuis la sortie de sa version 3, le moteur de jeu [Godot](https://www.godotengine.org/) permet d'écrire ses scripts en C# grâce à Mono. Aussi cool que ça puisse être, ce que le peuple veut vraiment c'est écrire tout ça en F#. Et bien avec un tout petit peu de bidouille, c'est complètement possible.  
Voilà comment je m'y prend.

<!--more-->

Première étape, créer un projet dans Godot et y créer un nœud (ici `TestLabel`) auquel est attaché un script C#.  
En créant ce script, les fichiers de projet C# seront créés (en l'occurrence `Foo.csproj` et `Foo.sln`).

![](/content/blog/2018/03/godot-1.jpg)

Le script en question est le plus simple possible&nbsp;:

```C#
using Godot;

public class TestLabel : Label
{
}
```

Deuxième étape, créer un projet F#.  
En ouvrant `Foo.sln` dans un IDE ça ne devrait pas poser trop de problème. Deux choses importantes&nbsp;: le projet doit être de type `Library` et le framework cible doit être `.NET Framework 4.5` (le même framework cible que le projet C# en fait).  
Il faut ensuite y ajouter une référence vers `GodotSharp.dll` qui se trouve dans le dossier du projet Godot sous `.mono/assemblies/`.  
En résumé, le fichier `.fsproj` devrait ressembler à ça&nbsp;:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <OutputType>Library</OutputType>
    <OutputPath>.mono/temp/bin/$(Configuration)</OutputPath>
    <RootNamespace>Foo.FSharp</RootNamespace>
    <AssemblyName>Foo.FSharp</AssemblyName>
    <TargetFrameworkVersion>v4.5</TargetFrameworkVersion>
    <BaseIntermediateOutputPath>.mono/temp/obj</BaseIntermediateOutputPath>
    <IntermediateOutputPath>$(BaseIntermediateOutputPath)/$(Configuration)</IntermediateOutputPath>
  </PropertyGroup>
  <ItemGroup>
    <Compile Include="TestLabel.fs" />
  </ItemGroup>
  <ItemGroup>
    <Reference Include="GodotSharp">
      <HintPath>$(ProjectDir)/.mono/assemblies/GodotSharp.dll</HintPath>
      <Private>False</Private>
    </Reference>
    <Reference Include="GodotSharpEditor" Condition=" '$(Configuration)' == 'Tools' ">
      <HintPath>$(ProjectDir)/.mono/assemblies/GodotSharpEditor.dll</HintPath>
      <Private>False</Private>
    </Reference>
  </ItemGroup>
  <Import Project="$(MSBuildBinPath)\..\..\..\Microsoft F#\v4.0\Microsoft.FSharp.Targets" />
</Project>
```

Troisième étape, le projet C# d'origine doit avoir connaissance du nouveau projet F#. Je le référence donc dans `Foo.csproj`.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    ...
    <ItemGroup>
      <ProjectReference Include="Foo.fsproj" />
    </ItemGroup>
    ...
</Project>
```

À partir de maintenant, chaque compilation du projet Godot entraînera aussi une compilation du projet F#. C'est presque bon&nbsp;!  

La dernière étape c'est écrire mon code F#.

```Fsharp
namespace Foo.FSharp
#light

open Godot

type TestLabel() =
    inherit Label()

    override this._Ready() =
        do GD.Print "Cool, du F# !"
```

Et faire en sorte que le script que j'ai assigné précédemment à mon nœud hérite de mon type F#.

```C#
using Godot;

public class TestLabel : Foo.FSharp.TestLabel
{
}
```

Rien besoin de plus, tout fonctionne au top et la douceur du F# s'offre à moi&nbsp;!

![](/content/blog/2018/03/godot-2.jpg)
