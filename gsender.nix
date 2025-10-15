{ lib
, stdenv
, fetchFromGitHub
, yarn
, nodejs
, electron
, makeWrapper
, git
}:

stdenv.mkDerivation rec {
  pname = "gsender";
  version = "1.5.6";

  src = fetchFromGitHub {
    owner = "Sienci-Labs";
    repo = "gsender";
    rev = "v${version}";
    sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with actual hash
  };

  nativeBuildInputs = [ yarn nodejs makeWrapper git ];

  buildInputs = [ electron ];

  buildPhase = ''
    export HOME=$TMPDIR
    yarn install --frozen-lockfile
    yarn run build
  '';

  installPhase = ''
    mkdir -p $out/lib/gsender
    cp -r dist/gsender/* $out/lib/gsender/

    makeWrapper ${electron}/bin/electron $out/bin/gsender \
      --add-flags $out/lib/gsender/main.js \
      --prefix PATH : ${lib.makeBinPath [ nodejs ]}

    install -Dm644 electron-build/icon.png $out/share/pixmaps/gsender.png
    install -Dm644 $out/lib/gsender/package.json $out/share/applications/gsender.desktop
  '';

  meta = with lib; {
    description = "Electron sender for GRBL based CNC machines";
    homepage = "https://github.com/Sienci-Labs/gsender";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}