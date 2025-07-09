# HelloWorld Clean console application build using `nitrile`

This is a Clean example project that uses a Clean distribution installed with the
`nitrile` tool. The project includes a simple “Hello, World!” console application,
but it can also serve as a template for building other projects using `nitrile`.

There is also a similar repository where we build the same HelloWorld Clean code
using the 'classic' Clean distribution from https://clean.cs.ru.nl/ at
https://github.com/harcokuppens/clean-classic-helloworld.git which uses a Clean
project file which is build using a project manager tool `cpm` instead of with
`nitrile build`. We can also open this Clean project file with the CleanIDE giving us
an advanced editing and building tool for Clean projects.

Compared to the 'classic' Clean distribution, the nitrile tool gives you a modern way
to install the Clean compiler/runtime and its libraries as versioned packages from an
online package repository. Everything is versioned, allowing you to rebuild your
project with the exact same version of compiler/runtime and libraries. The nitrile
repository allows for per library version updates, and gives more easily support for
third party libraries.

In this example project we extended nitrile to also generate a Clean project file
from the nitrile project. The Clean project file then gives us then the ability for
more advanced builds with `cpm` or editing with the CleanIDE. The nitrile package
manager gives use a modern way to install the Clean tools and packages. Combining
nitrile with Clean project files gives us the best of both worlds.

**Table of Contents**

