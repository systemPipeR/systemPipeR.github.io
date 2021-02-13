#!/bin/bash
set -e
# git_link is the http git link of a repo
git_link=${1}
# update_dir is what is the folder path in website you want to copy to
update_dir=${2}
down_folder="/tmp/${update_dir}"
folder_base=$(basename ${update_dir})
hash_file=".github/reference_hash/${folder_base}"

# clean temp
echo "Clean dwonload folder ${down_folder}"
rm -rf ${down_folder}
rm -rf /tmp/${folder_base}_update
# clone repo 
echo "Downloading ${update_dir} to \"${down_folder}\""
git clone ${git_link} ${down_folder}

# check hash
if [[ -f "${hash_file}" ]]; then
    echo "${hash_file} exists, continue"
    current_hash=$(cat ${hash_file})
    new_hash=`find ${down_folder}/docs -type f -print0 | \
        sort -z | \
        xargs -0 md5sum | \
        md5sum | \
        awk '{ print $1 }'`
    echo "compare hash"
    echo "Current hash: ${current_hash}"
    echo "New hash:     ${new_hash}"
    if [[ ! "${current_hash}" == "${new_hash}" ]]; then
        echo "hash differs, update needed"
        echo ${new_hash} > ${hash_file}
        touch /tmp/${folder_base}_update
    else
        echo "skip update for ${folder_base}"
    fi
else
    echo "${hash_file} is not there, update needed"
    find ${down_folder}/docs -type f -print0 | \
        sort -z | \
        xargs -0 md5sum | \
        md5sum | \
        awk '{ print $1 }' > ${hash_file}
    touch /tmp/${folder_base}_update
fi


# update
if [[ -f /tmp/${folder_base}_update ]]; then
    # clear folders
    echo "Clean update folder ${update_dir}"
    rm -rf ${update_dir}
    mkdir -p ${update_dir}
    # copy 
    echo "Update files"
    cp -r ${down_folder}/docs/* ${update_dir}
fi



