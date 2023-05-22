#!/usr/bin/env sh
# $0 es el nombre del script, 
# $1, $2, $3 etc son pasados como argumentos  # $1 es nuestro comando.
CMD=$1
  
case "$CMD" in  
    "dev" ) 
		npm install 
		export NODE_ENV=development 
		exec npm run dev 
		;;
		
	"start" ) 
	  
	echo  "db: $DATABASE_ADDRESS" >> /app/config.yml 
	export NODE_ENV=production 
	exec npm start 
	;;

	* ) 
	
	 exec $CMD ${@:2} 
	 ;; 
esac