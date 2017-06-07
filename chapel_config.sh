# Config Chapel
export CHPL_COMM=gasnet
export CHPL_COMM_SUBSTRATE=ibv

# Build
cd $CHPL_HOME
make

# Config locales
export GASNET_SPAWNFN=S
export GASNET_SSH_SERVERS="localhost tripio titan caleuche trauco makemake" # localhost = hercules

# Test
chpl -o hello $CHPL_HOME/examples/hello6-taskpar-dist.chpl
./hello

