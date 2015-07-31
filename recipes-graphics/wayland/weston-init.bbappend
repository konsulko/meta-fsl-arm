FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://display-manager-run.service"
SRC_URI_append = " file://weston"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "display-manager-run.service"

do_install() {
 if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
  install -p -D ${WORKDIR}/weston ${D}/${sysconfdir}/sysconfig/weston
  install -p -D ${WORKDIR}/display-manager-run.service ${D}${systemd_unitdir}/system/display-manager-run.service
  mkdir -p ${D}/${sysconfdir}/xdg/weston
 else
  install -d ${D}/${sysconfdir}/init.d
  install -m755 ${WORKDIR}/init ${D}/${sysconfdir}/init.d/weston
 fi
}

FILES_${PN} += "${sysconfdir}/sysconfig/weston"
