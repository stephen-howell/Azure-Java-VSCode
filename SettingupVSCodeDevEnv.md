
## How-to: Setting up our Visual Studio Code development environment
As we are using Visual Studio Code (VSCode) for almost all our how-to's, this is the most important thing to get set up properly on our choice of OS.
There general steps are (independent of OS):
1. Install Java Development Kit 8 (or later)
2. Install Maven
3. Install VSCode
4. Install VSCode extensions
 
In case you are concerned you might break something on your main (or only) device, you can create a virtual machine (VM) to test all of this.
Note you may need a powerful PC or laptop to run a VM well, and it won't be as fast as your device normally is (because your host OS has the overhead of pretending to be the device that the VM is running on). There is an easy way to create VM on the latest versions of Windows 10 - tap start and search for **Hyper-V Quick Create**.

### How-to: (Optional) Create a VM
1. Run **Hyper-V Quick Create**
2. Select and name the OS you want 
3. Wait for the download to finish and verify
4. Connect to the VM (you can run **Hyper-V Manager** later to find all your VM's)
5. If you choose Linux Ubuntu 19 as your VM, on setup you will have a choice to *auto login*. Do not choose this as it will prevent *Enhanced Mode* and this is essential for speed and usability.
   1. Then, once logged in, open a terminal and run `sudo apt-get install linux-azure`
6. If you choose Windows 10 as your VM, once connected to the VM, start an administrator PowerShell prompt and install Chocolately 
   1. https://chocolatey.org/docs/installation 
7. The following how-to can be done directly on your main device or on the VM, it does not matter particularly. 

### How-to: Install Java Development Kit 8
The Java Development Kit we are using is **Azul Zulu for Azure - Enterprise Edition JDK** https://docs.microsoft.com/en-gb/azure/java/jdk/java-jdk-install
1. On Windows, download and run the .msi: 
   1. https://www.azul.com/downloads/azure-only/zulu/?&version=java-8-lts&os=windows&architecture=x86-64-bit&package=jdk  
2. On Linux: `sudo apt-get -q update` and `sudo apt-get -y install zulu-8-azure-jdk`

### How-to: Install Maven
1. On Windows 10, open an elevated (administrator) command prompt and `choco install maven`
2. On Ubuntu, open a terminal and `sudo apt-get install maven`

### How-to: Install VSCode
1. For all platforms, install VSCode here: 
   1. https://code.visualstudio.com/download
2. For Windows only, there is a Java Pack installer which takes care of some of the next steps: 
   1. https://aka.ms/vscode-java-installer-win

### How-to: Install VSCode extensions
When you run VSCode (either by clicking on the icon or `code .` in a shell), press `CTRL + SHIFT + X` to open Extensions.
Search and install each of the following (or click the link).
1. Install the Java Extension Pack: 
   1. https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack 
   2. which includes all the following extensions:
      1. Language Support for Java™ by Red Hat
      2. Debugger for Java
      3. Java Test Runner
      4. Maven for Java
      5. Java Dependency Viewer
      6. Visual Studio IntelliCode
2. Install the `Azure Account` extension, which allows you to connect to and manage Azure from VS Code. Once installed, sign in to your Azure account?. You will have a choice of `Azure: Sign In` and `Azure: Sign In with Device Code`.  
3. Install Azure App Service extension: 
   1. https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice
4. Install SQL Server extension: SQL Server (mssql): 
   1. https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql