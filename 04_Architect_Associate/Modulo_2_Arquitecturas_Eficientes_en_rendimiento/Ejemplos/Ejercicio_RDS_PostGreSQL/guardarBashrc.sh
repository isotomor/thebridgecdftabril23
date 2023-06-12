export PGHOST=$DBENDP
export PGUSER=$DBUSER
export PGPASSWORD="$DBPASS"

echo "export DBPASS=\"$DBPASS\"" >> /home/usuario/.bashrc
echo "export DBUSER=$DBUSER" >> /home/usuario/.bashrc
echo "export DBENDP=$DBENDP" >> /home/usuario/.bashrc
echo "export AWSREGION=$AWSREGION" >> /home/usuario/.bashrc
echo "export PGUSER=$DBUSER" >> /home/usuario/.bashrc
echo "export PGPASSWORD=\"$DBPASS\"" >> /home/usuario/.bashrc
echo "export PGHOST=$DBENDP" >> /home/usuario/.bashrc


