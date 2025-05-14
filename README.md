# HelloWorld Clean console application build using `nitrile`

This is a Clean example project that uses a Clean distribution installed with the
`nitrile` tool. The project includes a simple “Hello, World!” console application,
but it can also serve as a template for building other projects using `nitrile`.

This project can be used using a devcontainer which automatically setups a
development environment with nitrile and Clean for you in a docker container from
which you can directly start developing. For installation instructions see the
[VSCode Development Environment Installation Guide](./DevContainer.md)

However you offcourse can use this project on your local machine by installing
nitrile and Clean yourself.

- to install nitrile see https://clean-lang.org/about.html#install .
- to use nitrile to install Clean and its libraries, and build Clean projects see
  https://clean-and-itasks.gitlab.io/nitrile/intro/getting-started/

There is also a similar repository where we build the same HelloWorld Clean code
using a clean installation from https://clean.cs.ru.nl/ and build with the `clm` tool
at: https://github.com/harcokuppens/clean-clm-helloworld.git .

## HelloWorld program

The HelloWorld program asks for you name and prints 'Hello NAME'. In the example we
also added some debug trace expressions to show how you can debug your programs with
tracing. For details about debugging see the document
[Debugging in Clean](./Debugging.md).

## License

The project is licensed under the BSD-2-Clause license.
