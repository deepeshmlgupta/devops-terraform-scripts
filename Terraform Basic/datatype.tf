resource "local_file" "data-man" {
        filename = var.test_list[0]
        content = var.test_map["state1"]
}

resource "local_file" "data-var" {
        filename = var.test_list[1]
        content = join(",", var.fruit)
}

output "export_data" {
        value = var.export_testing
}

output "test_object" {
	value = var.test_object
}

output "test_json" {
	value = var.testby
}