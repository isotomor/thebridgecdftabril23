using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;

Console.WriteLine("Ejemplo Azure Blob Storage\n");

// Run the examples asynchronously, wait for the results before proceeding
ProcessAsync().GetAwaiter().GetResult();

Console.WriteLine("Pulsar ENTER para salir.");
Console.ReadLine();

static async Task ProcessAsync()
{
    // Aquí cambiaremos CONNECTION STRING por la cadena de conexión que copiamos en 
	// la sección Claves de acceso de nuestra cuenta de almacenamiento
    string storageConnectionString = "CONNECTION STRING";

    // Crea un cliente que se pueda autententicar con la cadena de conexión
    BlobServiceClient blobServiceClient = new BlobServiceClient(storageConnectionString);

    // COPY EXAMPLE CODE BELOW HERE
	// Crea un nombre único para el contenedor
	string containerName = "wtblob" + Guid.NewGuid().ToString();

	// Crea el contenedor y devuelve el objeto container
	BlobContainerClient containerClient = await blobServiceClient.CreateBlobContainerAsync(containerName);
	Console.WriteLine("Se ha creado un contenedor llamado '" + containerName + " " +
		"\nVerificarlo en Azure Portal." + 
		"\nA continuación un fichero sera creado y subido al contenedor.");
	Console.WriteLine("Pulsar 'Enter' para continuar.");
	Console.ReadLine();
	
	// Crea un fichero en el directorio ./data/ para subir y descargar
	string localPath = "./data/";
	string fileName = "wtfile" + Guid.NewGuid().ToString() + ".txt";
	string localFilePath = Path.Combine(localPath, fileName);

	// Escribe texto en el fichero
	await File.WriteAllTextAsync(localFilePath, "Hola a todos!");

	// Obtiene una referencia para el blob
	BlobClient blobClient = containerClient.GetBlobClient(fileName);

	Console.WriteLine("Subiendo a Blob Storage como blog:\n\t {0}\n", blobClient.Uri);

	// Abre el archivo y sube los datos
	using FileStream uploadFileStream = File.OpenRead(localFilePath);
	await blobClient.UploadAsync(uploadFileStream, true);

	Console.WriteLine("\nEl fichero ha sido subido. Verificaremos listándolo" + 
			" el siguiente blob.");
	Console.WriteLine("Pulsar 'Enter' para continuar.");
	Console.ReadLine();
	
	// Muestra los blobs en el contenedor
	Console.WriteLine("Listando blobs...");
	await foreach (BlobItem blobItem in containerClient.GetBlobsAsync())
	{
		Console.WriteLine("\t" + blobItem.Name);
	}

	Console.WriteLine("\nTambién se puede verificar " + 
			"en Azure portal." +
			"\nA continuación vamos a descargar el blob con otro nombre.");
	Console.WriteLine("Pulsar 'Enter' para continuar.");
	Console.ReadLine();
	
	// Descarga un blob a un fichero local
	// Añade el sufijo "DOWNLOADED" antes de la extensión .txt
	string downloadFilePath = localFilePath.Replace(".txt", "DOWNLOADED.txt");

	Console.WriteLine("\nDescargando...\n\t{0}\n", downloadFilePath);

	// Descarga el contenido del bloby lo guarda en un archivo.
	BlobDownloadInfo download = await blobClient.DownloadAsync();

	using (FileStream downloadFileStream = File.OpenWrite(downloadFilePath))
	{
		await download.Content.CopyToAsync(downloadFileStream);
	}
	Console.WriteLine("\nEl fichero se encuentra en la carpeta data.");
	Console.WriteLine("A continuación borraremos el contenedor y los archivos.");
	Console.WriteLine("Pulsar 'Enter' para continuar.");
	Console.ReadLine();
	
	// Borra el contenedor y limpia los ficheros creados
	Console.WriteLine("\n\nBorrando en contenedor blob...");
	await containerClient.DeleteAsync();

	Console.WriteLine("Borrando el origen local y descargando archivos...");
	File.Delete(localFilePath);
	File.Delete(downloadFilePath);

	Console.WriteLine("Limpieza realizada.");
}