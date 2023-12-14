autoreconf --install
mkdir -p build
pushd build
CXXFLAGS="-g -O0" ../configure 
popd