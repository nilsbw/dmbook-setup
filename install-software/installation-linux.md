# "Data Management for Social Scientists" | Installation Instructions for Linux

## Installing R and RStudio

R is available for almost all Linux distributions, and the installation depends on which package manager the distribution is using. For example, Ubuntu Linux uses the APT package manager. The R package is called `r-base`, so you can install it with `sudo apt install r-base`. You need at least R version 4.1. For some of the major Linux distributions, there are special repositories with a customized R installation and pre-configured R packages at  [https://cran.r-project.org/bin/linux/](https://cran.r-project.org/bin/linux), which greatly facilitate the setup. In particular, we recommend to use these repository in particular for packages such as `RPostgres` and `sf`, which can be tricky to install under Linux since there are no binary packages available on CRAN.

To install RStudio, go to the RStudio website at [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/). In the "Installers" section, click on the link for your particular operating system. This will download an installation package, which you can then install with your package manager. For Ubuntu Linux, for example, you download a `.deb` package, which you install with `dpkg -i <filename>.deb`. You should now have R and RStudio installed on your computer. 

## Installing PostgreSQL and the PostGIS extension

Tne PostgreSQL server also comes pre-packaged for all flavors of Linux. Under Ubuntu Linux, for example, you can simply install it with `sudo apt install postgresql`. During the install process, you will see which major version of PostgreSQL is being installed (this will likely be 12 or 13). After the installation, you need to initialize the server with `pg_ctlcluster 13 main start` (for version 13 - replace this with the respective version you are using). 

The PostGIS package is also available as an installer package for most systems. Under Ubuntu, it can then be installed with `sudo apt install postgis`. Installations for other flavors of Linux differ, but it is straightforward to find installation instructions online.

You now have running PostgreSQL server on your system. For the exercises in the book, it is important that you remember the name of the user. The password can be left empty, since it is not enabled by default:

* Username: `postgres`
* Password: `''` (or anything else)

Whenever we connect to the database server in the chapters of the book, username and password must be set correctly, otherwise the connection will fail. In our examples, we assume that you left the default port (`5432`) unchanged, and that you installed PostgreSQL on your local machine (which is referred to as `localhost`). If this is *not* the case and for some reason you deviate from this standard configuration, you will have to adjust these parameters for the DB connections in the code examples.

Please note: We are installing the PostgreSQL server here with a minimal configuration and solely for the purpose of running the exercises in the book. If you plan to use the server together with other users, such that it can be reached also from other machines, some more configuration is required to enable this and to properly secure the server. The configuration presented here is *not* intended for this purpose. 

## Uninstalling PostgreSQL

You can simply removing PostgreSQL from your system using the package manager. For example, removing PostgreSQL and PostGIS from an Ubuntu system can be done with `apt remove postgresql postgis`.  