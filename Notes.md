# Notes

## Let's start

* Let's have a look at some standard commands in the terminal: 
```
cd
mkdir
rm
rm -rf 
cat 
grep
```
* We can also try to create variables in the terminal.

* Environment variables for OpenFOAM are loaded with the script in *penfoam13/etc/bashrc*. We can add a line such as: 
```
alias of13=". /opt/openfoam13/etc/bashrc"
```
at the end of the file *~/.bashrc* (do not modify the rest of it).

## Step 0: the classical beginning

Our first tutorial, the classic (lid-driven) cavity with the legacy solver *icoFoam*. 

* copy the setup from the tutorial folder (*$FOAM_TUTORIALS=/opt/openfoam13/tutorials*):

```
cp -r /opt/openfoam13/tutorials/legacy/incompressible/icoFoam/cavity/cavity .
```

* We can now have a look at the standard structure of the case: 

1. in *system*:
- standard input (time step, run time, saving frequency), in *controlDict*.
- discretization schemes for the derivatives in *fvSchemes*.
- solution options for the discretized equations *fvSolution*.
- "dictionaries" for other applications, in this case, *blockMeshDict*.
2. in *constant*: 
- physical properties.
- set of governing equations / modelling.
3. in *0*: 
- boundary conditions.
- initial conditions.

* After entering the case folder, create the grid and run the simulation:

```
blockMesh | tee log.blockMesh
icoFoam | tee log.icoFoam
```

* Information on the grid can be obtained with:
```
checkMesh | tee log.checkMesh
```

* You can visualize the solution with: 
```
paraFoam -builtin*
```

* If you would like to remove grid and solution from a tutorial, and start from scratch, use: 
```
foamCleanTutorials 
```

* Try to change the time derivative to visualize the available options. Use the documentation to find info on methods and guidelines.

## Step 1: example with post processing

Our second tutorial, the classic "pitzDaily":

* copy and run, with the script provided:

```
cp -r /opt/openfoam13/tutorials/incompressibleFluid/pitzDaily . 
./Allrun
```

2. we can try to extend the post processing to extract more informations. Let's check the tutorials folder for incompressible flows, and see examples of other available functions: 

```
tut
cd incompressibleFluid/
grep -r '#includeFunc'
```

Integrate the additional post-processing options, for example:
* change name of function output.
* add residuals.
* add streamlines.
* add sampling over a plane.
* add probes.
* add sampling over a patch.
* compute the wall shear-stress. 

Also interesting, for other applications: 
* *forceCoeffs* (from *motorBike*).
* *Q* (from *propeller*).

3. Visualization... **TODO**

## Step 2: snappyHexMesh

1. One tutorial from our repository. 

Compute yPlus with: 

```
foamPostProcess -func yPlus -solver incompressibleFluid
```

2. One useful to have a look:

```
tutorials/incompressibleFluid/motorBikeSteady
```

## Step 3: code stream and AMR

One tutorial from this repository. 

Test run:
tutorials/incompressibleVoF/rotatingCube

## Step 4: multiphase


* We can also have a look at:
```
tutorials/multiphaseEuler/damBreak4phase
```

## Step 5: particles

1. We can try:

tutorials/fluid/stackPlume

2. We can try:

tutorials/incompressibleFluid/TJunction

3. We can try (run in parallel)

tutorials/multicomponentFluid/verticalChannel

4. We can try: 

tutorials/incompressibleDenseParticleFluid/cyclone

