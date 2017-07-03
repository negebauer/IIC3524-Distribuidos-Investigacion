# Investigación HPC - Chapel

## Instalación

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

# Compilamos chapel
chapel_binary_build

# Probamos que haya compilado (con 2 hosts)
chapel_test

# Limpiar compilación
# chapel_binary_clear
```

## Uso

Una vez que cargamos los métodos de ayuda basta con usar los siguientes comandos para correr programas

```bash
chapel_b <programa>
# Compila el <programa> en <programa>.out

chapel_br <programa>
# Compila y corre <programa> en 2 nodos
# Los nodos se definen con la variable de entorno
# GASNET_SSH_SERVERS

chapel_br <programa> -nl <nodos>
# Compila y corre <programa> en la cantidad de nodos <nodos>
```
