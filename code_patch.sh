#!/bin/bash


# code patch destination
code_patch_dest=`pwd`

# assign patch name
patch_name=$1
mkdir $patch_name

# assign SHA-1 value for specific change
# eg.
# 774b39b84e1599e53787708585fd021c02fada15
commit=$2

# assign repo path
# eg.
# c:\git\testscripts
repo_path=$3
cd $repo_path
pwd


# list to all changed file between this change and previous change then pipe all these file name to git archive to archive them 
# $commit means this change
# $commit~1 means previous change
git diff --name-only $commit $commit~1|xargs.exe git archive $commit > $code_patch_dest/$patch_name/mod.tar
git diff --name-only $commit $commit~1|xargs.exe git archive $commit~1 > $code_patch_dest/$patch_name/ori.tar

cd $code_patch_dest
pwd

mkdir $patch_name/mod
tar xvf $patch_name/mod.tar -C $patch_name/mod
mkdir $patch_name/ori
tar xvf $patch_name/ori.tar -C $patch_name/ori


tar zcvf ${patch_name}.tgz ${patch_name}
