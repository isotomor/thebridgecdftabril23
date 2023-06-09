from google.cloud import compute_v1


def create_template(project_id: str, template_name: str) -> compute_v1.InstanceTemplate:
    """
    Create a new instance template with the provided name and a specific
    instance configuration.
    Args:
        project_id: project ID or project number of the Cloud project you use.
        template_name: name of the new template to create.
    Returns:
        InstanceTemplate object that represents the new instance template.
    """
    # The template describes the size and source image of the boot disk
    # to attach to the instance.
    disk = compute_v1.AttachedDisk()
    initialize_params = compute_v1.AttachedDiskInitializeParams()
    initialize_params.source_image = (
        "projects/debian-cloud/global/images/family/debian-11"
    )
    initialize_params.disk_size_gb = 10
    disk.initialize_params = initialize_params
    disk.auto_delete = True
    disk.boot = True

    # The template connects the instance to the `default` network,
    # without specifying a subnetwork.
    network_interface = compute_v1.NetworkInterface()
    network_interface.name = "global/networks/default"

    # The template lets the instance use an external IP address.
    access_config = compute_v1.AccessConfig()
    access_config.name = "External NAT"
    access_config.type_ = "ONE_TO_ONE_NAT"
    access_config.network_tier = "PREMIUM"
    network_interface.access_configs = [access_config]

    template = compute_v1.InstanceTemplate()
    template.name = template_name
    template.properties.disks = [disk]
    template.properties.machine_type = "e2-standard-4"
    template.properties.network_interfaces = [network_interface]

    template_client = compute_v1.InstanceTemplatesClient()
    operation_client = compute_v1.GlobalOperationsClient()
    op = template_client.insert_unary(
        project=project_id, instance_template_resource=template
    )
    operation_client.wait(project=project_id, operation=op.name)

    return template_client.get(project=project_id, instance_template=template_name)

plantilla = create_template("instancias-344608","miplantillita")