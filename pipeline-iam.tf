resource "aws_iam_role" "codepipeline_role" {
  name = "OPA-Codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })  
}

/*
resource "aws_iam_role_policy" "codepipeline_policy"{
    name = "OPA-codepipeline-policy"
    role = aws_iam_role.codepipeline_role.id

    policy = jsonencode({
        Version = "2012-10-17"

        Statement = [
            {
                Effect = "Allow"

                Action = [
                    "codebuild:StartBuild",
                    "codebuild:BatChGetBuilds"
                ]

                Resource = 
            }
        ]
    })
}
*/

resource "aws_iam_role" "codebuild_role" {
  name = "OPA-Codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })  
}