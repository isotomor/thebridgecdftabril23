# [START gke_create_cluster]
import argparse
import sys
from typing import Dict

import backoff
from google.cloud import container_v1


def on_success(details: Dict[str, str]) -> None:
    """
    A handler function to pass into the retry backoff algorithm as the function
    to be executed upon a successful attempt.
    Read the `Event handlers` section of the backoff python module at:
    https://pypi.org/project/backoff/
    """
    print("Successfully created cluster after {elapsed:0.1f} seconds".format(**details))


def on_failure(details: Dict[str, str]) -> None:
    """
    A handler function to pass into the retry backoff algorithm as the function
    to be executed upon a failed attempt.
    Read the `Event handlers` section of the backoff python module at:
    https://pypi.org/project/backoff/
    """
    print("Backing off {wait:0.1f} seconds after {tries} tries".format(**details))


@backoff.on_predicate(
    # the backoff algorithm to use. we use exponential backoff here
    backoff.expo,
    # the test function on the return value to determine if a retry is necessary
    lambda x: x != container_v1.Operation.Status.DONE,
    # maximum number of times to retry before giving up
    max_tries=20,
    # function to execute upon a failure and when a retry a scheduled
    on_backoff=on_failure,
    # function to execute upon a successful attempt and no more retries needed
    on_success=on_success,
)
def poll_for_op_status(
    client: container_v1.ClusterManagerClient, op_id: str
) -> container_v1.Operation.Status:
    """
    This function calls the Operation API in GCP with the given operation id. It
    serves as a simple retry function that fetches the operation and returns
    it's status.
    We use the 'backoff' python module to provide us the implementation of the
    backoff & retry strategy. The function is annotated with the `backoff`
    python module to schedule this function based on a reasonable backoff
    algorithm.
    """

    op = client.get_operation({"name": op_id})
    return op.status


def create_cluster(project_id: str, location: str, cluster_name: str) -> None:
    """Create a new GKE cluster in the given GCP Project and Zone"""
    # Initialize the Cluster management client.
    client = container_v1.ClusterManagerClient()
    # Create a fully qualified location identifier of form `projects/{project_id}/location/{zone}'.
    cluster_location = client.common_location_path(project_id, location)
    cluster_def = {
        "name": cluster_name,
        "initial_node_count": 2,
        "node_config": {"machine_type": "e2-standard-2"},
    }
    # Create the request object with the location identifier.
    request = {"parent": cluster_location, "cluster": cluster_def}
    create_response = client.create_cluster(request)
    op_identifier = f"{cluster_location}/operations/{create_response.name}"
    # poll for the operation status and schedule a retry until the cluster is created
    poll_for_op_status(client, op_identifier)


# [END gke_create_cluster]

if __name__ == "__main__":

    create_cluster("instancias-344608", "europe-west1", "miclustercitoquerido")