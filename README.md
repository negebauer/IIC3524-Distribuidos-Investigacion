# Investigación HPC - Chapel

Para poder usar chapel lo primero que tenemos que hacer es cargar los métodos de ayuda
```bash
source ./chapel.sh
```

Estos nos permiten configurar chapel de manera sencilla  
Empezar desde 0  
```bash
chapel_full_install
```

```bash
# Descargamos el binario
chapel_binary_download

# Expandemos el binario
chapel_binary_expand

# Si queremos cambiar sistema de comunicación agregamos
# chapel_comm="comunicacion"
# antes de chapel_set_env

# Si queremos setear la lista de hosts agregamos
# chapel_hosts="host1 host2"
# antes de chapel_set_env

# Seteamos variables de entorno
chapel_set_env

# Limpiamos compilacion anterior
# chapel_binary_clear

# Compilamos chapel
chapel_binary_build

# Probamos que haya compilado (con 2 hosts)
chapel_test
```
