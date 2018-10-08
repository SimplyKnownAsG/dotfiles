@ECHO OFF

:: enhance path
SET CODE_HOME=%HOMEDRIVE%%HOMEPATH%\codes
SET PYTHONPATH=%CODE_HOME%\armi
SET HOME=%USERPROFILE%
SET EDITOR=vim --noplugin
:: prevent git from issuing "WARNING: terminal is not fully functional"
:: SET TERM=MSYS

SET BOOST_ROOT=C:\tools\boost-1.59.0

SET TEMP=%CODE_HOME%\.temp
SET TMP=%CODE_HOME%\.temp

IF NOT EXIST %HOME%\_vimrc echo "source $HOME/.vimrc" > %HOME%\_vimrc

SET PATH35=C:\Windows\system32
SET PATH35=%PATH35%;C:\Windows
SET PATH35=%PATH35%;C:\Program Files\Microsoft MPI\Bin
SET PATH35=%PATH35%;C:\Program Files\Microsoft HPC Pack 2012\Bin
SET PATH35=%PATH35%;C:\Windows\System32\Wbem
SET PATH35=%PATH35%;C:\Windows\System32\WindowsPowerShell\v1.0
SET PATH35=%PATH35%;C:\Program Files\Java\jdk1.7.0_67\bin
SET PATH35=%PATH35%;C:\Program Files (x86)\Gource\cmd
SET PATH35=%PATH35%;C:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit
SET PATH35=%PATH35%;C:\Program Files\Microsoft SQL Server\110\Tools\Binn
SET PATH35=%PATH35%;C:\Users\gmalmgren\scoop\shims
SET PATH35=%PATH35%;C:\Users\gmalmgren\scoop\apps\python\current\Scripts
SET PATH35=%PATH35%;C:\Users\gmalmgren\scoop\apps\python\current
SET PATH35=%PATH35%;C:\tools\php
SET PATH35=%PATH35%;C:\tools\arcanist\bin

SET PATH=%PATH35%

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

