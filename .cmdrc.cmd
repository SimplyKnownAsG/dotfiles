@ECHO OFF

:: enhance path
SET CODE_HOME=%HOMEDRIVE%%HOMEPATH%\codes
SET PYTHONPATH=%CODE_HOME%\armi
SET HOME=%USERPROFILE%
SET EDITOR=vim --noplugin
SET VIMINIT=source C:\Users\gmalmgren\.config\nvim\init.vim
:: prevent git from issuing "WARNING: terminal is not fully functional"
:: SET TERM=MSYS

SET TEMP=%CODE_HOME%\.temp
SET TMP=%CODE_HOME%\.temp

SET PATH=%PATH:C:\Cygwin64\bin;=%
SET PATH=%PATH:C:\Python27;=%
SET PATH=%PATH:C:\Python27\scripts=%
SET PATH=%PATH:C:\Program Files (x86)\Common Files\Intel\Shared Libraries\redist\ia32\mpirt=%
SET PATH=%PATH:C:\Program Files (x86)\Common Files\Intel\Shared Libraries\redist\ia32\compiler=%
SET PATH=%PATH:C:\Program Files (x86)\Common Files\Intel\Shared Libraries\redist\intel64\mpirt=%
SET PATH=%PATH:C:\Program Files (x86)\Common Files\Intel\Shared Libraries\redist\intel64\compiler=%
SET PATH=%PATH%;C:\tools\php
SET PATH=%PATH%;C:\tools\swig
SET PATH=%PATH%;C:\tools\arcanist\bin
set PATH=C:\Users\gmalmgren\scoop\apps\msmpi\current;%PATH%

DOSKEY cd=cd /d $*
DOSKEY ls=ls --color $*
DOSKEY ll=ls --color -l $*
DOSKEY grep=grep --color $*
DOSKEY grepy=grep --color -r --include=*.py $*
DOSKEY grepx=grep --color -r --include=*.xml $*

DOSKEY up=cd ..
DOSKEY u2=cd ..\..\
DOSKEY clear=cls

DOSKEY home=cd /d %HOMEDRIVE%%HOMEPATH%
DOSKEY codes=cd /d %CODE_HOME%
DOSKEY tools=cd /d %HOMEDRIVE%%HOMEPATH%\tools

:: stuff using python
DOSKEY py=python $*
DOSKEY pym=python -m $*
DOSKEY pm=python -m $*
DOSKEY pw=pythonw $*
DOSKEY intel-env="C:\Program Files (x86)\Intel\Composer XE 2015\bin\ipsxe-comp-vars.bat" intel64 vs2013
DOSKEY vs8-env="c:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" x86_amd64

DOSKEY vs-env="C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat"
DOSKEY vs8-env="C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" amd64

DOSKEY dotfiles=git --git-dir=%HOME%\.dotfiles.git --work-tree=%HOME% $*

clink inject

@ECHO ON
