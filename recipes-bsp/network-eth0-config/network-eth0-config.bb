DESCRIPTION = "Systemd service to enable eth0"
HOMEPAGE = "http://nohomepage.org"
SECTION = "Network"
LICENSE = "Apache-2.0"
PR = "r0"

PRIORITY = "10"

LIC_FILES_CHKSUM ??= "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = ""
SRC_URI += "file://network.service"

BBCLASSEXTEND += " native "

DEPENDS = ""
RDEPENDS = ""

do_prep() {
 cd ${S}
 chmod -Rf a+rX,u+w,g-w,o-w ${S}
}

do_configure() {
}

do_compile() {
}

do_install() {
 install -p -D ${WORKDIR}/network.service ${D}${systemd_unitdir}/system/network.service
 mkdir -p ${D}${systemd_unitdir}/system/multi-user.target.wants
 ln -sf ../network.service ${D}${systemd_unitdir}/system/multi-user.target.wants/network.service
}

FILES_${PN} = ""
FILES_${PN} += "${systemd_unitdir}/system/network.service"
FILES_${PN} += "${systemd_unitdir}/system/multi-user.target.wants/network.service"
