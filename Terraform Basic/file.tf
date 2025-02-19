resource "local_file" "testing" {
  filename = "/home/ubuntu/terraform/test.txt"
  content = "This file will create a txt file"
}