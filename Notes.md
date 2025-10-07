# Notes

A copy of this repository, including all data is available [here](https://www.dropbox.com/scl/fo/831dyn6jb6kzsjlah0osh/AAJBztjOqlOzHatEmytXSHw?rlkey=677lqu8ws7un1pku7a5hx9cik&st=ij3sskru&dl=0) (this is a link to a Dropbox folder with temporary visualization access).

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
note that *icoFoam* is a legacy solver for the incompressible Navier-Stokes equations, we will focus on the new structure of the code. What is the meaning of *tee*?

* Information on the grid can be obtained with:
```
checkMesh | tee log.checkMesh
```

* You can visualize the solution with: 
```
paraFoam -builtin
```
We can also have a better look at the information recorded in the log file and the data structure of a case, in the solution and the *constant/polyMesh* folder (these are not necessarly files that you would work on directly as a regular user). 

* If you would like to remove grid and solution from a tutorial, and start from scratch, use: 
```
foamCleanTutorials 
```

* Change the time derivative to a random string and try to run *icoFoam* to visualize other available options (use the documentation to find info on methods).

#### Suggested exercise: 
The lid-driven cavity is a standard benchmark case, and this is the simplest simulation that we can possibly run... an (attempted) direct numerical simulation! We can try to:
1. Change the grid, working on *blockMesh*.
2. Change the differention with lower or higher order.
3. Establish a suitable measure of the discretization error and find out if it is possible to establish the order of accuracy. What is the best compromise between accuracy and computational cost?
4. Is our solution chaning in time? If so, how and why?
5. What is the Reynolds number of this test case? Try to increase it: how the solution is supposed to change?  

## Step 1: example with post processing

Our second tutorial is the also classic "pitzDaily". It is inspired by [Pitz & Daily, 1983](https://doi.org/10.2514/3.8290).

* Copy from *tut* and run, using the script already provided in the tutorial:

```
cp -r /opt/openfoam13/tutorials/incompressibleFluid/pitzDaily . 
./Allrun
```

* This tutorial uses an ("unsteady") Reynolds-Averaged Navier-Stokes (RANS) simulation. Let's identify the corresponding dictionaries and relevant options that we had selected. 

* We can try to extend the post processing to extract more informations. Let's check the tutorials folder for incompressible flows, and see examples of other available functions: 

```
tut
cd incompressibleFluid/
grep -r '#includeFunc'
```

Integrate the additional post-processing options, for example:
1. Change name of function output.
2. Add residuals.
3. Add streamlines.
4. Add sampling over a plane.
5. Add probes.
6. Add sampling over a patch.
7. Compute the wall shear-stress. 

* We can also use some post-processing utilities (a list is provided [here](https://doc.cfd.direct/openfoam/user-guide-v13/post-processing-functionality#x41-2180007.3)). For instance, let's have a look at: 
```
foamPostProcess -func flowType
```

* We can also make a comparison with: 
```
tutorials/incompressibleFluid/pitzDailySteady
```

#### Suggested exercises: 
We used our first RANS model:
1. What is the meaning of time evolution in this kind of simulation? What is the distinction between *pitzDailySteady* and *pitzDaily*?
2. Find other available turbulence model, test them and discuss how the solution changes.

## Step 2: snappyHexMesh
*BlockMesh* is more flexible than it may initially seem (as we shall see in **Step 3**), but it is not enough to work with complex geometries. The default option for that is *snappyHexMesh*.

* We can have a look at:
```
tutorials/incompressibleFluid/motorBikeSteady
```
This is also one of the "classical" tutorial, but it is not the fastest case to run. It makes a pair with:
```
tutorials/incompressibleFluid/motorBike
```
As for *pitzDaily*, this is by default a set up for an unsteady RANS (URANS), but it also contains a possible dictionaries for large-eddy simulations (LES).

* Let's start to work with the [USP induction port tutorial](./Step_2_snappyHexMesh/USP_induction_port) in this repository, with the intention of preparing a LES. The full workflow, assuming *.stl* files that describe the geometry are alreaady provided, would be:

1. Create a suitable *blockMeshDict*.
2. Create/modify the *surfaceFeaturesDict* and *snappyHexMeshDict* dictionaries.
3. Create constant and BC files. 

The *run.sh* script is added as reference for the list of operations that are necessary. Let's start with a very coarse resolution, and later experiment with different levels of refinements.

* This is the first case for which we will try to run in parallel: note the necessity of the *-parallel* option. 

* We can also have a look to new post processing: 
1. Compute yPlus with: 

```
foamPostProcess -func yPlus -solver incompressibleFluid
```
2. And create the scalar field used to identified vortexes with the *Q* criterion:

```
foamPostProcess -func Q
```
(The three simulations with higher resolution with the material provided are better suited to use *Q*)

#### Suggested exercises: 
We can run a large eddy simulation. Is it always a good idea?
1. Identiy at least one physical quantity that is *only* accessible with LES, and one that is accessible with both RANS and LES, and assess how resolution and other possible simulation parameters influence its measure. When do we reach convergence? And, with respect to what?  
2. How should we define a resolution criteria and design a grid?
3. This is the first case that we run in parallel. Test different decomposition strategies. What is changing with the execution speed?

## Step 3: scripts and AMR
We have seen so far standard incompressible simulations, using inputs file with standard text. OpenFOAM has a number of tools to help the desing of more complex cases, such as including scripts in dictionaries and adaptive mesh refinement (AMR). 

* We start with a (much) more complex case, do not be afraid:
```
tutorials/incompressibleVoF/rotatingCube
```
this is relatively long to run, but we can see multiple new capabilities: 
1. "VoF" stands for "volume of fluid", so this is a multiphase case! We can compare the three standard dictionary in *system* (*controlDict*, *fvSchemes*, and *fvSolution*) to the same files in the tutorials seen so far.  
2. In *Allrun* script, we see a set of initialization operations. We can look for the dictionary corresponding to each application.
3. Looking at the *constant* folder, we see properties of the two different phases, air and water, and the *dynamicMeshDict*, which is being used to carry multiple operations.
4. What is the meaning of the funny line that appears at the beginning of file for boundary and initial conditions?
```
#includeEtc "caseDicts/setConstraintTypes"
```
We can check *$FOAM_ETC*.
5. In the previous tutorials, *blockMeshDict* was used compiling explictitly numerical values. We see here that it can be used defining variables, which reduces the possibility of errors and helps creating more complex grids. 

* **Important!** Just because a collection of capabilties such as this one is shown, do not assume that the implementation of every feature is actually reliable or at the state of the art, or that an OpenFOAM tutorials shows is as it is supposed to be used. Consider tutorials only as the very starting point of a new setup!

* We can now have a look at the [small jet tutorial](./Step_3_scripts_and_AMR/small_jet) tutorial. This is a simpler case than *rotatingCube*, but still quite a bit is going on:
1. In *rotatingCube*, we used a VoF approach with two incompressible flows with constant densities (by the way, even if OpenFOAM likes it, do not use the expression "incompressible fluid" lightly). Here we have certain properties that depend on complex constitutive relation *constant/thermophysicalTransport*. 
2. To set initial conditions, we use another type of "script", the *code stream*. This is more directly link to the structure of the source code than scripting as seen in *blockMeshDict*! (*0/T*)
3. We include the evolution of a scalar field, *s*. Note how it is done using "post-processing" functions, even though it requires initial conditions and setting of appropriate differentiation scheme and solvers.

This tutorial is also used as a starting point to create [this set up with AMR](./Step_3_scripts_and_AMR/small_jet_AMR), which uses *s* as target field. 

* We can now try to add AMR to the tutorial with the USP induction port: you may see that some changes are not immediately obvious. Which field can be used here to guide AMR? (also, I think AMR does not authomtically works well with multiple refinement levels created with *snappyHexMesh*, but let's try!)

#### Suggested exercises: 
AMR is a powerful tool, but not without challenges. Create a workflow to estimate the overhead in computational cost for the AMR simulations of a case of your choice:
1. How can we make a "fair" comparison with a grid that is designed a priori?
2. What is the most effective and more practical usage for AMR? How can we make a trade-off between refinement frequency, rebalance frequency, cost and accuracy?  
3. How do we choose the physical quantity to guide the refinement?

## Step 4: multiphase and structure of solver(s)
We had a look a simulation usinge the VoF solver, we can now have a look at a second way of describing a multiphase flow and take the chance to have a first look at the organization of solvers.

* We start running the tutorial:
```
tutorials/multiphaseEuler/damBreak4phase
```
We see in *controlDict* that the solver option for this tutorial is: 
```
solver          multiphaseEuler;
```
By contrast, the same line for the VoF tutorial *rotatingCube* was:
```
solver          incompressibleVoF;
```
What is the difference between the two? For both, we are using the same executable *foamRun*. Let's start to have a look at the source code.

* Let's start to have a look at the source code: 
```
cd $FOAM_INST_DIR/openfoam13
```
The structure of the folder is as follows:
```
>.  
>├── **0**   
>│   ├── p  
>│   └── U  
>├── **constant**  
>│   └── transportProperties  
>└── **system**  
>    ├── blockMeshDict  
>    ├── controlDict  
>    ├── fvSchemes  
>    └── fvSolution 
```



## Step 5: particles

* Let's first have a look at some tutorials
1. We can try:

tutorials/fluid/stackPlume

2. We can try:

tutorials/incompressibleFluid/TJunction

3. We can try (run in parallel)

tutorials/multicomponentFluid/verticalChannel

4. We can try: 

tutorials/incompressibleDenseParticleFluid/cyclone

## Step 6: the structure of the code and programming