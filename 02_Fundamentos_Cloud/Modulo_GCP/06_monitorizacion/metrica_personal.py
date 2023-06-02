from google.api import label_pb2 as ga_label
from google.api import metric_pb2 as ga_metric
from google.cloud import monitoring_v3

project_id="instancias-344608"
client = monitoring_v3.MetricServiceClient()
project_name = f"projects/{project_id}"
descriptor = ga_metric.MetricDescriptor()
descriptor.type = "custom.googleapis.com/instance/cpu/utilization" # + str(uuid.uuid4())
descriptor.metric_kind = ga_metric.MetricDescriptor.MetricKind.GAUGE
descriptor.value_type = ga_metric.MetricDescriptor.ValueType.DOUBLE
descriptor.description = "This is a simple example of a custom metric."

labels = ga_label.LabelDescriptor()
labels.key = "TestLabel"
labels.value_type = ga_label.LabelDescriptor.ValueType.STRING
labels.description = "This is a test label"
descriptor.labels.append(labels)

descriptor = client.create_metric_descriptor(
    name=project_name, metric_descriptor=descriptor
)
print("Created {}.".format(descriptor.name))