if [ -z "$1" ]; then
  echo "Error: The library name and email are required." >&2
  echo "Usage: $0 <library name> <email>" >&2
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: The email is required." >&2
  echo "Usage: $0 <library name> <email>" >&2
  exit 1
fi

LIBRARY_NAME="$1";
EMAIL="$2";

# Change the src files
sed -i "s/<library>/$LIBRARY_NAME/" src/Makefile.am
mv src/library.h $LIBRARY_NAME.h
sed -i "s/<library>/$LIBRARY_NAME/" src/library.cpp
mv src/library.cpp $LIBRARY_NAME.cpp

# Change the tests files
sed -i "s/<library>/$LIBRARY_NAME/" tests/Makefile.am
sed -i "s/<library>/$LIBRARY_NAME/" tests/test.cpp

# Change the configure.ac
sed -i "s/<library>/$LIBRARY_NAME/" configure.ac
sed -i "s/<email>/$EMAIL/" configure.ac

autoreconf --install
mkdir -p build
pushd build
CXXFLAGS="-g -O0" ../configure 
popd