PYQT=$TRAVIS_BUILD_DIR/pyqt

SIP_VERSION=4.19.6
PYQT_VERSION=5.8.1

sudo add-apt-repository --yes ppa:ubuntu-sdk-team/ppa
sudo apt-get update -qq
sudo apt-get install -qq libqt5webkit5-dev qtdeclarative5-dev
export QMAKE=/usr/lib/x86_64-linux-gnu/qt5/bin/qmake

mkdir -p $PYQT
cd $PYQT

wget -O sip.tar.gz http://sourceforge.net/projects/pyqt/files/sip/sip-$SIP_VERSION/sip-$SIP_VERSION.tar.gz
mkdir -p sip
tar xzf sip.tar.gz -C sip --strip-component=1

wget -O PyQt.tar.gz  http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-$PYQT_VERSION/PyQt5_gpl-$PYQT_VERSION.tar.gz
mkdir -p PyQt
tar xzf PyQt.tar.gz -C PyQt --strip-components=1

cd $PYQT/sip
python configure.py -e $PYQT/include
make
make install

cd $PYQT/PyQt
pwd
python configure.py --confirm-license --no-designer-plugin
make

cd $PYQT/sip
make install

cd $PYQT/PyQt
make install