#!/bin/bash
#
# MassOS Stage 3 build script (GNOME).
# Copyright (C) 2022 MassOS Developers.
#
# Exit on error.
set -e
# Change to the sources directory.
cd /sources
# Set up basic environment variables, same as Stage 2.
export PATH=/usr/bin:/usr/sbin
export LC_ALL="en_US.UTF-8"
export MAKEFLAGS="-j$(nproc)"
export FORCE_UNSAFE_CONFIGURE=1
export SHELL=/bin/bash
export CFLAGS="-Os -pipe" CXXFLAGS="-Os -pipe"
# === IF RESUMING A FAILED BUILD, ONLY REMOVE LINES BELOW THIS ONE.
# Main GNOME components.
# totem-pl-parser
tar -xf totem-pl-parser-3.26.6.tar.xz
cd totem-pl-parser-3.26.6
sed -i '/maybe-uninitialized/d' meson.build
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Denable-gtk-doc=false ..
ninja
ninja install
install -t /usr/share/licenses/totem-pl-parser -Dm644 ../COPYING.LIB
cd ../..
rm -rf totem-pl-parser-3.26.6
# yelp-xsl
tar -xf yelp-xsl-42.1.tar.xz
cd yelp-xsl-42.1
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/yelp-xsl -Dm644 COPYING COPYING.GPL COPYING.LGPL
cd ..
rm -rf yelp-xsl-42.1
# GConf
tar -xf GConf-3.2.6.tar.xz
cd GConf-3.2.6
./configure --prefix=/usr --sysconfdir=/etc --disable-orbit --disable-static
make
make install
install -t /usr/share/licenses/gconf -Dm644 COPYING
cd ..
rm -rf GConf-3.2.6
# gnome-autoar
tar -xf gnome-autoar-0.4.3.tar.xz
cd gnome-autoar-0.4.3
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dvapi=true -Dtests=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-autoar -Dm644 ../COPYING
cd ../..
rm -rf gnome-autoar-0.4.3
# Tracker
tar -xf tracker-3.4.0.tar.xz
cd tracker-3.4.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocs=false -Dman=true -Dtests=false ..
ninja
ninja install
install -t /usr/share/licenses/tracker -Dm644 ../COPYING
cd ../..
rm -rf tracker-3.4.0
# libgrss
tar -xf libgrss-0.7.0.tar.xz
cd libgrss-0.7.0
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/libgrss -Dm644 COPYING
cd ..
rm -rf libgrss-0.7.0
# Tracker-miners
tar -xf tracker-miners-3.4.0.tar.xz
cd tracker-miners-3.4.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dman=true -Dfunctional_tests=false ..
ninja
ninja install
install -t /usr/share/licenses/tracker-miners -Dm644 ../COPYING ../COPYING.GPL ../COPYING.LGPL
cd ../..
rm -rf tracker-miners-3.4.0
# libcloudproviders
tar -xf libcloudproviders-0.3.1.tar.gz
cd libcloudproviders-0.3.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Denable-gtk-doc=false -Dinstalled-tests=false ..
ninja
ninja install
install -t /usr/share/licenses/libcloudproviders -Dm644 ../LICENSE
cd ../..
rm -rf libcloudproviders-0.3.1
# gtk4
tar -xf gtk-4.8.1.tar.xz
cd gtk-4.8.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dx11-backend=true -Dwayland-backend=true -Dbroadway-backend=true -Dmedia-ffmpeg=enabled -Ddemos=false -Dmedia-gstreamer=enabled -Dprint-cups=enabled -Dvulkan=enabled -Dcloudproviders=enabled -Dtracker=enabled -Dcolord=enabled -Dgtk_doc=false -Dman-pages=true -Dbuild-examples=false -Dbuild-tests=false -Dinstall-tests=false ..
ninja
ninja install
install -t /usr/share/licenses/gtk4 -Dm644 ../COPYING
cd ../..
rm -rf gtk-4.8.1
# JS102.
tar -xf firefox-102.3.0esr.source.tar.xz
cd firefox-102.3.0
chmod +x js/src/configure.in
mkdir JS102-build; cd JS102-build
../js/src/configure.in --prefix=/usr --enable-linker=lld --with-intl-api --with-system-zlib --with-system-icu --disable-jemalloc --disable-debug-symbols --enable-readline
make
make install
rm -f /usr/lib/libjs_static.ajs
sed -i '/@NSPR_CFLAGS@/d' /usr/bin/js102-config
install -t /usr/share/licenses/js102 -Dm644 ../../extra-package-licenses/js102-license.txt
cd ../..
rm -rf firefox-102.3.0
# Gjs (Precompiled)
tar --no-same-owner --same-permissions -xf gjs-1.74.0-x86_64-precompiled-MassOS-2022.09.tar.xz
cp -a gjs-1.74.0-x86_64-precompiled-MassOS-2022.09/BINARY/* /
ldconfig
rm -rf gjs-1.74.0-x86_64-precompiled-MassOS-2022.09
# gnome-desktop
tar -xf gnome-desktop-43.tar.xz
cd gnome-desktop-43
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddebug_tools=false -Dsystemd=enabled -Dgtk_doc=false -Dinstalled_tests=false -Dbuild_gtk4=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-desktop -Dm644 ../COPYING ../COPYING-DOCS ../COPYING.LIB
cd ../..
rm -rf gnome-desktop-43
# gnome-menus
tar -xf gnome-menus-3.36.0.tar.xz
cd gnome-menus-3.36.0
./configure --prefix=/usr --sysconfdir=/etc --disable-static
make
make install
install -t /usr/share/licenses/gnome-menus -Dm644 COPYING
cd ..
rm -rf gnome-menus-3.36.0
# gnome-video-effects
tar -xf gnome-video-effects-0.5.0.tar.xz
cd gnome-video-effects-0.5.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-video-effects -Dm644 ../COPYING
cd ../..
rm -rf gnome-video-effects-0.5.0
# Grilo
tar -xf grilo-0.3.15.tar.xz
cd grilo-0.3.15
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Denable-gtk-doc=false -Denable-test-ui=false ..
ninja
ninja install
install -t /usr/share/licenses/grilo -Dm644 ../COPYING
cd ../..
rm -rf grilo-0.3.15
# grilo-plugins
tar -xf grilo-plugins-0.3.15.tar.xz
cd grilo-plugins-0.3.15
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/grilo-plugins -Dm644 ../COPYING
cd ../..
rm -rf grilo-plugins-0.3.15
# libgtop
tar -xf libgtop-2.40.0.tar.xz
cd libgtop-2.40.0
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/libgtop -Dm644 COPYING copyright.txt
cd ..
rm -rf libgtop-2.40.0
# libgweather
tar -xf libgweather-4.2.0.tar.xz
cd libgweather-4.2.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false -Dtests=false -Dsoup2=false ..
ninja
ninja install
install -t /usr/share/licenses/libgweather -Dm644 ../COPYING
cd ../..
rm -rf libgweather-4.2.0
# evolution-data-server
tar -xf evolution-data-server-3.46.0.tar.xz
cd evolution-data-server-3.46.0
mkdir build; cd build
cmake -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DENABLE_VALA_BINDINGS=ON -DENABLE_INSTALLED_TESTS=OFF -DENABLE_GOOGLE=ON -DWITH_OPENLDAP=ON -DWITH_KRB5=ON -DENABLE_INTROSPECTION=ON -DENABLE_GTK_DOC=OFF -DWITH_LIBDB=ON -DWITH_GWEATHER4=ON -DWITH_SYSTEMDUSERUNITDIR=yes -DENABLE_EXAMPLES=OFF -DENABLE_OAUTH2_WEBKITGTK=ON -DENABLE_OAUTH2_WEBKITGTK4=OFF -Wno-dev -G Ninja ..
ninja
ninja install
install -t /usr/share/licenses/evolution-data-server -Dm644 ../COPYING
cd ../..
rm -rf evolution-data-server-3.46.0
# telepathy-glib
tar -xf telepathy-glib-0.24.2.tar.gz
cd telepathy-glib-0.24.2
./configure --prefix=/usr --enable-vala-bindings --disable-static
make
make install
install -t /usr/share/licenses/telepathy-glib -Dm644 COPYING
cd ..
rm -rf telepathy-glib-0.24.2
# Folks
tar -xf folks-0.15.5.tar.xz
cd folks-0.15.5
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocs=false -Dtests=false -Dinstalled_tests=false ..
ninja
ninja install
install -t /usr/share/licenses/folks -Dm644 ../COPYING
cd ../..
rm -rf folks-0.15.5
# GSound
tar -xf gsound-1.0.3.tar.xz
cd gsound-1.0.3
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false ..
ninja
ninja install
install -t /usr/share/licenses/gsound -Dm644 ../COPYING
cd ../..
rm -rf gsound-1.0.3
# DConf
tar -xf dconf-0.40.0.tar.xz
cd dconf-0.40.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dbash_completion=true -Dman=true -Dgtk_doc=false ..
ninja
ninja install
install -t /usr/share/licenses/dconf -Dm644 ../COPYING
cd ../..
rm -rf dconf-0.40.0
# Exempi
tar -xf exempi-2.6.2.tar.bz2
cd exempi-2.6.2
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/exempi -Dm644 COPYING
cd ..
rm -rf exempi-2.6.2
# Zenity
tar -xf zenity-3.43.0.tar.xz
cd zenity-3.43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dlibnotify=true -Dwebkitgtk=true ..
ninja
ninja install
install -t /usr/share/licenses/zenity -Dm644 ../COPYING
cd ../..
rm -rf zenity-3.43.0
# libadwaita
tar -xf libadwaita-1.2.0.tar.xz
cd libadwaita-1.2.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false -Dtests=false -Dexamples=false ..
ninja
ninja install
install -t /usr/share/licenses/libadwaita -Dm644 ../COPYING
cd ../..
rm -rf libadwaita-1.2.0
# gnome-bluetooth
tar -xf gnome-bluetooth-42.4.tar.xz
cd gnome-bluetooth-42.4
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dsendto=true -Dgtk_doc=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-bluetooth -Dm644 ../COPYING ../COPYING.LIB
cd ../..
rm -rf gnome-bluetooth-42.4
# gnome-session
tar -xf gnome-session-43.0.tar.xz
cd gnome-session-43.0
sed -i 's|/bin/sh|/bin/sh -l|' gnome-session/gnome-session.in
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddeprecation_flags=false -Dsystemd=true -Dsystemd_session=enable -Dsystemd_journal=true -Ddocbook=false -Dman=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-session -Dm644 ../COPYING
cd ../..
rm -rf gnome-session-43.0
# gcr4
tar -xf gcr-3.92.0.tar.xz
cd gcr-3.92.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false ..
ninja
ninja install
install -t /usr/share/licenses/gcr4 -Dm644 ../COPYING
cd ../..
rm -rf gcr-3.92.0
# gnome-settings-daemon
tar -xf gnome-settings-daemon-43.0.tar.xz
cd gnome-settings-daemon-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dsystemd=true -Dalsa=true -Dgudev=true -Dcups=true -Dnetwork_manager=true -Drfkill=true -Dsmartcard=true -Dusb-protection=true -Dwayland=true -Dwwan=true -Dcolord=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-settings-daemon -Dm644 ../COPYING ../COPYING.LIB
cd ../..
rm -rf gnome-settings-daemon-43.0
# libnma-gtk4
tar -xf libnma-1.10.2.tar.xz
cd libnma-1.10.2
mkdir nma-build; cd nma-build
meson --prefix=/usr --buildtype=minsize -Dlibnma_gtk4=true ..
ninja
ninja install
ln -sf libnma /usr/share/licenses/libnma-gtk4
cd ../..
rm -rf libnma-1.10.2
# ibus
tar -xf ibus-1.5.27.tar.gz
cd ibus-1.5.27
./configure --prefix=/usr --sysconfdir=/etc --enable-gtk4 --enable-wayland --with-python=python3 --disable-emoji-dict --disable-unicode-dict
rm -f tools/main.c
make
make install
install -t /usr/share/licenses/ibus -Dm644 COPYING COPYING.unicode
gzip -dfv /usr/share/man/man{{1,5}/ibus*.gz,5/00-upstream-settings.5.gz}
cd ..
rm -rf ibus-1.5.27
# colord-gtk4
tar -xf colord-gtk-0.3.0.tar.xz
cd colord-gtk-0.3.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk4=true -Dgtk3=true -Dgtk2=true -Dtests=false -Dman=false -Ddocs=false ..
ninja
ninja install
install -t /usr/share/licenses/colord-gtk -Dm644 ../COPYING
cd ../..
rm -rf colord-gtk-0.3.0
# cups-pk-helper
tar -xf cups-pk-helper-0.2.7.tar.xz
cd cups-pk-helper-0.2.7
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/cups-pk-helper -Dm644 ../COPYING
cd ../..
rm -rf cups-pk-helper-0.2.7
# gssdp
tar -xf gssdp-1.6.0.tar.xz
cd gssdp-1.6.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false -Dexamples=false ..
ninja
ninja install
install -t /usr/share/licenses/gssdp -Dm644 ../COPYING
cd ../..
rm -rf gssdp-1.6.0
# gupnp
tar -xf gupnp-1.6.0.tar.xz
cd gupnp-1.6.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dexamples=false ..
ninja
ninja install
install -t /usr/share/licenses/gupnp -Dm644 ../COPYING
cd ../..
rm -rf gupnp-1.6.0
# gupnp-av
tar -xf gupnp-av-0.14.1.tar.xz
cd gupnp-av-0.14.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gupnp-av -Dm644 ../COPYING
cd ../..
rm -rf gupnp-av-0.14.1
# gupnp-dlna
tar -xf gupnp-dlna-0.12.0.tar.xz
cd gupnp-dlna-0.12.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gupnp-dlna -Dm644 ../COPYING
cd ../..
rm -rf gupnp-dlna-0.12.0
# gst-editing-services
tar -xf gst-editing-services-1.20.3.tar.xz
cd gst-editing-services-1.20.3
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddoc=disabled -Dexamples=disabled -Dtests=disabled ..
ninja
ninja install
install -t /usr/share/licenses/gst-editing-services -Dm644 ../COPYING ../COPYING.LIB
cd ../..
rm -rf gst-editing-services-1.20.3
# libmediaart
tar -xf libmediaart-1.9.6.tar.xz
cd libmediaart-1.9.6
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/libmediaart -Dm644 ../COPYING ../COPYING.LESSER
cd ../..
rm -rf libmediaart-1.9.6
# rygel
tar -xf rygel-0.42.0.tar.xz
cd rygel-0.42.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dexamples=false -Dtests=false ..
ninja
ninja install
install -t /usr/share/licenses/rygel -Dm644 ../COPYING ../COPYING.logo
cd ../..
rm -rf rygel-0.42.0
# gnome-control-center
tar -xf gnome-control-center-43.0.tar.xz
cd gnome-control-center-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocumentation=false -Dibus=true -Dtests=false -Dwayland=true -Dmalcontent=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-control-center -Dm644 ../COPYING
cd ../..
rm -rf gnome-control-center-43.0
# libdazzle.
tar -xf libdazzle-3.44.0.tar.xz
cd libdazzle-3.44.0
mkdir DAZZLE-build; cd DAZZLE-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/libdazzle -Dm644 ../COPYING
cd ../..
rm -rf libdazzle-3.44.0
# Sysprof.
tar -xf sysprof-3.46.0.tar.xz
cd sysprof-3.46.0
mkdir SYSPROF-build; cd SYSPROF-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/sysprof -Dm644 ../COPYING ../COPYING.gpl-2
cd ../..
rm -rf sysprof-3.46.0
# Mutter
tar -xf mutter-43.0.tar.xz
cd mutter-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dtests=false -Dinstalled_tests=false -Ddocs=false -Degl_device=true -Dwayland_eglstream=true ..
ninja
ninja install
install -t /usr/share/licenses/mutter -Dm644 ../COPYING
cd ../..
rm -rf mutter-43.0
# GDM
groupadd -g 67 gdm
useradd -c "GDM Daemon" -d /var/lib/gdm -u 67 -g gdm -s /bin/false gdm
tar -xf gdm-43.0.tar.xz
cd gdm-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddefault-pam-config=lfs -Dgdm-xsession=true -Dplymouth=enabled -Dselinux=disabled -Dsystemd-journal=true -Duser-display-server=true -Dwayland-support=true ..
ninja
ninja install
install -t /usr/share/licenses/gdm -Dm644 ../COPYING
cd ../..
rm -rf gdm-43.0
# telepathy-mission-control
tar -xf telepathy-mission-control-5.16.6.tar.gz
cd telepathy-mission-control-5.16.6
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/telepathy-mission-control -Dm644 COPYING
cd ..
rm -rf telepathy-mission-control-5.16.6
# gnome-shell
tar -xf gnome-shell-43.0.tar.xz
cd gnome-shell-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dextensions_tool=true -Dextensions_app=false -Dgtk_doc=false -Dman=true -Dtests=false -Dnetworkmanager=true -Dsystemd=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-shell -Dm644 ../COPYING
cd ../..
rm -rf gnome-shell-43.0
# gnome-shell-extensions
tar -xf gnome-shell-extensions-43.0.tar.xz
cd gnome-shell-extensions-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-shell-extensions -Dm644 ../COPYING
cd ../..
rm -rf gnome-shell-extensions-43.0
# gnome-user-docs
tar -xf gnome-user-docs-43.0.tar.xz
cd gnome-user-docs-43.0
./configure --prefix=/usr
make
make install
install -t /usr/share/licenses/gnome-user-docs -Dm644 COPYING
cd ..
rm -rf gnome-user-docs-43.0
# gnome-browser-connector
tar -xf gnome-browser-connector-v42.1.tar.gz
cd gnome-browser-connector-v42.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja install
install -t /usr/share/licenses/gnome-browser-connector -Dm644 ../LICENSE
cd ../..
rm -rf gnome-browser-connector-v42.1
# cantarell-fonts
tar -xf cantarell-fonts-0.303.1.tar.xz
cd cantarell-fonts-0.303.1
cp ../Cantarell-VF.otf prebuilt
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Duseprebuilt=true ..
ninja
ninja install
install -t /usr/share/licenses/cantarell-fonts -Dm644 ../COPYING
cd ../..
rm -rf cantarell-fonts-0.303.1
# text-engine
tar -xf text-engine-0.1.1.tar.gz
cd text-engine-0.1.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/text-engine -Dm644 ../COPYING
cd ../..
rm -rf text-engine-0.1.1
# blueprint-compiler
tar -xf blueprint-compiler-v0.4.0.tar.gz
cd blueprint-compiler-v0.4.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocs=false ..
ninja
ninja install
install -t /usr/share/licenses/blueprint-compiler -Dm644 ../COPYING
cd ../..
rm -rf blueprint-compiler-v0.4.0
# gmime
tar -xf gmime-3.2.7.tar.xz
cd gmime-3.2.7
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/gmime -Dm644 COPYING
cd ..
rm -rf gmime-3.2.7
# ytnef
tar -xf ytnef-2.0.tar.gz
cd ytnef-2.0
./autogen.sh
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/ytnef -Dm644 COPYING
cd ..
rm -rf ytnef-2.0
# gtksourceview5
tar -xf gtksourceview-5.6.0.tar.xz
cd gtksourceview-5.6.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dsysprof=true ..
ninja
ninja install
install -t /usr/share/licenses/gtksourceview5 -Dm644 ../COPYING
cd ../..
rm -rf gtksourceview-5.6.0
# libshumate
tar -xf libshumate-1.0.1.tar.xz
cd libshumate-1.0.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false ..
ninja
ninja install
install -t /usr/share/licenses/libshumate -Dm644 ../COPYING
cd ../..
rm -rf libshumate-1.0.1
# libportal-gtk4.
tar -xf libportal-0.6.tar.xz
cd libportal-0.6
mkdir portal-build; cd portal-build
meson --prefix=/usr --buildtype=minsize -Dbackends=gtk4 -Ddocs=false -Dtests=false ..
ninja
ninja install
install -t /usr/share/licenses/libportal-gtk4 -Dm644 ../COPYING
cd ../..
rm -rf libportal-0.6
# editorconfig-core-c
tar -xf editorconfig-core-c-0.12.5.tar.gz
cd editorconfig-core-c-0.12.5
mkdir build; cd build
cmake -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DOCUMENTATION=OFF -Wno-dev -G Ninja ..
ninja 
ninja install
install -t /usr/share/licenses/editorconfig-core-c -Dm644 ../LICENSE
cd ../..
rm -rf editorconfig-core-c-0.12.5
# libgda
tar -xf libgda-6.0.0.tar.xz
cd libgda-6.0.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/libgda -Dm644 ../COPYING ../COPYING.LIB
cd ../..
rm -rf libgda-6.0.0
# Main GNOME apps.
# Nautilus
tar -xf nautilus-43.0.tar.xz
cd nautilus-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocs=false -Dextensions=true -Dpackagekit=false -Dselinux=false -Dtests=none ..
ninja
ninja install
install -t /usr/share/licenses/nautilus -Dm644 ../LICENSE
cd ../..
rm -rf nautilus-43.0
# Geary
tar -xf geary-43.0.tar.xz
cd geary-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dprofile=release ..
ninja
ninja install
install -t /usr/share/licenses/geary -Dm644 ../COPYING ../COPYING.icons ../COPYING.pyyaml ../code-of-conduct.md
cd ../..
rm -rf geary-43.0
# gnome-music
tar -xf gnome-music-42.1.tar.xz
cd gnome-music-42.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-music -Dm644 ../LICENSE
cd ../..
rm -rf gnome-music-42.1
# gnome-calendar
tar -xf gnome-calendar-43.0.tar.xz
cd gnome-calendar-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-calendar -Dm644 ../COPYING
cd ../..
rm -rf gnome-calendar-43.0
# gnome-extension-manager
tar -xf gnome-extension-manager-0.3.2.tar.gz
cd extension-manager-0.3.2
patch -Np1 -i ../patches/gnome-extension-manager-3.2-gtk-4.8-fixes.patch
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-extension-manager -Dm644 ../COPYING
cd ../..
rm -rf extension-manager-0.3.2
# Yelp
tar -xf yelp-42.2.tar.xz
cd yelp-42.2
./configure --prefix=/usr --disable-static
make
make install
install -t /usr/share/licenses/yelp -Dm644 COPYING
cd ..
rm -rf yelp-42.2
# Baobab
tar -xf baobab-43.0.tar.xz
cd baobab-43.0
mkdir baobab-build; cd baobab-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/baobab -Dm644 ../COPYING ../COPYING.docs
cd ../..
rm -rf baobab-43.0
# Cheese
tar -xf cheese-43.alpha.tar.xz
cd cheese-43.alpha
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dtests=false -Dgtk_doc=false -Dman=true ..
ninja
ninja install
install -t /usr/share/licenses/cheese -Dm644 ../COPYING
cd ../..
rm -rf cheese-43.alpha
# EOG
tar -xf eog-43.0.tar.xz
cd eog-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dgtk_doc=false -Dinstalled_tests=false -Dlibportal=true ..
ninja
ninja install
install -t /usr/share/licenses/eog -Dm644 ../COPYING
cd ../..
rm -rf eog-43.0
# Evince.
tar -xf evince-43.0.tar.xz
cd evince-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dnautilus=false ..
ninja
ninja install
install -t /usr/share/licenses/evince -Dm644 ../COPYING
cd ../..
rm -rf evince-43.0
# File-roller
tar -xf file-roller-43.0.tar.xz
cd file-roller-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dpackagekit=false ..
ninja
ninja install
install -t /usr/share/licenses/file-roller -Dm644 ../COPYING
cd ../..
rm -rf file-roller-43.0
# gnome-calculator
tar -xf gnome-calculator-43.0.1.tar.xz
cd gnome-calculator-43.0.1
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-calculator -Dm644 ../COPYING
cd ../..
rm -rf gnome-calculator-43.0.1
# gnome-color-manager
tar -xf gnome-color-manager-3.36.0.tar.xz
cd gnome-color-manager-3.36.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dtests=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-color-manager -Dm644 ../COPYING
cd ../..
rm -rf gnome-color-manager-3.36.0
# gnome-disk-utility
tar -xf gnome-disk-utility-43.0.tar.xz
cd gnome-disk-utility-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dlogind=libsystemd -Dgsd_plugin=true -Dman=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-disk-utility -Dm644 ../COPYING
cd ../..
rm -rf gnome-disk-utility-43.0
# gnome-maps
tar -xf gnome-maps-43.0.tar.xz
cd gnome-maps-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-maps -Dm644 ../COPYING
cd ../..
rm -rf gnome-maps-43.0
# gnome-screenshot
tar -xf gnome-screenshot-41.0.tar.xz
cd gnome-screenshot-41.0
sed -i '/merge_file/{n;d}' data/meson.build
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-screenshot -Dm644 ../COPYING
cd ../..
rm -rf gnome-screenshot-41.0
# gnome-system-monitor
tar -xf gnome-system-monitor-42.0.tar.xz
cd gnome-system-monitor-42.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dsystemd=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-system-monitor -Dm644 ../COPYING
cd ../..
rm -rf gnome-system-monitor-42.0
# gnome-terminal
tar -xf gnome-terminal-3.46.2.tar.gz
cd gnome-terminal-3.46.2
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Ddocs=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-terminal -Dm644 ../COPYING ../COPYING.GFDL
cd ../..
rm -rf gnome-terminal-3.46.2
# gnome-tweaks
tar -xf gnome-tweaks-42.beta.tar.xz
cd gnome-tweaks-42.beta
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-tweaks -Dm644 ../LICENSES/*
cd ../..
rm -rf gnome-tweaks-42.beta
# gnome-weather
tar -xf gnome-weather-43.0.tar.xz
cd gnome-weather-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-weather -Dm644 ../COPYING.md
cd ../..
rm -rf gnome-weather-43.0
# Seahorse
tar -xf seahorse-42.0.tar.xz
cd seahorse-42.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dmanpage=true ..
ninja
ninja install
install -t /usr/share/licenses/seahorse -Dm644 ../COPYING ../COPYING-DOCS ../COPYING.LIB
cd ../..
rm -rf seahorse-42.0
# GParted.
tar -xf gparted-GPARTED_1_4_0.tar.bz2
cd gparted-GPARTED_1_4_0
autoreconf -fi
./configure --prefix=/usr --disable-doc --disable-static --enable-libparted-dmraid --enable-online-resize --enable-xhost-root
make
make install
install -t /usr/share/licenses/gparted -Dm644 COPYING
cd ..
rm -rf gparted-GPARTED_1_4_0
# GNOME Software.
tar -xf gnome-software-43.0.tar.xz
cd gnome-software-43.0
mkdir gnome-software-build; cd gnome-software-build
meson --prefix=/usr --buildtype=minsize -Dpackagekit=false -Dtests=false -Dsoup2=true ..
ninja
ninja install
install -t /usr/share/licenses/gnome-software -Dm644 ../COPYING
cd ../..
rm -rf gnome-software-43.0
# totem
tar -xf totem-43.0.tar.xz
cd totem-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dhelp=true -Denable-easy-codec-installation=yes -Denable-python=yes -Dwith-plugins=auto -Denable-gtk-doc=false ..
ninja
ninja install
install -t /usr/share/licenses/totem -Dm644 ../COPYING
cd ../..
rm -rf totem-43.0
# gnome-text-editor
tar -xf gnome-text-editor-43.0.tar.xz
cd gnome-text-editor-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-text-editor -Dm644 ../COPYING
cd ../..
rm -rf gnome-text-editor-43.0
# gnome-characters
tar -xf gnome-characters-43.0.tar.xz
cd gnome-characters-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize -Dinstalled_tests=false ..
ninja
ninja install
install -t /usr/share/licenses/gnome-characters -Dm644 ../COPYING ../COPYINGv2
cd ../..
rm -rf gnome-characters-43.0
# gnome-firmware
tar -xf gnome-firmware-43.0.tar.gz
cd gnome-firmware-43.0
mkdir gnome-firmware-build; cd gnome-firmware-build
meson --prefix=/usr --buildtype=minsize ..
ninja
ninja install
install -t /usr/share/licenses/gnome-firmware -Dm644 ../COPYING
cd ../..
rm -rf gnome-firmware-43.0
# gdm-tools
tar -xf gdm-tools-1.1.tar.gz
cd gdm-tools-1.1
sed -i 's|"$PREFIX"/man|"$PREFIX"/share/man|' install.sh
PREFIX=/usr ./install.sh
install -t /usr/share/licenses/gdm-tools -Dm644 LICENSE
cd ..
rm -rf gdm-tools-1.1
# gnome-tour
tar -xf gnome-tour-43.0.tar.xz
cd gnome-tour-43.0
mkdir build; cd build
meson --prefix=/usr --buildtype=minsize ..
RUSTFLAGS="-C relocation-model=dynamic-no-pic" ninja
RUSTFLAGS="-C relocation-model=dynamic-no-pic" ninja install
install -t /usr/share/licenses/gnome-tour -Dm644 ../LICENSE.md
cd ../..
rm -rf gnome-tour-43.0
# Additional GNOME tweaks.
# Global Extensions
# gnome-shell-extension-appindicator
mkdir /usr/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com; unzip appindicatorsupportrgcjonas.gmail.com.v46.shell-extension.zip -d /usr/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com
chmod 644 /usr/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-appindicator -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-appindicator.txt
# gnome-shell-extension-desktop-icons-ng-gtk4
mkdir /usr/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com; unzip gtk4-dingsmedius.gitlab.com.v7.shell-extension.zip -d /usr/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com
chmod 644 /usr/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-desktop-icons-ng-gtk4 -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-desktop-icons-ng-gtk4.txt
# gnome-shell-extension-pano
mkdir /usr/share/gnome-shell/extensions/pano@elhan.io; unzip panoelhan.io.v10.shell-extension.zip -d /usr/share/gnome-shell/extensions/pano@elhan.io
chmod 644 /usr/share/gnome-shell/extensions/pano@elhan.io/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-pano -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-pano.txt
# gnome-shell-extension-alphabetical-grid-extension
mkdir /usr/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst; unzip AlphabeticalAppGridstuarthayhurst.v26.shell-extension.zip -d /usr/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst
chmod 644 /usr/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-alphabetical-grid-extension -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-alphabetical-grid-extension.txt
# gnome-shell-extension-fuzzy-app-search
mkdir /usr/share/gnome-shell/extensions/gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com; unzip gnome-fuzzy-app-searchgnome-shell-extensions.Czarlie.gitlab.com.v18.shell-extension.zip -d /usr/share/gnome-shell/extensions/gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com
chmod 644 /usr/share/gnome-shell/extensions/gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-fuzzy-app-search -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-fuzzy-app-search.txt
# gnome-shell-extension-favourites-in-appgrid
mkdir /usr/share/gnome-shell/extensions/favourites-in-appgrid@harshadgavali.gitlab.org; unzip favourites-in-appgridharshadgavali.gitlab.org.v2.shell-extension.zip -d /usr/share/gnome-shell/extensions/favourites-in-appgrid@harshadgavali.gitlab.org
chmod 644 /usr/share/gnome-shell/extensions/favourites-in-appgrid@harshadgavali.gitlab.org/metadata.json
install -t /usr/share/licenses/gnome-shell-extension-favourites-in-appgrid -Dm644 extra-package-licenses/LICENSE-gnome-shell-extension-favourites-in-appgrid.txt
sed -e 's|"42"|"43"|' -i /usr/share/gnome-shell/extensions/favourites-in-appgrid@harshadgavali.gitlab.org/metadata.json
# Set default wallpaper
ln -sf xfce /usr/share/backgrounds/gnome
# Set GNOME Static wallpapers
install -dm755 /usr/share/gnome-background-properties
while read -r bg; do
  cat > /usr/share/gnome-background-properties/"$bg".xml << END
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>$bg</name>
    <filename>/usr/share/backgrounds/gnome/$bg.png</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
  </wallpaper>
</wallpapers>
END
done <<< $(find /usr/share/backgrounds/xfce -type f -exec basename -a {} + | cut -d. -f1 | sed '/About-Backgrounds/d')
# Modify GDM and GTK4
cat >> /etc/dconf/profile/gdm << "END"
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
END

mkdir /etc/dconf/db/gdm.d/

mkdir /etc/gtk-4.0
cat >> /etc/gtk-4.0/settings.ini << "END"
[Settings]
gtk-hint-font-metrics=1
END
# Set GDM background
cp gdm-background.png /usr/share/gdm
set-gdm-theme set -b /usr/share/gdm/gdm-background.png
# Customise GNOME
cat >> /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override << "END"
[org.gnome.shell]
favorite-apps=['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'org.gnome.TextEditor.desktop']
enabled-extensions=['appindicatorsupport@rgcjonas.gmail.com', 'gtk4-ding@smedius.gitlab.com', 'pano@elhan.io', 'AlphabeticalAppGrid@stuarthayhurst', 'gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'favourites-in-appgrid@harshadgavali.gitlab.org']

[org.gnome.desktop.interface]
color-scheme='prefer-dark'
cursor-theme='Adwaita'
document-font-name='Cantarell 11'
font-name='Cantarell 11'
monospace-font-name='Noto Sans Mono Regular 11'
icon-theme='Adwaita'
gtk-theme='Adwaita-dark'
clock-show-weekday=true
show-battery-percentage=true 

[org.gnome.desktop.wm.preferences]
button-layout='appmenu:minimize,maximize,close'
titlebar-font='Cantarell Bold 11'

[org.gnome.desktop.wm.keybindings]
switch-applications=['<Super>Tab']
switch-windows=['<Alt>Tab']
switch-applications-backward=['<Shift><Super>Tab']
switch-windows-backward=['<Shift><Alt>Tab']

[org.gnome.mutter]
center-new-windows=true

[org.gnome.desktop.peripherals.touchpad]
tap-to-click=true
click-method='default'

[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/gnome/MassOS-Futuristic-Light.png'
picture-uri-dark='file:///usr/share/backgrounds/gnome/MassOS-Futuristic-Dark.png'

[org.gnome.desktop.screensaver]
picture-uri='file:///usr/share/gdm/gdm-background.png'

[org.gnome.nautilus.icon-view]
default-zoom-level='standard'

[org.gnome.nautilus.preferences]
show-delete-permanently=true 

[org.gnome.login-screen]
logo='/usr/share/massos/massos-logo-sidetext.png'

[org.gnome.terminal.legacy]
theme-variant='dark'
END
# End tweaks
update-desktop-database
dconf update
glib-compile-schemas /usr/share/glib-2.0/schemas
systemctl enable gdm
# Firefox.
tar --no-same-owner -xf firefox-105.0.1.tar.bz2 -C /usr/lib
mkdir -p /usr/lib/firefox/distribution
cat > /usr/lib/firefox/distribution/policies.json << END
{
  "policies": {
    "DisableAppUpdate": true
  }
}
END
ln -sr /usr/lib/firefox/firefox /usr/bin/firefox
mkdir -p /usr/share/{applications,pixmaps}
cat > /usr/share/applications/firefox.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
END
ln -sr /usr/lib/firefox/browser/chrome/icons/default/default128.png /usr/share/pixmaps/firefox.png
install -dm755 /usr/share/licenses/firefox
cat > /usr/share/licenses/firefox/LICENSE << "END"
Please type 'about:license' in the Firefox URL box to view the Firefox license.
END
