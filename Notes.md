# Notes

## Let's start

**TODO**: add comments on bashrc and terminal

Environmental variables are loaded (for instance, adding the following string at the end of the *bashrc* file). 

```
alias of13=". /opt/openfoam13/etc/bashrc"
```

A generic idea about how a terminal works, be confortable with standard commands: 
```
cd
mkdir
rm
rm -rf 
cat 
grep
```

## Step 0: the classical beginning

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

If you would like to remove grid and solution to start from scratch, use: *foamCleanTutorials*. 

You can visualize the solution with: *paraFoam -builtin*.

3. We can now have a look at the standard structure of a case, let's explore... **TODO**

## Step 1: example with post processing

Our second tutorial, the classic "pitzDaily":

1. copy and run, with the script provided:

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

One tutorial from our repository. 

Compute yPlus with: 

foamPostProcess -func yPlus -solver incompressibleFluid

## Step 3: code stream and AMR

One tutorial from this repository. 


## Step 4: Examples with multiphase


* We can have a look at:
```
tutorials/multiphaseEuler/fluidisedBed
```

1. 


* We can also have a look at:
```
tutorials/multiphaseEuler/damBreak4phase
```

1.

## Step 5: 

