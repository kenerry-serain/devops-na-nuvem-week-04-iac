# resource "aws_route53_record" "alb" {
#   zone_id = data.aws_route53_zone.this.zone_id
#   name    = "devopsnanuvemweek.com"
#   type    = "A"

#   alias {
#     name                   = data.aws_lb.this.dns_name
#     zone_id                = data.aws_lb.this.zone_id
#     evaluate_target_health = true
#   }
# }