# OF2025_Erlangen
Material for openfoam tutorial, LSTM, Erlangen, 7-10 October 2025.

Programm:

Tuesday, Oct 7, 9-13: Introduction, Methods, Code, Interface to OpenFOAM, simple meshing, installation, first case.

Wednesday, Oct 8, 9-13: Incompressible flow, "running" (?). postprocessing, statistics, running cases on a cluster, including CPU and GPU version, profiling.

Thursday, Oct 9-13: Including more complex physics: temperature, free surfaces, and particles. 

Friday, Oct 10: discussions and some particular cases.

## Prerequisite

OF13 installed, installation instruction at:

Environmental variables are loaded (for instance, adding the following string to the .bashrc file). 

```
alias of13=". /opt/openfoam13/etc/bashrc"
```

## Step 0

Our first tutorial, the classic (lid-driven) cavity with the legacy solver *icoFoam*. 

1. copy the setup from the tutorial folder ($FOAM_TUTORIALS=/opt/openfoam13/tutorials):

```
cp -r /opt/openfoam13/tutorials/legacy/incompressible/icoFoam/cavity/cavity .
```

2. enter the case folder, create the grid, and run the simulation:

```
cd cavity
blockMesh | tee log.blockMesh
checkMesh | tee log.checkMesh
icoFoam | tee log.icoFoam
```

If you would like to remove grid and solution and start from scratch, use: *foamCleanTutorials*. 

You can visualize the solution with: *paraFoam -builtin*.

## Step 1

Our second tutorial, the classic "pitzDaily":

1. copy and run, with the script provided:

```
cp -r /opt/openfoam13/tutorials/incompressibleFluid/pitzDaily . 
./Allrun
```

2. we can try to extend the postprocessing to extract more informations.


3. 
