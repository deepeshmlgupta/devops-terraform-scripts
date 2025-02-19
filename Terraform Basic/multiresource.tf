#this resource will add a txt file named demo.txt
resource "local_file" "textfile" {
        filename = "/home/ubuntu/Day3/demo.txt"
        content = "This the example for multi0-resource"
}


#this file will create a random string
resource "random_string" "rand-str" {
        length = 20
        special = true
        override_special = "!@#"
}

output "rand-str" {
        value = random_string.rand-str[*].result
}