<!--ts-->
<!-- prettier-ignore -->
   * [HelloWorld program](#helloworld-program)
   * [Project file](#project-file)
   * [Try out more examples](#try-out-more-examples)
   * [Extended Nitrile commands](#extended-nitrile-commands)
   * [Clean documentation](#clean-documentation)
   * [Essential Resources for Clean Language Development](#essential-resources-for-clean-language-development)
      * [<a href="https://clean-lang.org" rel="nofollow">Clean-Lang.org</a>](https://clean-lang.org)
      * [<a href="https://cloogle.org/" rel="nofollow">Cloogle.org</a>](https://cloogle.org/)
      * [<a href="https://clean-and-itasks.gitlab.io/nitrile/" rel="nofollow">Nitrile documentation</a>](https://clean-and-itasks.gitlab.io/nitrile/)
      * [<a href="https://top-software.gitlab.io/clean-lang/" rel="nofollow">Guides and hints to work with the Clean</a>](https://top-software.gitlab.io/clean-lang/)
   * [Setup Development environment](#setup-development-environment)
      * [Pre-setup DevContainer in VsCode](#pre-setup-devcontainer-in-vscode)
      * [Local installation](#local-installation)
         * [Quick : nitrile for x64 Linux and x64 Windows](#quick--nitrile-for-x64-linux-and-x64-windows)
         * [More details](#more-details)
         * [IDE support on local machine](#ide-support-on-local-machine)
   * [Cpm](#cpm)
      * [Cpm build on Linux/Windows with x64 architecture](#cpm-build-on-linuxwindows-with-x64-architecture)
      * [Cpm build using wine on MacOS/Linux for both x64 and ARM](#cpm-build-using-wine-on-macoslinux-for-both-x64-and-arm)
   * [Classic Clean IDE](#classic-clean-ide)
      * [Navigation tips](#navigation-tips)
      * [Important](#important)
   * [Installation details](#installation-details)
      * [The Eastwood language server for vscode](#the-eastwood-language-server-for-vscode)
         * [use the Eastwood language server for vscode locally on x64 based Linux](#use-the-eastwood-language-server-for-vscode-locally-on-x64-based-linux)
      * [Platforms nitrile supports](#platforms-nitrile-supports)
   * [License](#license)
<!--te-->

## HelloWorld program

The HelloWorld program asks for you name and prints 'Hello NAME'. In the example we
also added some debug trace expressions to show how you can debug your programs with
tracing. For details about debugging see the document
[Debugging in Clean](./Debugging.md). To demonstrate tracing in more detail we also
include the alternative Clean program `HelloWorldDebug.icl`.

The Helloworld project has as dependency the nitrile meta package
[`clean-platform`](https://clean-lang.org/pkg/clean-platform/) which installs for you
many of the standard libraries coming with the classic Clean distribution. This
dependency includes too much, but is convenient when starting developing. Later when
releasing your project you can fine tune the dependencies to the specific nitrile
packages really required.

The source of the Helloworld project is located in the `src/` folder, and it uses
libraries of the nitrile Clean distribution installed in the project's
`nitrile-packages/` subfolder. You do not need to install any packages/dependencies
to build the project, because all libraries are automatically installed in the
`nitrile-packages/` folder. As developer you can easily browse and inspect the
libraries there within your project folder.

Nitrile is both a package manager as a build tool for Clean projects.

To build the project you first have to setup the
[Clean development environment](#setup-development-environment).

Then you need to fetch the dependencies of your nitrile packages:

```bash
$ nitrile update   # updates the registry of available packages
$ nitrile fetch    # installs the required packages described in nitrile.yml
                   # as dependencies in the local nitrile-packages/ folder
$ nitrile build    # builds the Clean project
```

Note that nitrile also installs the Clean compiler as one of its required packages in
the project. Then the `nitrile build` command can use it to build the project. So
both the tools as the libraries in the project are versioned in nitrile packages.

Finally you can build the project with nitrile:

```bash
$ nitrile build    # builds the Clean project
```

and then the result will be build in the project's `bin/` folder which you then can
execute directly:

```bash
$ ./bin/HelloWorld
usage: HelloWorld  NAME
Execution: 0.00  Garbage collection: 0.00  Total: 0.00
$ ./bin/HelloWorld you
("DEBUG:1: name", "you")
Hello you
("DEBUG:2: argv",{"./bin/HelloWorld","you"})
65536
Execution: 0.00  Garbage collection: 0.00  Total: 0.00
```

Instead of nitrile, you can use cpm as build tool which is explained in the next
section.

## Project file

The best way to configure and build your project is by using project files with
either `cpm` or
[the Clean IDE on Windows](doc/2001_UserManual_Clean_IDE_for_Windows.pdf).

You can create a Clean project file for your nitrile project using the commands:

```bash
$ source env.bash  #  set the extended nitrile commands in your PATH
$ nitrile-create-prj-file  HelloWorld
```

which generates a `HelloWorld.prj` Clean project file for the project.

Then you can build the project with cpm:

```bash
$ nitrile-install-cpm  # by default cpm is not installed. This command only needs to be run once.
$ cpm HelloWorld.prj   # build project with result in ./bin/HelloWorld
$ ./bin/HelloWorld
usage: HelloWorld  NAME
```

The project file initially contains only Global and MainModule settings. When you
compile the project with the project manager then ProjectModules settings are added
containing settings for each module needed to build the project. Using the project
file we can the apply settings specific for a module.

Because it is so easy to recreate the project from you nitrile project it is best
practice to put the `.prj` extension in `.gitignore` and just recreate the project
file when cloning the repository on a new location. The `nitrile.yml` file is
leading.

Using a text editor we can easily change project settings in this project file. Most
values are either a boolean 'True' or 'False', or an integer. Only for two
configuration files you need to know the possible values it can have:

- the field 'Application -> Output -> Output' can have values:
  - BasicValuesOnly - Show only basic values without constructors.
  - NoReturnType - Disable displaying the result of the application.
  - NoConsole - No console (output window) for the program will be provided and the
    result of the Start function will not be displayed
  - ShowConstructors - Show values with constructors.
- the field 'Application -> Output -> Module -> Compiler -> ListTypes' can have
  values:
  - NoTypes - No type or strictness information is displayed
  - InferredTypes - Listing only the inferred types. Strictness information is not
    displayed.
  - StrictExportTypes - The types of functions that are exported are displayed
    including inferred strictness information, but only when the type in the
    definition module does not contain the same strictness information as was found
    by the strictness analyser. This way it is easy to check for all functions if all
    strictness information is exported.
  - AllTypes - The types of all functions including strictness information are
    displayed.

You can also edit the project easily with a GUI interface on Windows using the Clean
IDE, see the
[User Manual for Clean IDE on Windows](doc/2001_UserManual_Clean_IDE_for_Windows.pdf).

## Try out more examples

In the examples subfolder are some examples from the classic Clean distribution which
can also be tried out instead of `HelloWorld.icl`. You need to copy the `.icl` file
from the examples folder to the src folder, and adapt the `main` name in the
`nitrile.yml` file. It could be that you need to apply a small modification to the
source, because nitrile may have the modules little bit different organized in
nitrile packages, then in the classic Clean distribution.

## Extended Nitrile commands

On https://clean-lang.org/about.html it says :

    Nitrile is a package manager and build tool for Clean.
    It is used to manage dependencies, interact with the package
    registry, and build applications.

However when I look at the commands that nitrile supports it misses commands to list
the packages installed in the project, to search for a package, to get info about a
package and to install or uninstall a package.

Therefore in the folder bin-nitrile/ I added the following commands to add this
missing functionality to nitrile:

    nitrile-version   - list the version of nitrile and the version of the
                        clean compiler,runtime,lib,stdenv,code-generator,clm
    nitrile-cleanup  -  Cleanup project and optionally the clean distribution
                        installed in the nitrile-packages/ folder in the project.
    nitrile-list      - list packages installed in the current project
                        with their version numbers
    nitrile-registry  - list packages in the registry with their
                        latest version numbers
    nitrile-search    - search for package in the registry using a search term
    nitrile-info      - display information about a package
    nitrile-install   - install a package, when version is omitted,
                        the latest version is installed
    nitrile-uninstall - uninstall a package, the installed version is uninstalled
    nitrile-get       - download package
    nitrile-eastwood  - generate Eastwood.yml file for the current project
    nitrile-root      - determine the root directory of the nitrile project
    nitrile-target    - determine the target platform for the nitrile package manager

For using project files with cpm or the CleanIDE we added the following commands:

    nitrile-create-prj-file     - Create a project file for the current nitrile project
    nitrile-install-cpm         - Install the Clean project manager (cpm) tool.
    wine-cpm                    - Run the windows cpm tool using wine
    nitrile-install-cleanide    - Install the CleanIDE.
    cleanide                    - Run the windows CleanIDE native(Windows) or using wine(Linux/Macos)

## Clean documentation

- For an introduction to functional programming in Clean read the book
  [Functional Programming in Clean](doc/2002_Functional_Programming_in_Clean.pdf)
- The ideas behind Clean and its implementation on sequential and parallel machine
  architectures are explained in detail in the following textbook:
  [Functional Programming and Parallel Graph Rewriting](doc/1993_Functional_Programming_and_Parallel_Graph_Rewriting.pdf)
- A description of the syntax and semantics of Clean can be found in the
  [Clean Language Report](doc/2021_CleanLanguageReport_Version3.0.pdf). The latest
  version can be found online at https://cloogle.org/doc/ .
- [Clean for Haskell programmers](2024_Clean_for_Haskell_Programmers.pdf)
- [A Concise Guide to Clean StdEnv (standard library)](doc/2018_ConciseGuideToClean3xStdEnv.pdf)

## Essential Resources for Clean Language Development

The Clean Language ecosystem offers several valuable resources for developers. Here's
a breakdown of key websites and their functionalities:

### [Clean-Lang.org](https://clean-lang.org)

This website is your central hub for **Nitrile package management**.

- **Package Registry**: Find and browse a comprehensive
  [registry of Nitrile packages](https://clean-lang.org/).
- **Installation Guide**: Learn how to install Clean Nitrile on the
  [About page](https://clean-lang.org/about.html).
- **Package Information**:
  - **Website**: Get detailed information about specific packages at
    `https://clean-lang.org/pkg/$PACKAGE/`. (e.g.
    [`clean-platform`](https://clean-lang.org/pkg/clean-platform/)).
  - **JSON API**:
    - **All Packages**: Access a JSON registry of all packages at
      `https://clean-lang.org/api/packages`. This is the same URL `nitrile update`
      uses to fetch the registry.
    - **All Packages with Full Metadata & Dependencies**: Retrieve comprehensive
      information, including full metadata and dependencies, from
      `https://clean-lang.org/api/packages?with_full_metadata=true&with_dependencies=true`.
    - **Single Package**: Get JSON information for a specific package at
      `https://clean-lang.org/api/packages/$PACKAGE`. (e.g.
      [`clean-platform`](https://clean-lang.org/api/packages/clean-platform))

### [Cloogle.org](https://cloogle.org/)

Cloogle is your go-to for **searching and browsing Clean Language source libraries
and common problems**.

- **Source Library Search**: Easily [search](https://cloogle.org/) through Clean
  Language source code.
- **Common Problems**: Cloogle also helps you find solutions to common problems, with
  the problem information sourced from
  [`https://gitlab.com/cloogle/common-problems`](https://gitlab.com/cloogle/common-problems).
- **Browse Source Code**: Explore Clean Language source code directly at
  [`https://cloogle.org/src`](https://cloogle.org/src).

### [Nitrile documentation](https://clean-and-itasks.gitlab.io/nitrile/)

Documentation website of the Nitrile tool for Clean.  
Nitrile is a package manager and build tool for Clean. It is used to manage
dependencies, interact with the package registry, and build applications.

### [Guides and hints to work with the Clean](https://top-software.gitlab.io/clean-lang/)

This website contains a collection of guides and hints to work with the Clean
programming language.

## Setup Development environment

There are multiple ways to setup your development environment:

- using a pre-setup devcontainer, this gives you

  - a quick start in developing,
  - nice Clean language support in vscode, and
  - you can run it on all platforms.

- using a local installation of Clean

  - no docker needed, but you must do the installation
  - use the vscode editor for Clean, however it must be noted that the language
    server for Clean is currently only available for Linux
  - use the classic CleanIDE. The CleanIDE is a Windows application but can also be
    run with wine on Linux and MacOS.

The `nitrile` tool is both a package manager and a build tool (using `clm` inside).
When using `nitrile` as package manager, we then have a choice in build tool:

- `cpm`\
   In all development environments we always can build the project with the `cpm`
  commandline tool.
- `nitrile`\
   Only on a local x64 Linux/Windows and the devcontainer(x64 Linux) we can use
  `nitrile` for building the project. Building locally with `nitrile` on MacOS is not
  supported.

For editing you can use VsCode or the CleanIDE.

For getting started quickly with support on all platforms we advice to use the vscode
devcontainer, however this quick start assumes that you already have docker
installed, otherwise it might be faster to just do a local installation.

VsCode is a more modern editor giving you all new features, but the classic CleanIDE
gives better language support. So probably you can use both tools and use each for
what they are better in.

### Pre-setup DevContainer in VsCode

**Quick**

- open a bash shell. For Windows install https://gitforwindows.org and run "Git
  Bash".
- run:

  ```bash
  git clone https://github.com/harcokuppens/clean-nitrile-helloworld
  cd clean-nitrile-helloworld
  code .
  ```

- when vscode opens then say yes to "open devcontainer" dialog
- then open a Terminal within vscode and run:

  - for a nitrile build
    ```bash
    nitrile build
    bin/HelloWorld
    ```
  - for a cpm build
    ```bash
    source env.bash                       # needs to be done only once (per shell)
    nitrile-install-cpm                   # needs to be done only once
    nitrile-create-prj-file  HelloWorld   # needs to be done only once
    cpm HelloWorld.prj
    bin/HelloWorld
    ```

- In vscode you can edit the code with the following features::
  - syntax highlighting
  - jump to definition or declaration
  - autocomplete
  - automatic underlining of problematic code
- Note we assumed here that Docker and VsCode are already installed.

**More details**

This project can be used using a devcontainer which automatically setups a
development environment with a 'nitrile' clean installation from
https://clean-lang.org/ for you in a docker container from which you can directly
start developing with vscode with nice Clean language support. For installation
instructions see the
[VSCode Development Environment Installation Guide](./DevContainer.md) Please note
that the devcontainer is built specifically for the `x64` architecture. Nevertheless,
it works seamlessly on Mac and Windows machines with the `ARM64` architecture thanks
to Docker Desktop’s support for `QEMU` emulation for `ARM64`.

### Local installation

You offcourse can use this project also direclty on your local machine by installing
Clean from https://clean.cs.ru.nl/ yourself.

#### Quick : nitrile for x64 Linux and x64 Windows

- open a bash shell. For Windows install https://gitforwindows.org and run "Git
  Bash".
- run:

  - install nitrile using instructions from https://clean-lang.org/about.html#install
    \
    note: nitrile only supports x64 Linux and x64 Windows

    **IMPORTANT**: on platforms where nitrile is not supported, however using a trick
    you can still fetch the windows nitrile libraries and build a nitrile project
    using cpm on wine. See
    [Cpm build using wine on MacOS/Linux for both x64 and ARM](#cpm-build-using-wine-on-macoslinux-for-both-x64-and-arm).

  - clone project

    ```bash
    git clone https://github.com/harcokuppens/clean-nitrile-helloworld
    cd clean-nitrile-helloworld
    ```

  - fetch dependencies for project using nitrile

    ```bash
    nitrile update   # updates the registry of available packages
    nitrile fetch    # installs the required packages described in nitrile.yml
                       # as dependencies in the local nitrile-packages/ folder
    ```

  - build

    - with nitrile

      ```bash
      nitrile build
      bin/HelloWorld
      ```

    - with cpm

      ```bash
      source env.bash                       # needs to be done only once (per shell)
      nitrile-install-cpm                   # needs to be done only once
      nitrile-create-prj-file  HelloWorld   # needs to be done only once
      cpm HelloWorld.prj
      bin/HelloWorld
      ```

We also have instructions for building locally building nitrile projects using cpm:

- [Cpm build on Linux/Windows with x64 architecture](#cpm-build-on-linuxwindows-with-x64-architecture)
- [Cpm build using wine on MacOS/Linux for both x64 and ARM](#cpm-build-using-wine-on-macoslinux-for-both-x64-and-arm)

#### More details

- nitrile only supports x64 Linux and x64 Windows; see
  [Platforms nitrile supports](#platforms-nitrile-supports)
- to install nitrile see https://clean-lang.org/about.html#install .
- see also the getting started nitrile documentation at
  https://clean-and-itasks.gitlab.io/nitrile/intro/getting-started/
- by running in a bash shell

       source env.bash

  you add the `bin-nitrile` to your path with `export PATH=$PWD/bin-nitrile:$PATH` \
  This gives you access to the extra nitrile commands in this project.\
  We assume however here that you have a bash shell, because the scripts in
  `bin-nitrile` are bash scripts. To use them on Windows use the
  https://gitforwindows.org installation which comes with a 'Git Bash' application to
  open a bash shell.

- in vscode the Eastwood language server gives language support for the Clean
  language. However the
  [Eastwood language server nitrile package](https://clean-lang.org/pkg/eastwood/) is
  only available for Linux. So only on Linux vscode has support for the Clean
  language.\\ This is probably caused by the focus on the devcontainer running Linux.

#### IDE support on local machine

- **VsCode with Clean extension**\
   only on x64 based Linux you can
  [use vscode with Clean language support locally](#use-the-eastwood-language-server-for-vscode-locally-on-x64-based-windows-or-linux)\
  Note: nitrile is also available on Windows, however currently there is no Eastwood package
  for Windows, so currently only x64 Linux is supported. For other platforms you just
  must use the VsCode devcontainer.
- **classic Clean IDE**\
  the classic CleanIDE can be run on all platforms (using Wine on linux/MacOS) and gives
  better language support then the language server in vscode.

The VsCode editor is a more modern editor giving you all new features, but the
classic CleanIDE gives better language support. So probably you can use both tools
and use each for what they are better in.

## Cpm

Nitrile is great for installing dependencies, however instead of building with
nitrile one can better create a Clean project file for your nitrile project for the
following reasons:

- allows you to configure the project at module level
- with the cpm command line tool you can build the project without needing nitrile.
  This gives you separations of concerns:
  - nitrile as package manager
  - cpm as build tool
- you can use the CleanIDE which gives you a very good IDE for developing Clean
  projects. The Clean IDE is a better IDE then using vscode. E.g. looking up
  definitions or declarations in the Clean IDE works flawless whereas when using the
  language server in vscode does a grep on strings which gives many negative matches.
  Off course you can also use both tools next to each other!

### Cpm build on Linux/Windows with x64 architecture

To start developing your project with a project file:

1.  clone repo and setup environment in bash shell

          git clone https://github.com/harcokuppens/clean-nitrile-helloworld
          cd clean-nitrile-helloworld
          source env.bash

2.  optionally clean any old nitrile builds/installation

          nitrile-cleanup --all

3.  first fetch all nitrile libs for current platform

          nitrile update

    and then

          # for windows or linux (arch x64)
          nitrile fetch

4.  install cpm for current platform

          # for windows or linux (arch x64)
          nitrile-install-cpm

5.  then create a project file for the nitrile project

         # for windows or linux (arch x64)
         nitrile-create-prj-file  HelloWorld

6.  then build

         # for windows or linux
         cpm HelloWorld.prj

    which builds an executable at

         bin/HelloWorld

### Cpm build using wine on MacOS/Linux for both x64 and ARM

On MacOS nitrile, or Linux with ARM architecture Nitrile is not supported, but you
can build and develop a nitrile project as a windows project in wine. You then build
a windows executable which you also execute with wine.

To start developing your project with a project file:

0.  first install wine

    on Macos you can install wine with homebrew

          brew install wine-stable

    for Linux you can install wine with your specific Linux platform's package
    manager.

1.  clone repo and setup environment in bash shell

          git clone https://github.com/harcokuppens/clean-nitrile-helloworld
          cd clean-nitrile-helloworld
          source env.bash

2.  optionally clean any old nitrile builds/installation

          nitrile-cleanup --all
          # note: this script does not depend on the nitrile command

3.  first fetch all nitrile libs for windows-x64 platform

    On x64 Linux nitrile is supported, so we can run the following commands there to
    install the nitrile libs for windows-x64 platform:

           nitrile update
           nitrile fetch  --platform=windows --arch=x64

    Nitrile is not supported, on MacOS or Linux with ARM architecture, but you can
    still build and develop a nitrile project as a windows project in wine.
    Installing nitrile on wine is difficult, however we have a trick: use the linux
    nitrile in docker to install the nitrile libraries for windows, and then build
    with the windows cpm tool. We can then build a nitrile project without needing
    the nitrile executable.

    Two ways to apply this trick:

    1.  open the project in vscode, and then open it in a devcontainer. The
        devontainer runs a linux in docker which comes with the linux version of
        nitrile. With the linux nitrile command you can then fetch the Windows
        nitrile libraries in the binded mounted project directory with the command:

            nitrile update
            nitrile fetch  --platform=windows --arch=x64

    2.  or you can do this also directly without launching the devcontainer in vscode
        with the docker command:

            docker run -w /workspace --mount type=bind,src="$(pwd)",target=/workspace \
              cleanlang/nitrile  bash -c "nitrile update && nitrile  fetch --platform=windows --arch=x64"

        which is also run by the special nitrile command:

            nitrile-in-docker-fetch-windows-libs

4.  install cpm for windows

          # for windows or linux (arch x64)
          nitrile-install-cpm --platform windows --arch x64

5.  then create a project file for the nitrile project, where we explicitly have to
    specify the windows platform with x64 architecture, because otherwise it tries to
    create a project for the current MacOS platform.

         # for wine (for cpm/cleanide mac or cleanide on linux)
         nitrile-create-prj-file -p windows -a x64 HelloWorld
         # note: this script does not depend on the nitrile command

6.  finally build

         # building project with wine on MacOS
         wine-cpm  HelloWorld.prj

    which builds an executable at

         bin/HelloWorld.exe

    which you can run with wine:

         wine bin/HelloWorld.exe

## Classic Clean IDE

The CleanIDE is only available on Windows, however using wine you can nowadays run it
fine on MacOS.

Using wine on Linux it works ok, but not perfect. For example under linux when you
run a console application, then it doesn't open a console, but instead the console
output goes to the terminal which launches the CleanIDE. Also there are problems with
4k monitors, where everything is shown very small. I find this pretty annoying.

Below we describe per operating system how to use the CleanIDE:

- for Windows: follow the steps for
  [building the project with cpm](#cpm-build-on-linuxwindows-with-x64-architecture).
- for MacOS/Linux: follow the steps for
  [building the project with cpm using wine](#cpm-build-using-wine-on-macoslinux-for-both-x64-and-arm)

Then you only need to install the CleanIDE in your project

          nitrile-install-cleanide

and you can directly run it with the following commands:

          cleanide HelloWorld.prj

within the CleanIDE you can build and run the project.

For MacOS we even created an
[`CleanIDE.app`](https://github.com/harcokuppens/CleanIDE-wine-app-MacOS/releases/latest/download/CleanIDE.dmg)
which in the background runs the `CleanIDE.exe` with wine for you. It requires the
`wine-stable` package to be installed with HomeBrew. Using this app you can open
`.prj`,`dcl`, and `.icl` files from the Finder. For more details about `CleanIDE.app`
see
[CleanIDE-wine-app-MacOS](https://github.com/harcokuppens/CleanIDE-wine-app-MacOS).

### Navigation tips

The following shortcuts make navigation your source code in the IDE much easier:

**`Ctrl`+`double-click-word`**:\
&emsp; searches for definition of word in project

**`Shift`+`Ctrl`+`double-click-word`**:\
&emsp; searches for implementations of word in project

**`select-word`** then press **`CTRL-=`**:\
&emsp; searches for usage of word as identifier in the project

**`no-selection`** then press **`CTRL-=`**:\
&emsp; generic search menu for identifier/declaration/definition in the project\
&emsp; By default shows last searched value in search box.

**`select-module-name`** then press **`CTRL-D`**:\
&emsp; opens this definition module

**`select-module-name`** then press **`CTRL-I`**:\
&emsp; opens this implementation module

**`CTRL-/`**:\
&emsp; toggle between implementation and definition module of the current module

For more details read the
[User Manual for Clean IDE on Windows](doc/2001_UserManual_Clean_IDE_for_Windows.pdf)

### Important

- Due to Wine limitations the MacOS application always launches a new Clean IDE
  instance when opening a `.prj`, `.icl`, or `.dcl` file.
- MacOS adds extra protection, called TCC, to some folders in your home directory,
  eg. ~/Desktop ~/Documents. When opening a Clean file from one of these specially
  protected folders you have to many times allow the same permission. Somehow the
  permission does not stick in wine. This is annoying. A good work around is by not
  putting your Clean project in such protected folder.

  Instead of putting your CleanIDE project in:

        ~/Documents/CleanIDE_Projects/MyProject

  Put it in:

        ~/CleanIDE_Projects/MyProject

- Remember that Wine is not perfect. Some Windows API's are not good implemented. For
  example, on wine on MacOS, the project `examples/PlatformExamples/IPLookup.prj`
  builds in the CleanIDE and runs, but does print the empty string. When you install
  the MacOS version of Clean and build it with the commandline using `cpm` then it
  works fine!

## Installation details

### The Eastwood language server for vscode

Only on x64 based Linux you can use vscode with the Eastwood language server locally.
Therefore this project provides a ready-to-use environment for developing Clean
applications using Docker development container via a devcontainer, so that you can
develop clean on all platforms.

The development container (devcontainer) uses Nitrile to install the Eastwood
language server. The Eastwood language server is compatible with all Clean projects,
regardless of whether Clean was installed via Nitrile or directly from the Clean
website https://clean.cs.ru.nl/. For compiling this project, the `nitrile`
command-line tool is used. The Eastwood language server provides

- autocomplete,
- error-checking (diagnostics), linting
- jump-to-definition or declaration

The HelloWorld project comes with an already configure `Eastwood.yml` configuration
file, which specifies all libraries in the the nitrile meta package
[`clean-platform`](https://clean-lang.org/pkg/clean-platform/) so they are available
in the Eastwood language server in vscode.

The `Eastwood.yml` configuration file is automatically generated using the command

```
nitrile-eastwood  - generate Eastwood.yml file for the current project
```

The `nitrile-eastwood` command looks at your nitrile project configuration to get all
project dependencies to make a list of lib paths for in the `Eastwood.yml`
configuration file. If you change your nitrile project configuration then also run
`nitrile-eastwood` to update Eastwood's configuration.

Please note that the devcontainer is build specifically for the `x64` architecture.
Nevertheless, it works seamlessly on Mac and Windows machines with the `ARM64`
architecture thanks to Docker Desktop’s support for `QEMU` emulation for `ARM64`.

#### use the Eastwood language server for vscode locally on x64 based Linux

You have to first [install nitrile](https://clean-lang.org/about.html#install), then
install eastwood with nitrile with the command 'nitrile global install eastwood'.

Note that the
[Eastwood language server nitrile package](https://clean-lang.org/pkg/eastwood/) is
only available for Linux, and not for Windows, so unfortunately Windows is not
supported.

Then finally you can install the
["Clean" extension in vscode](https://marketplace.visualstudio.com/items?itemName=TOPSoftware.clean-vs-code).
If you then open this project folder with vscode you can edit Clean with the support
of the Eastwood Language Server in vscode.

For Windows also configure that the terminal within vscode uses the bash shell coming
with https://gitforwindows.org by adding the following in the `.vscode/settings.json`
file in your workspace:

```json
{
  "terminal.integrated.profiles.windows": {
    "Git Bash": {
      "path": "C:\\Program Files\\Git\\bin\\bash.exe"
    }
  },
  "terminal.integrated.defaultProfile.windows": "Git Bash"
}
```

### Platforms nitrile supports

The nitrile tool only supports `x64` Clean installations on Linux and Windows.

However `x64` clean builds can be run on none-supported `ARM64` platforms using
emulation. If your project compiles with nitrile a static binary then

- the binary compiled on a `x64` Linux also runs fine on a `ARM64` Linux using QEMU
  emulation for `x64`, and
- the binary compiled on a `x64` Windows also runs fine on a Windows `ARM64` using
  `x64` emulation.

For MacOS there is no nitrile support, so you can only use it using the vscode's
DevContainer. However the 'classic' Clean distribution provides an installation for
x64 MacOS which you can also install on the
[ARM64 Mac](https://github.com/harcokuppens/clean-classic-helloworld#platforms-the-clean-compiler-supports).
The 'classic' Clean distribution also provides an installation for
[ARM64 linux](https://github.com/harcokuppens/clean-classic-helloworld#platforms-the-clean-compiler-supports).

## License

The project is licensed under the BSD-2-Clause license.
