# Maintainer: Your Name <your.email@example.com>
pkgname=gsender
pkgver=1.5.6
pkgrel=1
pkgdesc="Electron sender for GRBL based CNC machines"
arch=('x86_64')
url="https://github.com/Sienci-Labs/gsender"
license=('MIT')
depends=('electron' 'nodejs')
makedepends=('yarn' 'git')
source=("$pkgname-$pkgver.tar.gz::https://github.com/Sienci-Labs/gsender/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')

prepare() {
    cd "$srcdir/$pkgname-$pkgver"
    yarn install
}

build() {
    cd "$srcdir/$pkgname-$pkgver"
    yarn run build
}

package() {
    cd "$srcdir/$pkgname-$pkgver"

    # Install the built application
    install -dm755 "$pkgdir/usr/lib/$pkgname"
    cp -r dist/gsender/* "$pkgdir/usr/lib/$pkgname/"

    # Install desktop file
    install -Dm644 "$srcdir/$pkgname-$pkgver/electron-build/icon.png" "$pkgdir/usr/share/pixmaps/$pkgname.png"
    cat > "$pkgdir/usr/share/applications/$pkgname.desktop" << EOF
[Desktop Entry]
Name=gSender
Comment=Electron sender for GRBL based CNC machines
Exec=electron /usr/lib/$pkgname/main.js
Icon=$pkgname
Type=Application
Categories=Utility;
EOF

    # Install binary
    install -Dm755 "$srcdir/$pkgname-$pkgver/bin/gsender" "$pkgdir/usr/bin/$pkgname"
}