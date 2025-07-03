# HelloWorld Clean console application build using `nitrile`

This is a Clean example project that uses a Clean distribution installed with the
`nitrile` tool. The project includes a simple “Hello, World!” console application,
but it can also serve as a template for building other projects using `nitrile`.

There is also a similar repository where we build the same HelloWorld Clean code
using the 'classic' Clean distribution from https://clean.cs.ru.nl/ at
https://github.com/harcokuppens/clean-classic-helloworld.git which builds the Clean
code using `clm` directly instead of with `nitrile build` .

Compared to the 'classic' Clean distribution, the nitrile tool gives you a modern way
to install the Clean compiler/runtime and its libraries as versioned packages from an
online package repository. Everything is versioned, allowing you to rebuild your
project with the exact same version of compiler/runtime and libraries. The nitrile
repository allows for per library version updates, and gives more easily support for
third party libraries.

**Table of Contents**

<!--ts-->
<!-- prettier-ignore -->
   * [HelloWorld program](#helloworld-program)
   * [Build project with Nitrile](#build-project-with-nitrile)
   * [Added Nitrile commands](#added-nitrile-commands)
   * [Try out more examples](#try-out-more-examples)
   * [Clean documentation](#clean-documentation)
   * [Essential Resources for Clean Language Development](#essential-resources-for-clean-language-development)
      * [<a href="https://clean-lang.org" rel="nofollow">Clean-Lang.org</a>](https://clean-lang.org)
      * [<a href="https://cloogle.org/" rel="nofollow">Cloogle.org</a>](https://cloogle.org/)
      * [<a href="https://clean-and-itasks.gitlab.io/nitrile/" rel="nofollow">Nitrile documentation</a>](https://clean-and-itasks.gitlab.io/nitrile/)
      * [<a href="https://top-software.gitlab.io/clean-lang/" rel="nofollow">Guides and hints to work with the Clean</a>](https://top-software.gitlab.io/clean-lang/)
   * [Setup Development environment](#setup-development-environment)
      * [Easy develop in DevContainer](#easy-develop-in-devcontainer)
      * [Develop on local machine](#develop-on-local-machine)
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

## Build project with Nitrile

Nitrile is both a package manager as a build tool for Clean projects. To build the
`HelloWorld` project you have to run the following Nitrile commands:

    nitrile update   # updates the registry of available packages
    nitrile fetch    # installs the required packages described in nitrile.yml
                     # as dependencies in the local nitrile-packages/ folder
    nitrile build    # builds the Clean project

Note that nitrile also installs the Clean compiler as one of its required packages in
the project. Then the `nitrile build` command can use it to build the project. So
both the tools as the libraries in the project are versioned in nitrile packages.

The source of the Helloworld project is located in the `src/` folder, and it uses
libraries of the nitrile Clean distribution installed in the project's
`nitrile-packages/` subfolder. You do not need to install any packages/dependencies
to build the project, because all libraries are automatically installed in the
`nitrile-packages/` folder. As developer you can easily browse and inspect the
libraries there within your project folder.

To build the project you first have to setup the
[Clean development environment](#setup-development-environment), and then you only
have to run:

```bash
$ nitrile build
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

## Added Nitrile commands

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

## Try out more examples

In the examples subfolder are some examples from the classic Clean distribution which
can also be tried out instead of `HelloWorld.icl`. You need to copy the `.icl` file
from the examples folder to the src folder, and adapt the `main` name in the
`nitrile.yml` file. It could be that you need to apply a small modification to the
source, because nitrile may have the modules little bit different organized in
nitrile packages, then in the classic Clean distribution.

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

### Easy develop in DevContainer

This project can be used using a devcontainer which automatically setups a
development environment with nitrile and Clean for you in a docker container from
which you can directly start developing with vscode with nice Clean language
support.. For installation instructions see the
[VSCode Development Environment Installation Guide](./DevContainer.md) Please note
that the devcontainer is built specifically for the `x64` architecture. Nevertheless,
it works seamlessly on Mac and Windows machines with the `ARM64` architecture thanks
to Docker Desktop’s support for `QEMU` emulation for `ARM64`.

We advice to use the vscode devcontainer because then you can

- quickly start developing,
- nice Clean language support in vscode, and
- you can run it on all platforms.

### Develop on local machine

However you offcourse can use this project on your local machine by installing
nitrile and Clean yourself.

- nitrile only supports x64 Linux and x64 Windows
- only vscode language server support on Linux, not supported on Windows.\
  Reason: the [Eastwood language server nitrile package](https://clean-lang.org/pkg/eastwood/) is only available for Linux.
- to install nitrile see https://clean-lang.org/about.html#install .
- to use nitrile to install Clean and its libraries, and build Clean projects see
  https://clean-and-itasks.gitlab.io/nitrile/intro/getting-started/
- add `bin-nitrile` to your path with `export PATH=$PWD/bin-nitrile:$PATH` \
  This gives you access to the extra nitrile commands in this project.\
  We assume however here that you have a bash shell, because the scripts in
  `bin-nitrile` are bash scripts. To use them on Windows use the
  https://gitforwindows.org installation which comes with a 'Git Bash' application to
  open a bash shell.
- you can
  [use vscode with Clean language support locally](#use-the-eastwood-language-server-for-vscode-locally-on-x64-based-windows-or-linux)

## Installation details

### The Eastwood language server for vscode

Only on x64 based Linux you can use vscode with the Eastwood language
server locally. Therefore this project provides a ready-to-use environment for
developing Clean applications using Docker development container via a devcontainer,
so that you can develop clean on all platforms.

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

Note that the [Eastwood language server nitrile package](https://clean-lang.org/pkg/eastwood/) is only available for Linux,
and not for Windows, so unfortunately Windows is not supported.

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
