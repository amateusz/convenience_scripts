sudo usermod -aG audio $USER
NAME=shairport-sync
sudo apt install \
  git build-essential xmltoman autoconf automake libtool libdaemon-dev libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libmbedtls-dev libsoxr-dev 
git clone https://github.com/mikebrady/shairport-sync.git
cd $NAME
autoreconf -i -f
./configure --sysconfdir=/etc --with-alsa --with-avahi --with-ssl=mbedtls --with-metadata --with-soxr --with-systemd
make
sudo make install
sudo systemctl enable shairport-sync
sudo systemctl start shairport-sync
