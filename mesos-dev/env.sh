#!/usr/bin/env bash

MESOS_DEV_ROOT=${HOME}/projects/mesos-vagrant/mesos-dev
MESOS_ROOT=${MESOS_DEV_ROOT}/mesos

__mesos_common() {
	topdir=$(pwd)
	__cleanup() {
		if [ "${topdir}" != "" ]; then
			cd ${topdir}
		fi
	}
	if [[ "${OSTYPE}" =~ ^linux.* ]]; then
		ncpus="$(cat /proc/cpuinfo | grep processor | wc -l)"
		osname="$(uname -n)"
	elif [[ "${OSTYPE}" =~ ^darwin.* ]]; then
		ncpus="$(sysctl -n hw.ncpu)"
		osname="${OSTYPE}"
	else
		echo "OS not recognized!"
		__cleanup
		exit 1
	fi
	osname=${osname#mesos-}
	trap '__cleanup' INT
}

mesos-dev-build-branch() {
	local branch
	local prefix
	local build_file
	__set_locals() {
		cd ${MESOS_ROOT}
		branch="$(git rev-parse --abbrev-ref HEAD)"
		build_file=".configure-mesos"
		prefix="${MESOS_DEV_ROOT}/install/mesos-${osname}-${branch}"
	}
	__mesos_common
	__set_locals

	mkdir -p ${MESOS_ROOT}/build/${osname}/${branch}
	cd ${MESOS_ROOT}/build/${osname}/${branch}
	if [ ! -f "${build_file}" ]; then
		../../../configure --prefix=${prefix}
		touch ${build_file}
	fi
	make -j $(expr ${ncpus} - 1)
	make install
	__cleanup
}

mesos-dev-update-path() {
	local branch
	__set_locals() {
		cd ${MESOS_ROOT}
		branch="$(git rev-parse --abbrev-ref HEAD)"
	}
	__mesos_common
	__set_locals

	for p in $(ls ${MESOS_DEV_ROOT}/install/); do
		p="${MESOS_DEV_ROOT}/install/${p}"
		PATH=${PATH/${p}\/sbin:/}
		PATH=${PATH/${p}\/bin:/}
	done
	PATH="${MESOS_DEV_ROOT}/install/mesos-${osname}-${branch}/sbin:${PATH}"
	PATH="${MESOS_DEV_ROOT}/install/mesos-${osname}-${branch}/bin:${PATH}"
	export PATH
	__cleanup
}
