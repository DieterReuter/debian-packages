debian-packages
===============

Some basic tests to easily create DEBIAN packages .deb


Here you'll find a cool blog about easy creating a .deb package with minimal effort:
https://blog.serverdensity.com/how-to-create-a-debian-deb-package/


# 1. Prerequisites 
Install all needed packages
```bash
./install-dependencies.sh
```

# 2. Build the package
```bash
./build-deb.sh
```

# 3. Test the package
Extract the complete package to a local `test` directory
```bash
./test-deb.sh
```

# Have fun builing your own packages!

