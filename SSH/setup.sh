set -e
set -u
git clone https://github.com/mkj/dropbear.git 
mkdir DROP
cd dropbear
export CFLAGS="-DDEBUG_TRACE=5"
export CXXFLAGS="-DDEBUG_TRACE=5"
# Allows us to move the home folder
git apply ../homefolder.patch
./configure --prefix=$(realpath ../DROP ) 
make -j 10 
make install
