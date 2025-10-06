# Notes

A copy of this repository, including all data is available [here](https://www.dropbox.com/scl/fo/831dyn6jb6kzsjlah0osh/AAJBztjOqlOzHatEmytXSHw?rlkey=677lqu8ws7un1pku7a5hx9cik&st=ij3sskru&dl=0) (thi is a link to a Dropbox folder with temporary visualization access).

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
* We can also try to create variables in the terminal, and understand how it can be used to create an "environment" for any software.

* Environment variables for OpenFOAM are loaded with the script in *openfoam13/etc/bashrc*. We can add a line such as: 
```
alias of13=". /opt/openfoam13/etc/bashrc"
```
at the end of our file *~/.bashrc* (do not modify the rest of it).

* We can have a look at the collection of variables and aliases created by OpenFOAM's *.bashrc* script, for instance try using the tab key to autocomplete this command:
```
echo $FOAM_
```
and check:
```
type tut
```

## Step 0: the classical beginning

Our first tutorial, the classic (lid-driven) cavity, with the legacy solver *icoFoam*. 

* copy the setup from the tutorial folder (*$FOAM_TUTORIALS=/opt/openfoam13/tutorials*):

```
cp -r /opt/openfoam13/tutorials/legacy/incompressible/icoFoam/cavity/cavity .
```

* We can now have a look at the standard structure of the case: 

1. in *system*:
- standard input (time step, run time, saving frequency), in *controlDict*.
- discretization schemes for the derivatives in *fvSchemes*.
- solution options for the discretized equations *fvSolution*.
- "dictionaries" for other applications, in this case, *blockMeshDict*. We can have a first look at this one, that is used to create a structured grid.
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

note that *icoFoam* is a legacy solver for the incompressible Navier-Stokes equations, we will focus on the new structure of the code.

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

* Change the time derivative to a random string and try to run *icoFoam* to visualize other the available options (use the documentation to find info on methods).

#### Suggested exercises: 
1. 

## Step 1: example with post processing

Our second tutorial, the also classic "pitzDaily". It is inspired by [Pitz & Daily, 1983](https://doi.org/10.2514/3.8290).

* Copy and run, using the script already provided in the tutorial:

```
cp -r /opt/openfoam13/tutorials/incompressibleFluid/pitzDaily . 
./Allrun
```
* This tutorial uses a Reynolds-Averaged Navier-Stokes (RANS) simulation. Let's identify the corresponding dictionaries and options.

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
#### Suggested exercises: 

## Step 2: snappyHexMesh

* We can have a look at:
```
tutorials/incompressibleFluid/motorBikeSteady
```
This is also one of the "classical" tutorial, but it is not the fastest case to run.  

* Let's start to work with the [USP induction port tutorial](./Step_2_snappyHexMesh/USP_induction_port) in this repository. The full workflow, assuming *.stl* files that describe the geometry are alreaady provided, would be:

1. Create a suitable *blockMeshDict*.
2. Create/modify the *surfaceFeaturesDict* and *snappyHexMeshDict* dictionaries.
3. Create constant and BC files. In this case, let's to run a LES.

The *run.sh* script is added as reference for the list of operations that are necessary. What is the coarsest grid that we can work on? What is the best way of improving it?

* We can also have a look to new post processing. Compute yPlus with: 

```
foamPostProcess -func yPlus -solver incompressibleFluid
```

And create the scalar field used to identified vortexes with the *Q* criterion:

```
foamPostProcess -func Q
```
(The three simulations with higher resolution with the material provided are better suited to use *Q*)

## Step 3: code stream and AMR

* We can now start to have a look at a more complex case.

Let's have a look at:
```
tutorials/incompressibleVoF/rotatingCube
```
this is fairly complex case study and long to run, but we learn that it is possible to:

1. use scripting in dictionaries.
2. use adaptive mesh refiniment.

* We can now have a look at the [small jet tutorial](./Step_3_scripts_and_AMR/small_jet) tutorial. 

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