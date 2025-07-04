
create Clean project working with nitrile libs:



1. set environment in bash shell

     source env.bash

2. optionally clean any old nitrile builds/installation

    nitrile-cleanup --all

1. first fetch all nitrile libs for current platform

        nitrile update

   and then 

        nitrile fetch  --platform=windows
            or 
        nitrile fetch  --platform=linux

2. then create a project file for the nitrile project

        createProject.bash -s src/WrapDebug/ HelloWorld

3. then build

        cpm HelloWorld.prj
