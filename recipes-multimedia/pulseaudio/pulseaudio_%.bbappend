
CACHED_CONFIGUREVARS_append_mx6 = " ax_cv_PTHREAD_PRIO_INHERIT=no"

PACKAGE_ARCH_mx6 = "${MACHINE_SOCARCH}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://pulseaudio.service"

do_install_append() {
 install -p -D ${WORKDIR}/pulseaudio.service ${D}${systemd_unitdir}/system/pulseaudio.service
 mkdir -p ${D}${systemd_unitdir}/system/multi-user.target.wants
 ln -sf ../pulseaudio.service ${D}${systemd_unitdir}/system/multi-user.target.wants/pulseaudio.service
}

FILES_${PN} += "${systemd_unitdir}/system/pulseaudio.service"
FILES_${PN} += "${systemd_unitdir}/system/multi-user.target.wants/pulseaudio.service"
