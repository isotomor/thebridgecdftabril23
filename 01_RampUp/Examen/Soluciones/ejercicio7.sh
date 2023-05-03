#!/bin/bash
# fichero backup.sh
TIME=`date +%b-%d-%y`
FILENAME=backup-admfactory-$TIME.tar.gz
SRCDIR=/var/www/html .
DESDIR=/backup
tar -cpzf $DESDIR/$FILENAME $SRCDIR
# Y después usar crontabs

00 03 * * * /bin/bash /backup.sh