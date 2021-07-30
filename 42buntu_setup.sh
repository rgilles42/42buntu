# This script was intended to turn a text-only Ubuntu 18.04 installation,
# such as a one you would have with the corresponding WSL package, into a
# 42-compliant work and evaluation station, more practical than the VM
# (better clang aliasing, updated python by default, norminette v3...)
#
# You'll most probably still need a VM in order to run graphical projects.
#
# This script is largely based on aguiot--'s VM_install.sh available here:
# https://github.com/alexandregv/remote-42/blob/master/VM_install.sh

# Make sure USER variabe is set
[ -z "${USER}" ] && export USER=$(whoami)

# Install packages
sudo apt-get update
sudo apt-get install -y \
  as31                  \
  autoconf              \
  build-essential       \
  clang-9               \
  cmake                 \
  curl                  \
  emacs                 \
  freeglut3             \
  g++                   \
  gcc                   \
  git                   \
  glmark2               \
  libbsd-dev            \
  libbz2-dev            \
  libffi-dev            \
  liblzma-dev           \
  libncurses5-dev       \
  libreadline-dev       \
  libsqlite3-dev        \
  libssl-dev            \
  libx11-dev            \
  libxext-dev           \
  libxml2-dev           \
  libxmlsec1-dev        \
  libxt-dev             \
  lldb                  \
  llvm                  \
  make                  \
  nasm                  \
  binutils              \
  binfmt-support        \
  binutils-doc          \
  python3-pip           \
  python3.7             \
  qemu-kvm              \
  redis                 \
  sqlite3               \
  sudo                  \
  valgrind              \
  vim                   \
  wget                  \
  x11proto-core-dev     \
  xz-utils              \
  zlib1g-dev            \
  zsh                   \

# Make python3.7 default while keeping apt_pkg working
sudo ln -sf /usr/bin/python3.7 /usr/bin/python3
sudo ln -sf /usr/bin/python3 /usr/bin/python
sudo ln -sf /usr/lib/python3/dist-packages/apt_pkg.cpython-36m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so
sudo ln -sf /usr/lib/python3/dist-packages/apt_inst.cpython-36m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_inst.so

# Link clang*-9 to clang* to avoid having to use clang6 like in the VM (a simple alias in ~/.zshrc doesn't work outside of zsh)
sudo ln -sf /usr/bin/clang-9 /usr/bin/clang
sudo ln -sf /usr/bin/clang++-9 /usr/bin/clang++

# Link gcc to clang to reflect mac behavior (idem)
sudo ln -sf /usr/bin/clang /usr/bin/gcc

# Change default shell to zsh
chsh -s /bin/zsh

# Install Norminette V3
python -m pip install --upgrade pip setuptools
python -m pip install norminette
echo "alias 'norminette'='python -m norminette'" >> ~/.zshrc

# Install 42header vim plugin
mkdir -p ~/.vim/plugin/
curl -o ~/.vim/plugin/stdheader.vim https://raw.githubusercontent.com/42Paris/42header/master/vim/stdheader.vim
echo "export USER='$USER'" >> ~/.zshrc
echo "export MAIL='$USER@student.42.fr'" >> ~/.zshrc

# Initialise git identity
git config --global user.name $USER
git config --global user.email $USER@student.42.fr
