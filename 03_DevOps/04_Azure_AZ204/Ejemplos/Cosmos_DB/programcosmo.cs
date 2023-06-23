using Microsoft.Azure.Cosmos;

public class Program
{
    // Replace <documentEndpoint> with the information created earlier
    private static readonly string EndpointUri = "https://micosmodb-westeurope.documents.azure.com:443/";

    // Set variable to the Primary Key from earlier.
    private static readonly string PrimaryKey = "xISyUfecY3pb90l36oWEtrd40mx1NRWuH9SINjUKYAzRvAg8GfBKdNLlEe1HbmwC7L5BlC1qwWYTACDbhf8GwA==";

    // The Cosmos client instance
    private CosmosClient cosmosClient;

    // The database we will create
    private Database database;

    // The container we will create.
    private Container container;

    // The names of the database and container we will create
    private string databaseId = "az204Database";
    private string containerId = "az204Container";

    public static async Task Main(string[] args)
    {
        try
        {
            Console.WriteLine("Beginning operations...\n");
            Program p = new Program();
            await p.CosmosAsync();

        }
        catch (CosmosException de)
        {
            Exception baseException = de.GetBaseException();
            Console.WriteLine("{0} error occurred: {1}", de.StatusCode, de);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: {0}", e);
        }
        finally
        {
            Console.WriteLine("End of program, press any key to exit.");
            Console.ReadKey();
        }
    }
    
	// crea un nuevo cliente
	public async Task CosmosAsync()
	{
		// Create a new instance of the Cosmos Client
		this.cosmosClient = new CosmosClient(EndpointUri, PrimaryKey);

		// Runs the CreateDatabaseAsync method
		await this.CreateDatabaseAsync();

		// Run the CreateContainerAsync method
		await this.CreateContainerAsync();
	}
	
	// crea una nueva base de datos
	private async Task CreateDatabaseAsync()
	{
		// Create a new database using the cosmosClient
		this.database = await this.cosmosClient.CreateDatabaseIfNotExistsAsync(databaseId);
		Console.WriteLine("Created Database: {0}\n", this.database.Id);
	}
	
	// crea un contenedor
	private async Task CreateContainerAsync()
	{
		// Create a new container
		this.container = await this.database.CreateContainerIfNotExistsAsync(containerId, "/LastName");
		Console.WriteLine("Created Container: {0}\n", this.container.Id);
	}
	
}

