resource "aws_iam_role" "github" {
  name = "DevOpsNaNuvemWeekGitHubActionsRole"

  inline_policy {
    name = "DevOpsNaNuvemWeekGitHubActionsPolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ecr:GetAuthorizationToken"]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:GetDownloadUrlForLayer",
            "ecr:InitiateLayerUpload",
            "ecr:PutImage",
            "ecr:UploadLayerPart"
          ]
          Effect   = "Allow"
          Resource = aws_ecr_repository.these[*].arn
        },
      ]
    })
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"
      Principal = {
        Federated = "arn:aws:iam::968225077300:oidc-provider/token.actions.githubusercontent.com"
      }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:kenerry-serain/devops-na-nuvem-week-04-apps:*"
        }
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}
