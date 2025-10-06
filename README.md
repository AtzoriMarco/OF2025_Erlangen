# OF2025_Erlangen
Material for openfoam tutorial, LSTM, Erlangen, 7-10 October 2025.

## Program and scope (to be updated):

* Tuesday, Oct 7, 9-13: Introduction, Methods, Code, Interface to OpenFOAM, simple meshing, installation, first case.
* Wednesday, Oct 8, 9-13: Incompressible flow. postprocessing, statistics, running cases on a cluster, including CPU and GPU version, profiling.
* Thursday, Oct 9-13: Including more complex physics: temperature, free surfaces, and particles. 
* Friday, Oct 10: discussions and some particular cases.

## Prerequisites

* A laptop with a Linux environtment. If you do not have experience with Linux, do not worry: I will provide an introducion that covers what is required for this tutorial. The best way to follow step by step is using a virtual machine (such as [VMware](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) of [VirtualBox](https://www.virtualbox.org/)), with the lastest [Ubuntu](https://ubuntu.com/download/desktop) distrubution installed. A virtual machine works as a regular program; it requires the image of the operative system that you would use like emulate, which is the same file that you download to install. In the setup of the virtual machine, please allocate at least 50 GB of storage, which is on the safe side, and 2 CPUs, which is the minimum to test parallel execution. **Dual booting or a change of operative system is not required nor advised to follow the course**.

* If you are already familiary with Linux, you are free to use what you are confortable with.

* You can also try to use the [Windows Subsystem for Linux (WSL)](https://ubuntu.com/desktop/wsl), if you are so inclined. It creates a Linux environment in Windows, which you can directly without virtual machine, but I will not provide support for it. 

* In the Linux enviroment that you choose, install the [OpenFOAM13](https://openfoam.org/download/13-ubuntu/) package, following the at least the first steps of the installation instructions: 
```
sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt update
sudo apt -y install openfoam13
```
I will comment the section "User configuration" of the installation instructions in my introduction. If you are more experienced you can compile it instead of installing as a standard package. 

## Disclaimer & references 

* [Notes.md](Notes.md) contains a set of instructions and the case studies. Each case study is included as it is **after** the instructions have been followed, e.g. addining new post-processing operations, and the data removed. It is then recommended to reproduce the instruction in a location different than this repository, and use it for reference. The paths may differ depending on OF installation.

* Tutorials are intended to illustrate some of the capabilities of the code; requirements to assure simulations yield realistic results, such as those on resolution, domain size, and average time, are typically not met.  

* There is already a copious amount of material available online, sometimes with outdated information on previous version, sometimes referring to alternative OpenFOAM distributions. Although focusing on one distribution is clearly helpful as a beginner, I think the best approach is just being open to change distribution when convinient. Among possible sources that I can recommend: 

1. Everything done by [Prof. Håkan Nilsson](http://www.tfd.chalmers.se/~hani/), but specifically the material of the course [CFD with OpenSource Software](https://www.tfd.chalmers.se/~hani/kurser/OS_CFD/).
2. The material created by ESI (which is now part of Keysight), which is directly maintaining [this distribution](https://www.openfoam.com/news/main-news/openfoam-v2506), for instance the ["3 weeks" series](https://wiki.openfoam.com/index.php?title=%223_weeks%22_series). 
3. The free material of various consultancies, for instance [CFD Direct](https://doc.cfd.direct/openfoam/user-guide-v13/index) and [Wolf dynamics](https://www.wolfdynamics.com/), which is a spin-off of the University of Genoa (a reasonble portion of their material is available).
4. There are text books that refer directly to OpenFOAM, for instance: [The Finite Volume Method in Computational Fluid Dynamics, 2016, Moukalled, Mangani, Darwish](https://link.springer.com/book/10.1007/978-3-319-16874-6), and [Notes on Computational Fluid Dynamics: General Principles, 2022, Greenshields, Weller](https://www.amazon.com/Notes-Computational-Fluid-Dynamics-Principles/dp/1399920782).  

* The material of a previous tutorial I held is [here](https://github.com/AtzoriMarco/tutorialOF) (It uses OpenFOAM7, nothing particulary new can be found there, but we will use one of the exercises). 

* The examples in [Step 3](./Step_3_scripts_and_AMR) have been prepare as the preliminary step of a research effort on buoyant jets, which was carried out with Prof. A. Abbà, D. Bindoni, and F. Esposito (Polimi, DAER). Their consent to share it is greatly appreciated.

