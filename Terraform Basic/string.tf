resource "random_string" "rand-str" {
	length = 20
	special = true
	override_special = "!@#"
}

output "rand-str" {
	value = random_string.rand-str[*].result
}