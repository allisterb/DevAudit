#!/bin/bash

set -e 

rm -fr Analyzers/*
rm -fr Rules/*
rm -fr Examples/*
TERM=xterm mono .nuget/nuget.exe restore DevAudit.Mono.sln && mono xbuild DevAudit.Mono.sln /p:Configuration=RuntimeDebug $*
