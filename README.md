# Terraform AWS APN Blog

Deployement on AWS with Terraform training.

## Checks

* Get your IP
* make sur you have a key at `~/.ssh/id_rsa.pub`

## Provisionning

```bash
terraform validate
terraform apply -var="iprange=1.2.3.4/32"
```

## Destroying

```bash
terraform destroy
```

## License

The source is here: https://github.com/aws-samples/apn-blog
