#!/bin/bash
# versión de Sebastian Nicolai
groupadd Desarrollo
groupadd Operaciones
groupadd Marketing

mkdir FileDev
mkdir FileOps
mkdir FileMark

useradd LuisBarcenas -g Operaciones
useradd RodriguesRato -g Marketing
useradd JordiPujol -g Desarrollo
useradd InakiUrdangarin -g Operaciones

chgrp -R Marketing FileMark/
chgrp -R Operaciones FileOps/
chgrp -R Desarrollo FileDev/

chmod 074 FileDev/
chmod 064 FileOps/
chmod 075 FileMark/
