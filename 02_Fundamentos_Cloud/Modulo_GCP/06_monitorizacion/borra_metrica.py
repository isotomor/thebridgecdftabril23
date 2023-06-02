from google.cloud import monitoring_v3

client = monitoring_v3.MetricServiceClient()
client.delete_metric_descriptor(name=descriptor_name)
print("Deleted metric descriptor {}.".format(descriptor_name))