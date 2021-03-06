#!/bin/sh -x

tempdir=$HOME/Downloads
version=5.2.1

# make sure there is no locale setting creating unneeded differences.
LC_ALL=C
export LC_ALL

mkdir $tempdir
cd $tempdir
/bin/rm -rf espresso/ espresso-$version
# get the svn copy
svn checkout http://qeforge.qe-forge.org/svn/q-e/tags/QE-5-2-1/espresso
mv espresso/ espresso-$version/

cd espresso-$version

# generate version.f90 (requires svn files)
touch make.sys
cd Modules
make version.f90
# save version.f90 (make veryclean removes it)
mv version.f90 ..
cd ..

# remove all .svn directories, clean
find . -type d -name .svn -exec /bin/rm -rf {} \;
make veryclean
rm archive/plumed-1.3-qe.tar.gz archive/PLUMED-latest.tar.gz

# restore version.f90 
mv version.f90 Modules/

# generate documentation - NOTA BENE:
# in order to build the .html and .txt documentation in Doc, 
# "tcl", "tcllib", "xsltproc" are needed
# in order to build the .pdf files in Doc, "pdflatex" is needed
# in order to build html files for user guide and developer manual,
# "latex2html" and "convert" (from Image-Magick) are needed

touch make.sys
make doc

# generate PWGUI

make tar-gui PWGUI_VERSION=$version 
tar -xzvf PWgui-$version.tgz
/bin/rm PWgui-$version.tgz

cd ..

# core espresso

tar -czvf espresso-$version.tar.gz espresso-$version/archive \
                                   espresso-$version/clib \
                                   espresso-$version/configure \
                                   espresso-$version/COUPLE \
                                   espresso-$version/CPV \
                                   espresso-$version/dev-tools \
                                   espresso-$version/Doc \
                                   espresso-$version/environment_variables \
                                   espresso-$version/flib \
                                   espresso-$version/Makefile \
                                   espresso-$version/include \
                                   espresso-$version/install \
                                   espresso-$version/License \
                                   espresso-$version/Modules \
                                   espresso-$version/PP \
                                   espresso-$version/pseudo \
                                   espresso-$version/PW \
                                   espresso-$version/README \
                                   espresso-$version/upftools
#
# Packages, ready for automatic unpacking

cd espresso-$version
tar -cvzf ../PWgui-$version.tar.gz    PWgui-$version
tar -czvf ../PHonon-$version.tar.gz   PHonon PlotPhon QHA
tar -czvf ../neb-$version.tar.gz      NEB
tar -czvf ../pwcond-$version.tar.gz   PWCOND
tar -czvf ../xspectra-$version.tar.gz XSpectra
tar -czvf ../GWW-$version.tar.gz      GWW
#tar -czvf ../GIPAW-$version.tar.gz    GIPAW
tar -czvf ../tddfpt-$version.tar.gz   TDDFPT
tar -czvf ../atomic-$version.tar.gz   atomic

