resource "aws_key_pair" "this" {
  key_name = "apn-blog-operator"
  public_key = file("~/.ssh/id_rsa.pub")
}
