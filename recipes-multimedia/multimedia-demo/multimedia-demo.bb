DESCRIPTION = "Multimedia Demo"
HOMEPAGE = "http://nohomepage.org"
SECTION = "Network"
LICENSE = "Apache-2.0"
PR = "r0"

PRIORITY = "10"

LIC_FILES_CHKSUM ??= "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = ""
SRC_URI += "file://multimedia-demo-copy.sh"
SRC_URI += "file://multimedia-demo-play.sh"
SRC_URI += "file://multimedia-demo-copy.service"
SRC_URI += "file://multimedia-demo-play.service"

inherit systemd

BBCLASSEXTEND += " native "

DEPENDS = ""
RDEPENDS = ""

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = ""
SYSTEMD_SERVICE_${PN} += "multimedia-demo-copy.service"
SYSTEMD_SERVICE_${PN} += "multimedia-demo-play.service"

do_prep() {
 cd ${S}
 chmod -Rf a+rX,u+w,g-w,o-w ${S}
}

do_configure() {
}

do_compile() {
}

do_install() {
 if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
  #copy scripts
  mkdir -p ${D}/usr/local/sbin/
  install -p -D ${WORKDIR}/multimedia-demo-copy.sh ${D}/usr/local/sbin/multimedia-demo-copy.sh
  install -p -D ${WORKDIR}/multimedia-demo-play.sh ${D}/usr/local/sbin/multimedia-demo-play.sh
  #copy systemd services
  install -p -D ${WORKDIR}/multimedia-demo-copy.service ${D}${systemd_unitdir}/system/multimedia-demo-copy.service
  install -p -D ${WORKDIR}/multimedia-demo-play.service ${D}${systemd_unitdir}/system/multimedia-demo-play.service
 fi
}

FILES_${PN} = ""
FILES_${PN} += "/usr/local/sbin/"
FILES_${PN} += "/usr/local/sbin/multimedia-demo-copy.sh"
FILES_${PN} += "/usr/local/sbin/multimedia-demo-play.sh"
