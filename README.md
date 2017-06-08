# Investigación HPC - Chapel

Para poder usar chapel lo primero que tenemos que hacer es cargar los métodos de ayuda
```bash
source ./chapel.sh
```

Estos nos permiten configurar chapel de manera sencilla

```bash
# Descargamos el binario
chapel_binary_download

# Expandemos el binario
chapel_binary_expand

# Si queremos cambiar sistema de comunicación
# export chapel_comm="comunicacion"
# Si queremos setear la lista de hosts
# export chapel_hosts="host1 host2"
# Seteamos variables de entorno
chapel_set_env

# Limpiamos compilacion anterior
# chapel_binary_clear

# Compilamos chapel
chapel_binary_build

# Probamos que haya compilado (con 2 hosts)
chapel_test
```
