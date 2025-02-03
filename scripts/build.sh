#!/bin/bash -e

[ -z "$1" ] && echo "First argument is not set, set to the version, e.g. 2025.2.1" && exit 1
version=$1

echo "Remove dist dir"
dist_dir=$(realpath dist)
rm -rf $dist_dir
mkdir $dist_dir

echo "Clean before build"
cd ot-ti
git clean -dxf && \
    git restore . && \
    git submodule foreach 'git clean -dxf' && \
    git submodule foreach --recursive 'git restore .'

items=(
    # target      name     CC1352P_2_OTHER   
    "LP_CC2652RB,CC2652RB,false"
    "CC1352P_2_LAUNCHXL,CC1352P2_CC2652P_launchpad,false"
    "CC1352P_2_LAUNCHXL,CC1352P2_CC2652P_other,true"
    "LP_CC1352P7_4,CC1352P7,false"
    "CC26X2R1_LAUNCHXL,CC2652R,false"
    "LP_CC2652R7,CC2652R7,false"
)

for target in "${items[@]}"; do
    IFS=',' read -r -a values <<< "$target"
    target="${values[0]}"
    name="${values[1]}"
    CC1352P_2_OTHER="${values[2]}"

    echo "Compiling: target=$target name=$name CC1352P_2_OTHER=$CC1352P_2_OTHER"
    file_name="${name}_ot_rcp_${version//./_}"
    CC1352P_2_OTHER="$CC1352P_2_OTHER" FW_VERSION="$version" ./script/build $target
    /opt/ti/ti-cgt-armllvm_4.0.1.LTS/bin/tiarmobjcopy build/bin/ot-rcp.out \
        --output-target ihex build/bin/$file_name.hex
    pushd build/bin
    zip $dist_dir/$file_name.zip $file_name.hex
    popd
done

echo "Done!"
