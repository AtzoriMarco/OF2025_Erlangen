# Notes

A copy with all data is available [here](https://www.dropbox.com/scl/fo/831dyn6jb6kzsjlah0osh/AAJBztjOqlOzHatEmytXSHw?rlkey=677lqu8ws7un1pku7a5hx9cik&st=ij3sskru&dl=0) (temporary visualization access to a Dropbox folder).

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
paraFoam -builtin
```

* If you would like to remove grid and solution from a tutorial, and start from scratch, use: 
```
foamCleanTutorials 
```

* Try to change the time derivative to visualize the available options. Use the documentation to find info on methods and guidelines.

## Step 1: example with post processing

Our second tutorial, the also classic "pitzDaily". It is inspired by [Pitz & Daily, 1983](https://doi.org/10.2514/3.8290).

* Copy and run, using the script already provided in the tutorial:

```
cp -r /opt/openfoam13/tutorials/incompressibleFluid/pitzDaily . 
./Allrun
```

* We can try to extend the post processing to extract more informations. Let's check the tutorials folder for incompressible flows, and see examples of other available functions: 

```
tut
cd incompressibleFluid/
grep -r '#includeFunc'
```

Integrate the additional post-processing options, for example:
1. change name of function output.
2. add residuals.
3. add streamlines.
4. add sampling over a plane.
5. add probes.
6. add sampling over a patch.
7. compute the wall shear-stress. 

* We can also use some post-processing utilities (a list is provided [here](https://doc.cfd.direct/openfoam/user-guide-v13/post-processing-functionality#x41-2180007.3)). For instance, let's have a look at: 
```
foamPostProcess -func flowType
```

* Check now if we want to do visualization:


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

We can have a look at other post processing utilities.

Also interesting, for other applications: 
* *forceCoeffs* (from *motorBike*).
* *Q* (from *propeller*).


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

## Step 6: the structure of the code and programming