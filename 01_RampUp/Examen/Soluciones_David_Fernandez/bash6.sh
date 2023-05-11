#! /bin/bash

# Creamos tres carpets y después navegamos entre ellas y creamos dos archivos de texto en cada una
mkdir FileDev FileOps FileMark
cd FileDev
touch archivo1.txt archivo2.txt
cd ..
cd FileOps
touch archivo1.txt archivo2.txt
cd ..
cd FileMark
touch archivo1.txt archivo2.txt
cd ..

# Asigno permisos a las carpetas
sudo chmod 774 /home/vinxu/FileDev
sudo chmod 774 /home/vinxu/FileOps
sudo chmod 775 /home/vinxu/FileMark

# Creamos tres grupos de usuarios
sudo groupadd Desarrollo
sudo groupadd Marketing
sudo groupadd Operaciones

# Creamos cuatro usuarios con su carpeta en 'home' y le asignamos una contraseña a cada uno
sudo useradd -s /bin/bash -d /home/carlos/ -m -G sudo Carlos
sudo passwd Carlos

sudo useradd -s /bin/bash -d /home/marta/ -m -G sudo Marta
sudo passwd Marta

sudo useradd -s /bin/bash -d /home/alex/ -m -G sudo Alex
sudo passwd Alex

sudo useradd -s /bin/bash -d /home/laia/ -m -G sudo Laia
sudo passwd Laia

# Asigno los usuarios a los diferentes grupos
sudo usermod -aG Desarollo Carlos
sudo usermod -aG Desarollo Marta
sudo usermod -aG Marketing Alex
sudo usermod -aG Operaciones Laia

# Hago propietario al grupo Desarrollo de la carpeta FileDev, 
#de este moodo tiene todos los permisos
sudo chown :Desarollo /home/vinxu/examen/FileDev

# Hago propietario al grupo Marketing de la carpeta FileMark,
#de este moodo tiene todos los permisos
sudo chown :Marketing /home/vinxu/examen/FileMark