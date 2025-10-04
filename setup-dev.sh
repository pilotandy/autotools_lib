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
sed -i "s/<library>/$LIBRARY_NAME/g" src/Makefile.am
mv src/library.h src/$LIBRARY_NAME.h
sed -i "s/<library>/$LIBRARY_NAME/g" src/library.cpp
mv src/library.cpp src/$LIBRARY_NAME.cpp

# Change the tests files
sed -i "s/<library>/$LIBRARY_NAME/g" tests/Makefile.am
sed -i "s/<library>/$LIBRARY_NAME/g" tests/test.cpp

# Change the configure.ac
sed -i "s/<library>/$LIBRARY_NAME/g" configure.ac
sed -i "s/<email>/$EMAIL/g" configure.ac

if [ -z "$3" ]; then
  # Rebuild setup-dev.sh
  echo "autoreconf --install" > setup-dev.sh
  echo "mkdir -p build" >> setup-dev.sh
  echo "pushd build" >> setup-dev.sh
  echo "CXXFLAGS=\"-g -O0\" ../configure" >> setup-dev.sh
  echo "popd" >> setup-dev.sh

  # Delete git and treat as new project
  git remote remove origin
  rm -rf .git
  git init
  git add .
  git commit -m "Initial commit for project: $LIBRARY_NAME"
fi

autoreconf --install
mkdir -p build
pushd build
CXXFLAGS="-g -O0" ../configure 
popd
