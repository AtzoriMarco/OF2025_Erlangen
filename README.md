# OF2025_Erlangen
Material for openfoam tutorial, LSTM, Erlangen, 7-10 October 2025.

## Programm:
* Tuesday, Oct 7, 9-13: Introduction, Methods, Code, Interface to OpenFOAM, simple meshing, installation, first case.
* Wednesday, Oct 8, 9-13: Incompressible flow, "running" (?). postprocessing, statistics, running cases on a cluster, including CPU and GPU version, profiling.
* Thursday, Oct 9-13: Including more complex physics: temperature, free surfaces, and particles. 
* Friday, Oct 10: discussions and some particular cases.

## Prerequisites

* A Linux environtment, with the openFOAM installed. If you do not have experience with Linux, do not worry, I will provide a introducion that covers what is required for this tutorial. The best way to follow step by step is using a virtual machine (such as [VMware](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) of [VirtualBox](https://www.virtualbox.org/)), with the lastest [Ubuntu](https://ubuntu.com/download/desktop) distrubution installed. A virtual machine is installed as a regular program, it then requires to identify the same image of the operative system that you would use to install it. **Dual booting or a change of operative system is not required nor advised to follow the course**.

* In the setup of the virtual machine, please allocate at least 50 GB of storage, which is on the safe side, and 2 CPUs, which is the minimum to test parallel execution.

* If you are already familiary with Linux, you are free to use what you are confortable with.

* You can also try to use the [Windows Subsystem for Linux (WSL)](https://ubuntu.com/desktop/wsl), if you are so inclined. It creates a Linux environment in Windows, which you can directly without virtual machine, but I will not provide support for it. 

* In the Linux enviroment that you choose, install [OpenFOAM13](https://openfoam.org/download/13-ubuntu/), following the at least the first steps of the installation instructions: 
```
sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt update
sudo apt -y install openfoam13
```
I will comment the section "User configuration" in my introduction.


## Let's start

OF13 installed, installation instruction at: **TODO**

Environmental variables are loaded (for instance, adding the following string to the .bashrc file). 

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
## Note

* This README contains a set of instructions and the case studies. Each case study is included as it is **after** the instructions have been followed, e.g. addining new post-processing operations, and the data removed. It is then recommended to reproduce the instruction in different location than this repository. 

* Tutorials are intended to illustrate some of the capability of the code; requirements to assure imulations yield realistic results, such as those on resolution, domain size, average time, or any other parameter, are not necessary met.  


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

If you would like to remove grid and solution to start from scratch, use: *foamCleanTutorials*. 

You can visualize the solution with: *paraFoam -builtin*.

## Step 1

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

## Step 2

## Step 3


