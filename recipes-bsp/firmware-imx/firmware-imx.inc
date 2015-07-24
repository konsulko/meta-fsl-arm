SUMMARY = "Freescale IMX firmware"
DESCRIPTION = "Freescale IMX firmware such as for the VPU"
SECTION = "base"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://COPYING;md5=acdb807ac7275fe32f9f64992e111241"

PE = "1"

SRC_URI = "${FSL_MIRROR}/firmware-imx-${PV}.bin;fsl-eula=true"
SRC_URI += "file://firmware-imx.service"

inherit fsl-eula-unpack

do_install() {
    install -d ${D}/lib/firmware
    cp -rfv firmware/* ${D}/lib/firmware/
    find ${D}/lib/firmware -type f -exec chmod 644 '{}' ';'

    # Remove files not going to be installed
    find ${D}/lib/firmware/ -name Android.mk -exec rm '{}' ';'

    #Deploy systemd service to grant access to /dev/mxc_vpu for all users
    install -p -D ${WORKDIR}/firmware-imx.service ${D}${systemd_unitdir}/system/firmware-imx.service
    mkdir -p ${D}${systemd_unitdir}/system/graphical.target.wants
    ln -sf ../firmware-imx.service ${D}${systemd_unitdir}/system/graphical.target.wants/firmware-imx.service
}

ALLOW_EMPTY_${PN} = "1"

PACKAGES_DYNAMIC = "${PN}-vpu-* ${PN}-sdma-*"

PACKAGE_ARCH = "${MACHINE_SOCARCH}"

FILES = ""
FILES_${PN} = "/lib/firmware/*"
#FILES_${PN} += "/lib/systemd/system/*"
FILES_${PN} += "${systemd_unitdir}/system/firmware-imx.service"
FILES_${PN} += "${systemd_unitdir}/system/graphical.target.wants/firmware-imx.service"
