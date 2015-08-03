
CACHED_CONFIGUREVARS_append_mx6 = " ax_cv_PTHREAD_PRIO_INHERIT=no"

PACKAGE_ARCH_mx6 = "${MACHINE_SOCARCH}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://pulseaudio.service"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "pulseaudio.service"

do_install_append() {
 if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
  install -p -D ${WORKDIR}/pulseaudio.service ${D}${systemd_unitdir}/system/pulseaudio.service
 fi
}

